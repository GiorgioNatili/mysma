<?php

class Theme_Catalog_DefaultModel extends TB_ExtensionModel
{
    public function getIntroData($config)
    {
        $data = array();
        switch ($config['type']) {
            case 'products' :
                $products = array();
                if (isset($config['products']['ids']) && !empty($config['products']['ids'])) {
                    $products = $this->tbExtension->getModel('products')->getProductsById($config['products']['ids']);
                }
                if (empty($products)) {
                    return false;
                }

                if (!isset($config['products']['text_source'])) {
                    $config['products']['text_source'] = 'details';
                }

                foreach ($products as &$product) {
                    if ($config['products']['text_source'] == 'details') {
                        $product['description'] = strip_tags(html_entity_decode($product['description'], ENT_QUOTES, 'UTF-8'));
                    } else
                    if ($config['products']['text_source'] == 'metadesc') {
                        $product['description'] = $product['meta_description'];
                    } else
                    if ($config['products']['text_source'] == 'combined') {
                        if (!empty($product['meta_description'])) {
                            $product['description'] = $product['meta_description'];
                        } else {
                            $product['description'] = strip_tags(html_entity_decode($product['description'], ENT_QUOTES, 'UTF-8'));
                        }
                    }

                    if ($product['image']) {
                        $imageModel = $this->tbManager->getOcModel('tool/image');
                        switch ($config['products']['size']) {
                            case '3':
                                $product['image'] = $imageModel->resize($product['image'], 300, 300);
                                break;
                            case '2':
                                $product['image'] = $imageModel->resize($product['image'], 250, 250);
                                break;
                            case '1':
                                $product['image'] = $imageModel->resize($product['image'], 200, 200);
                                break;
                        }
                    } else {
                        $product['image'] = false;
                    }

                    if (($this->config->get('config_customer_price') && $this->context->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                        $product['price'] = $this->context->currency->format($this->context->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')));
                    } else {
                        $product['price'] = false;
                    }

                    if ((float) $product['special']) {
                        $product['special'] = $this->context->currency->format($this->context->tax->calculate($product['special'], $product['tax_class_id'], $this->config->get('config_tax')));
                    } else {
                        $product['special'] = false;
                    }

                    if ($this->config->get('config_tax')) {
                        $product['tax'] = $this->context->currency->format((float) $product['special'] ? $product['special'] : $product['price']);
                    } else {
                        $product['tax'] = false;
                    }

                    if ($this->config->get('config_review_status')) {
                        $product['rating'] = (int) $product['rating'];
                    } else {
                        $product['rating'] = false;
                    }
                }

                $data = array_merge($data, $config['products']);
                $data['products'] = $products;
            break;

            case 'images':
                $language = $this->getCurrentLanguage();
                $images = isset($config['images']) ? $config['images'] : array();
                if (isset($images[$language['id']]) && isset($images[$language['id']]['files'])) {
                    $data['intro_images'] = $images[$language['language_id']];
                    foreach ($data['intro_images']['files'] as $key => $image) {
                        $data['intro_images']['files'][$key]['http_file'] = $this->context->getImageUrl() . $image['file'];
                    }
                } else {
                    return false;
                }
            break;
        }

        return array('data' => $data, 'type' => $config['type']);
    }

    public function getIntroCascadeConfig($path)
    {
        static $result = array();

        if(empty($path)) {
            $path = '0';
        } else {
            settype($path, 'string');
        }

        if (!empty($result[$path])) {
            return $result[$path];
        }

        if ($path != '0') {
            $path = '0_' . $path;
        }

        $vars = array();
        $parts = explode('_', $path);

        $config = $this->settings['intro'];
        for ($i = 0, $j = count($parts); $i < $j; $i++) {
            if ($path != '0') {
                $path = substr($path, 2);
            }
            $path = 'category_' . $path;
            if (!isset($config[$path]) || !isset($config[$path]['type']) || $config[$path]['type'] != 'parent') {
                if (isset($config[$path]['type'])) {
                    $vars = $config[$path];
                }
                break;
            }
            $path = implode('_', array_slice($parts, 0, $j-$i-1));
        }

        if (empty($vars)) {
            $vars['type'] = 'nointro';
        }

        $result[$path] = $vars;

        return $vars;
    }

    public function getUser($user_id)
    {
        $user_table = '`' . DB_PREFIX . 'user`';
        $user_group_table = '`' . DB_PREFIX . 'user_group`';
        $sql = "SELECT *
                FROM $user_table AS u
                INNER JOIN $user_group_table AS ug ON u.user_group_id  = ug.user_group_id
                WHERE user_id = '" . (int) $user_id . "'";
        $query = $this->db->query($sql);
        if ($query->num_rows > 0) {
            $query->row['permission'] = unserialize($query->row['permission']);
        }

        return $query->row;
    }

    public function getLayoutIdByRoute($route, $request)
    {
        $layout_id = 0;

        if (substr($route, 0, 16) == 'product/category' && isset($request->get['path'])) {
            $path = explode('_', (string) $request->get['path']);
            $layout_id = $this->tbExtension->getOcModel('catalog/category')->getCategoryLayoutId(end($path));
        }

        if (substr($route, 0, 16) == 'product/product' && isset($request->get['product_id'])) {
            $layout_id = $this->tbExtension->getOcModel('catalog/product')->getProductLayoutId($request->get['product_id']);
        }

        if (substr($route, 0, 16) == 'product/information' && isset($request->get['information_id'])) {
            $layout_id = $this->tbExtension->getOcModel('catalog/information')->getInformationLayoutId($request->get['information_id']);
        }

        if (!$layout_id) {
            $layout_id = $this->tbExtension->getOcModel('design/layout')->getLayout($route);
        }

        if (!$layout_id) {
            $layout_id = $this->config->get('config_layout_id');
        }

        return $layout_id;
    }

    public function getThemeModulesForOC()
    {
        static $result = null;

        if (null !== $result) {
            return $result;
        }

        $result = array();
        $setting_extensions = $this->settingsModel['extensions'];
        if ($setting_extensions) {
            foreach ($setting_extensions as $name => $settings) {
                if ($this->tbManager->isExtensionInstalled($name)) {
                    $result[$name] = array(
                        'extension_id' => rand(9999, 9999999),
                        'type'         => 'module',
                        'code'         => $name
                    );
                }
            }
        }

        return $result;
    }

    public function themeModuleForOCExists($name)
    {
        $modules = $this->getThemeModulesForOC();

        return isset($modules[$name]);
    }

    public function getCustomerGroupId()
    {
        if ($this->customer->isLogged()) {
          $group_id = (int) $this->customer->getCustomerGroupId();
        } else {
          $group_id = (int) $this->config->get('config_customer_group_id');
        }

        return $group_id;
    }
}