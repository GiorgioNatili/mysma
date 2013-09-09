<?php

class Theme_Admin_DefaultModel extends TB_ExtensionModel
{
    public function getProducts($data = array(), $added_ids = array())
    {
        if ($data) {
            $added_ids[] = 0;
            $sql = "SELECT IF( p.product_id IN ( " . implode(',', (array) $added_ids) . " ) ,  '1',  '0' ) AS added, p . * , pd . *
                    FROM " . DB_PREFIX . "product p
                    LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)
                    INNER JOIN " . DB_PREFIX . "product_to_store AS pts ON p.product_id = pts.product_id AND pts.store_id = " . $this->context->getStoreId() . "
                    WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "'";

            if (isset($data['filter_name']) && !is_null($data['filter_name'])) {
                $sql .= " AND LCASE(pd.name) LIKE '%" . $this->db->escape(strtolower($data['filter_name'])) . "%'";
            }

            if (isset($data['filter_model']) && !is_null($data['filter_model'])) {
                $sql .= " AND LCASE(p.model) LIKE '%" . $this->db->escape(strtolower($data['filter_model'])) . "%'";
            }

            if (isset($data['filter_price_less']) && !is_null($data['filter_price_less'])) {
                $sql .= " AND p.price < '" . $this->db->escape($data['filter_price_less']) . "'";
            }

            if (isset($data['filter_price_more']) && !is_null($data['filter_price_more'])) {
                $sql .= " AND p.price > '" . $this->db->escape($data['filter_price_more']) . "'";
            }

            if (isset($data['filter_price_equals']) && !is_null($data['filter_price_equals'])) {
                $sql .= " AND p.price = '" . $this->db->escape($data['filter_price_equals']) . "'";
            }

            if (isset($data['filter_selected']) && !is_null($data['filter_selected'])) {
                $sql .= " AND p.product_id IN ( " . implode(',', (array) $added_ids) . " )";
            }

            $sort_data = array(
                'pd.name',
                'p.model',
                'p.price',
                'p.sort_order',
                'added'
            );

            if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
                $sql .= " ORDER BY " . $data['sort'];
            } else {
                $sql .= " ORDER BY pd.name";
            }

            if (isset($data['order']) && ($data['order'] == 'DESC')) {
                $sql .= " DESC";
            } else {
                $sql .= " ASC";
            }

            if (isset($data['start']) || isset($data['limit'])) {
                if ($data['start'] < 0) {
                    $data['start'] = 0;
                }

                if ($data['limit'] < 1) {
                    $data['limit'] = 20;
                }

                $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
            }

            $query = $this->db->query($sql);

            return $query->rows;
        } else {
            $product_data = $this->cache->get('product.' . $this->config->get('config_language_id'));

            if (!$product_data) {
                $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY pd.name ASC");

                $product_data = $query->rows;

                $this->cache->set('product.' . $this->config->get('config_language_id'), $product_data);
            }

            return $product_data;
        }
    }

    public function getTotalProducts($data = array(), $added_ids = array())
    {
        $sql = "SELECT COUNT(DISTINCT p.product_id) AS total
                FROM " . DB_PREFIX . "product p
                LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)
                INNER JOIN " . DB_PREFIX . "product_to_store AS pts ON p.product_id = pts.product_id AND pts.store_id = " . $this->context->getStoreId();

        if (!empty($data['filter_category_id'])) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";
        }

        $sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

        if (isset($data['filter_name']) && !is_null($data['filter_name'])) {
            $sql .= " AND LCASE(pd.name) LIKE '%" . $this->db->escape(strtolower($data['filter_name'])) . "%'";
        }

        if (isset($data['filter_model']) && !is_null($data['filter_model'])) {
            $sql .= " AND LCASE(p.model) LIKE '%" . $this->db->escape(strtolower($data['filter_model'])) . "%'";
        }

        if (isset($data['filter_price_less']) && !is_null($data['filter_price_less'])) {
            $sql .= " AND p.price < '" . $this->db->escape($data['filter_price_less']) . "'";
        }

        if (isset($data['filter_price_more']) && !is_null($data['filter_price_more'])) {
            $sql .= " AND p.price > '" . $this->db->escape($data['filter_price_more']) . "'";
        }

        if (isset($data['filter_price_equals']) && !is_null($data['filter_price_equals'])) {
            $sql .= " AND p.price = '" . $this->db->escape($data['filter_price_equals']) . "'";
        }

        if (isset($data['filter_selected']) && !is_null($data['filter_selected'])) {
            $sql .= " AND p.product_id IN ( " . implode(',', (array) $added_ids) . " )";
        }

        $query = $this->db->query($sql);

        return $query->row['total'];
    }
}
