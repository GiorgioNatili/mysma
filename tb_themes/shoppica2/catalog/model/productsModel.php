<?php

class Theme_Catalog_ProductsModel extends TB_ExtensionModel
{
    public function getProductsById($product_ids)
    {
        $ids = (array) $product_ids;
        if (empty($ids)) {

            return false;
        }

        if ($this->context->customer->isLogged()) {
          $customer_group_id = (int) $this->context->customer->getCustomerGroupId();
        } else {
          $customer_group_id = (int) $this->config->get('config_customer_group_id');
        }

        $ids = implode(',', $ids);
        $sql = "SELECT p.product_id, p.image, p.price, p.tax_class_id, p.model, p.quantity, p.date_available,
                       pd.name, pd.name, pd.description, pd.meta_description,
                       m.name AS manufacturer,
                       (SELECT price
                        FROM " . DB_PREFIX . "product_discount AS pd2
                        WHERE pd2.product_id = p.product_id
                            AND pd2.customer_group_id = '" . $customer_group_id . "'
                            AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW())
                            AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW()))
                        ORDER BY pd2.priority ASC, pd2.price ASC
                        LIMIT 1) AS discount,
                        (SELECT price
                         FROM " . DB_PREFIX . "product_special AS ps
                         WHERE ps.product_id = p.product_id
                            AND ps.customer_group_id = '" . $customer_group_id . "'
                            AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW())
                            AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()))
                         ORDER BY ps.priority ASC, ps.price ASC
                         LIMIT 1) AS special,
                        (SELECT AVG(rating) AS total
                         FROM " . DB_PREFIX . "review r1
                         WHERE r1.product_id = p.product_id
                            AND r1.status = '1'
                            GROUP BY r1.product_id) AS rating
                FROM "       . DB_PREFIX . 'product AS p
                INNER JOIN ' . DB_PREFIX . 'product_description AS pd ON p.product_id = pd.product_id
                INNER JOIN ' . DB_PREFIX . 'product_to_store p2s ON p.product_id = p2s.product_id
                LEFT JOIN '  . DB_PREFIX . 'manufacturer AS m ON (p.manufacturer_id = m.manufacturer_id)
                WHERE p.product_id IN (' . $ids . ')
                      AND pd.language_id = ' . (int) $this->config->get('config_language_id') . '
                      AND p.status = 1
                      AND p.date_available <= NOW()
                      AND p2s.store_id = ' . (int) $this->config->get('config_store_id');
        $query = $this->db->query($sql);

        if (!$query->num_rows) {
            return false;
        }

        $result = array();
        foreach ($query->rows as $row) {
            $product = array(
                'id'               => $row['product_id'],
                'product_id'       => $row['product_id'],
                'name'             => $row['name'],
                'description'      => $row['description'],
                'meta_description' => $row['meta_description'],
                'model'            => $row['model'],
                'quantity'         => $row['quantity'],
                'image'            => $row['image'],
                'manufacturer'     => $row['manufacturer'],
                'price'            => ($row['discount'] ? $row['discount'] : $row['price']),
                'special'          => $row['special'],
                'tax_class_id'     => $row['tax_class_id'],
                'date_available'   => $row['date_available'],
                'rating'           => (int) $row['rating']
            );
            $result[] = $product;
        }

        return $result;
    }

    public function getTotalProductsByManufacturerAndCategory($manufacturer_id, $category_id)
    {
        $children_ids = $this->tbExtension->getModel('category')->getCategoryChildrenIds($category_id);
        $ids = array_merge($children_ids, (array) $category_id);
        $sql = "SELECT COUNT(DISTINCT(p.product_id)) AS total
                FROM "       . DB_PREFIX . "product AS p
                INNER JOIN " . DB_PREFIX . "product_to_category AS p2c ON p2c.product_id = p.product_id AND p2c.category_id IN(" . implode(',', $ids) . ")
                LEFT JOIN "  . DB_PREFIX . "product_to_store p2s ON p.product_id = p2s.product_id
                WHERE p.status = '1' AND p.date_available <= NOW() AND p.manufacturer_id = '" . (int) $manufacturer_id . "'";
        $query = $this->db->query($sql);

        return $query->row['total'];
    }

    public function getProductsByManufacturerAndCategory($manufacturer_id, $category_id, $sort = 'p.sort_order', $order = 'ASC', $start = 0, $limit = 20)
    {
        $children_ids = $this->tbExtension->getModel('category')->getCategoryChildrenIds($category_id);
        $ids = array_merge($children_ids, (array) $category_id);

        $customer_group_id = $this->tbExtension->getModel()->getCustomerGroupId();

        $sql = "SELECT DISTINCT(p.product_id), p.image, p.price, p.tax_class_id, p.model, p.quantity, p.date_available,
                       pd.name, pd.name, pd.description, pd.meta_description,
                       m.manufacturer_id, m.name AS manufacturer,
                       (SELECT price
                        FROM " . DB_PREFIX . "product_discount AS pd2
                        WHERE pd2.product_id = p.product_id
                            AND pd2.customer_group_id = '" . $customer_group_id . "'
                            AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW())
                            AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW()))
                        ORDER BY pd2.priority ASC, pd2.price ASC
                        LIMIT 1) AS discount,
                        (SELECT price
                         FROM " . DB_PREFIX . "product_special AS ps
                         WHERE ps.product_id = p.product_id
                            AND ps.customer_group_id = '" . $customer_group_id . "'
                            AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW())
                            AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()))
                         ORDER BY ps.priority ASC, ps.price ASC
                         LIMIT 1) AS special,
                        (SELECT AVG(rating) AS total
                         FROM " . DB_PREFIX . "review r1
                         WHERE r1.product_id = p.product_id AND r1.status = '1'
                         GROUP BY r1.product_id) AS rating
                FROM "       . DB_PREFIX . "product p
                INNER JOIN " . DB_PREFIX . "product_to_category AS p2c ON p2c.product_id = p.product_id AND p2c.category_id IN(" . implode(',', $ids) . ")
                LEFT JOIN "  . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)
                LEFT JOIN "  . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)
                LEFT JOIN "  . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id)
                LEFT JOIN "  . DB_PREFIX . "stock_status ss ON (p.stock_status_id = ss.stock_status_id) AND ss.language_id = '" .    (int) $this->config->get('config_language_id') . "'
                WHERE p.status = '1'
                      AND p.date_available <= NOW()
                      AND pd.language_id = '" .    (int) $this->config->get('config_language_id') . "'
                      AND p2s.store_id = '" .      (int) $this->config->get('config_store_id') . "'
                      AND m.manufacturer_id = '" . (int) $manufacturer_id. "'";

        $sort_data = array(
            'p.product_id',
            'pd.name',
            'p.sort_order',
            'special',
            'rating',
            'p.price',
            'p.model'
        );

        if (in_array($sort, $sort_data)) {
            if ($sort == 'pd.name' || $sort == 'p.model') {
                $sql .= " ORDER BY LCASE(" . $sort . ")";
            } else {
                $sql .= " ORDER BY " . $sort;
            }
        } else {
            $sql .= " ORDER BY p.sort_order";
        }

        if ($order == 'DESC') {
            $sql .= " DESC";
        } else {
            $sql .= " ASC";
        }

        if ($start < 0) {
            $start = 0;
        }

        $sql .= " LIMIT " . (int)$start . "," . (int)$limit;

        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function getSorts($url)
    {
        $sorts = array();

        $language = $this->registry->get('language');
        $language->load('product/category');

        $sorts[] = array(
            'text'  => $language->get('text_default'),
            'value' => 'p.sort_order-ASC',
            'href'  => $url . '&sort=p.sort_order&order=ASC'
        );

        $sorts[] = array(
            'text'  => $language->get('text_name_asc'),
            'value' => 'pd.name-ASC',
            'href'  => $url . '&sort=pd.name&order=ASC'
        );

        $sorts[] = array(
            'text'  => $language->get('text_name_desc'),
            'value' => 'pd.name-DESC',
            'href'  => $url . '&sort=pd.name&order=DESC'
        );

        $sorts[] = array(
            'text'  => $language->get('text_price_asc'),
            'value' => 'p.price-ASC',
            'href'  => $url . '&sort=p.price&order=ASC'
        );

        $sorts[] = array(
            'text'  => $language->get('text_price_desc'),
            'value' => 'p.price-DESC',
            'href'  => $url . '&sort=p.price&order=DESC'
        );

        $sorts[] = array(
            'text'  => $language->get('text_rating_desc'),
            'value' => 'rating-DESC',
            'href'  => $url . '&sort=rating&order=DESC'
        );

        $sorts[] = array(
            'text'  => $language->get('text_rating_asc'),
            'value' => 'rating-ASC',
            'href'  => $url . '&sort=rating&order=ASC'
        );

        $sorts[] = array(
            'text'  => $language->get('text_model_asc'),
            'value' => 'p.model-ASC',
            'href'  => $url . '&sort=p.model&order=ASC'
        );

        $sorts[] = array(
            'text'  => $language->get('text_model_desc'),
            'value' => 'p.model-DESC',
            'href'  => $url . '&sort=p.model&order=DESC'
        );

        return $sorts;
    }

    public function getLimits($url)
    {
        $limits = array();

        $language = $this->registry->get('language');
        $language->load('product/category');

        $limits[] = array(
            'text'  => $this->config->get('config_catalog_limit'),
            'value' => $this->config->get('config_catalog_limit'),
            'href'  => $url . '&limit=' . $this->config->get('config_catalog_limit')
        );

        $limits[] = array(
            'text'  => 25,
            'value' => 25,
            'href'  => $url . '&limit=25'
        );

        $limits[] = array(
            'text'  => 50,
            'value' => 50,
            'href'  => $url . '&limit=50'
        );

        $limits[] = array(
            'text'  => 75,
            'value' => 75,
            'href'  => $url . '&limit=75'
        );

        $limits[] = array(
            'text'  => 100,
            'value' => 100,
            'href'  => $url . '&limit=100'
        );

        return $limits;
    }
}