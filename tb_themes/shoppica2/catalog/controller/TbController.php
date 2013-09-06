<?php

class Theme_Catalog_TbController extends TB_CatalogController
{
    public function saveSchemer()
    {
        if ($this->request->server['REQUEST_METHOD'] != 'POST' || !isset($this->request->post['schemer']) || !isset($this->request->post['font'])) {
            return false;
        }

        $settingModel = $this->tbManager->getSettingsModel();
        $color_schemer_auth = $settingModel['color_schemer_auth'];
        if (empty($color_schemer_auth)) {
            return false;
        }

        $session_data = $this->registry->get('session')->data;
        if (isset($session_data['color_schemer_auth_hash'])) {
            list($hash, $user_id) = $color_schemer_auth;
            if ($hash != $session_data['color_schemer_auth_hash']) {
                return false;
            }
            $user = $this->getModel()->getUser($user_id);
            if (empty($user) || $user['status'] != 1 || !in_array('module/' . $this->context->getBasename(), $user['permission']['modify'])) {
                return false;
            }
        } else {
            $settingModel->deleteScopeSettings('color_schemer_auth');

            return false;
        }

        $form_data = $this->request->post['schemer'];
        $settings = $this->getModel()->getSettings();
        if (!isset($settings['schemer'])) {
            $settings['schemer'] = array();
        }
        $path = (string) $form_data['path'];
        $settings['schemer'][$path] = $form_data;
        unset($settings['fonts']);

        $settings['font'][$this->getModel()->getCurrentLanguage('id')] = $this->request->post['font'];
        $settings['font'] = $this->getModel('fonts')->combineFormData($settings['font']);

        $this->getModel()->setAndPersistSettings($settings);

        if ($form_data['path'] == 0) {
            $this->redirect($this->context->getBaseHttp());
        } else {
            $this->redirect($this->context->getBaseHttp() . 'index.php?route=product/category&path=' . $form_data['path']);
        }
    }

    public function removeSchemer()
    {
        if (isset($this->registry->get('session')->data['color_schemer_auth_hash'])) {
            $this->tbManager->getSettingsModel()->deleteScopeSettings('color_schemer_auth');
        }
        $this->redirect($this->context->getBaseHttp());
    }

    public function cartCallback()
    {
        $this->response->setOutput(json_encode($this->getCartContents()));
    }

    public function wishlistCallback()
    {
        $this->load->model('catalog/product');
        $this->load->model('tool/image');
        $this->language->load('account/wishlist');

        $json = array();

        if (!isset($this->session->data['wishlist'])) {
            $this->session->data['wishlist'] = array();
        }

        $product_id = 0;
        if (isset($this->request->post['product_id'])) {
            $product_id = (int) $this->request->post['product_id'];
        }

        $product_info = $this->model_catalog_product->getProduct($product_id);

        if ($product_info) {
            if (!in_array($product_id, $this->session->data['wishlist'])) {
                $this->session->data['wishlist'][] = $this->request->post['product_id'];
            }

            if ($this->customer->isLogged()) {
                $json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $product_id), $product_info['name'], $this->url->link('account/wishlist'));
                $json['title'] = $this->tbLang->text_product_add_wishlist;
            } else {
                $json['failure'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('account/wishlist'));
                $json['title'] = $this->tbLang->text_failure;
            }

            $json['thumb'] = $this->model_tool_image->resize($product_info['image'], 40, 40);;
            $json['total'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
        }

        $this->response->setOutput(json_encode($json));
    }

    public function compareCallback()
    {
        $this->language->load('product/compare');
        $this->load->model('catalog/product');
        $this->load->model('tool/image');

        $json = array();

        if (!isset($this->session->data['compare'])) {
            $this->session->data['compare'] = array();
        }

        $product_id = 0;
        if (isset($this->request->post['product_id'])) {
            $product_id = (int) $this->request->post['product_id'];
        }

        $product_info = $this->model_catalog_product->getProduct($product_id);
        if ($product_info) {
            if (!in_array($product_id, $this->session->data['compare'])) {
                if (count($this->session->data['compare']) > 4) {
                    array_shift($this->session->data['compare']);
                }
                $this->session->data['compare'][] = $product_id;
            }

            $json['thumb']   = $this->model_tool_image->resize($product_info['image'], 40, 40);
            $json['title']   = $this->tbLang->text_product_add_compare;
            $json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $product_id), $product_info['name'], $this->url->link('product/compare'));
            $json['total']   = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
        }

        $this->response->setOutput(json_encode($json));
    }

    public function getCartContents()
    {
        $this->load->model('catalog/product');
        $this->load->model('tool/image');

        $this->language->load('checkout/cart');

        if (isset($this->request->get['route']) && $this->request->get['route'] == 'checkout/success') {
            $this->cart->clear();
        }

        $json = array();
        $product_id = 0;
        if (isset($this->request->post['product_id'])) {
            $product_id = (int) $this->request->post['product_id'];
        }

        if (!empty($product_id)) {
            $product_info = $this->model_catalog_product->getProduct($product_id);
            if ($product_info) {
                // Minimum quantity validation
                $quantity = 1;
                if (isset($this->request->post['quantity'])) {
                    $quantity = (int) $this->request->post['quantity'];
                }
                if (!$quantity) {
                    $quantity = 1;
                }

                $product_total = 0;

                $products = $this->cart->getProducts();
                foreach ($products as $product_2) {
                    if ($product_2['product_id'] == $product_id) {
                        $product_total += $product_2['quantity'];
                    }
                }

                if ($product_info['minimum'] > ($product_total + $quantity)) {
                    $json['title'] = $this->tbLang->text_failure;
                    $json['error']['warning'] = sprintf($this->language->get('error_minimum'), $product_info['name'], $product_info['minimum']);
                }

                // Option validation
                $option = array();
                if (isset($this->request->post['option'])) {
                    $option = array_filter((array) $this->request->post['option']);
                }

                $product_options = $this->model_catalog_product->getProductOptions($product_id);
                foreach ($product_options as $product_option) {
                    if ($product_option['required'] && (!isset($this->request->post['option'][$product_option['product_option_id']]) ||
                        !$this->request->post['option'][$product_option['product_option_id']]))
                    {
                        $json['error'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
                    }
                }
                $json['thumb'] = $this->model_tool_image->resize($product_info['image'], 40, 40);
            }

            if (!isset($json['error'])) {
                $this->cart->add($product_id, $quantity, $option);
                $json['title'] = $this->tbLang->text_cart_title_add;
                $json['success'] = sprintf($this->tbLang->text_cart_add, $this->url->link('product/product', 'product_id=' . $product_id), $product_info['name'], $this->url->link('checkout/cart'));

                unset($this->session->data['shipping_methods']);
                unset($this->session->data['shipping_method']);
                unset($this->session->data['payment_methods']);
                unset($this->session->data['payment_method']);
            } else {
                $json['redirect'] = str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $product_id));
            }
        }

        if (isset($this->request->post['removeKey'])) {
            $removeKey = (string) $this->request->post['removeKey'];
            list($product_id, ) = explode(':', $removeKey);
            settype($product_id, 'integer');
            $product_info = $this->model_catalog_product->getProduct($product_id);
            if ($product_info) {
                $this->load->model('tool/image');

                $json['thumb'] = $this->model_tool_image->resize($product_info['image'], 40, 40);
                $this->cart->remove($removeKey);

                $json['title'] = $this->tbLang->text_cart_title_remove;
                $json['success'] = sprintf($this->tbLang->text_cart_remove, $this->url->link('product/product', 'product_id=' . $product_id), $product_info['name'], $this->url->link('checkout/cart'));

                unset($this->session->data['shipping_methods']);
                unset($this->session->data['shipping_method']);
                unset($this->session->data['payment_methods']);
                unset($this->session->data['payment_method']);
            }
        }

        if (isset($this->request->post['removeVoucher'])) {
            if (isset($this->session->data['vouchers'][$this->request->post['removeVoucher']])) {
                unset($this->session->data['vouchers'][$this->request->post['removeVoucher']]);
            }
            $json['title'] = $this->tbLang->text_cart_title_remove;
            $json['success'] = sprintf($this->tbLang->text_cart_voucher_remove, $this->url->link('checkout/cart'));
        }

        $this->data['text_empty']    = $this->language->get('text_empty');
        $this->data['text_checkout'] = $this->language->get('button_checkout');
        $this->data['button_remove'] = $this->language->get('button_remove');

        $this->data['products'] = array();

        foreach ($this->cart->getProducts() as $product) {
            if ($product['image']) {
                $image = (string) $this->model_tool_image->resize($product['image'], 40, 40);
            } else {
                $image = '';
            }

            $option_data = array();

            foreach ($product['option'] as $option) {
                if ($option['type'] != 'file') {
                    $value = $option['option_value'];
                } else {
                    $filename = $this->encryption->decrypt($option['option_value']);
                    $value = utf8_substr($filename, 0, utf8_strrpos($filename, '.'));
                }

                $option_data[] = array(
                    'name'  => $option['name'],
                    'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value),
                    'type'  => $option['type']
                );
            }

            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $price = false;
            }

            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $total = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity']);
            } else {
                $total = false;
            }

            $urlObj = empty($this->_url) ? $this->url : $this->_url;
            $this->data['products'][] = array(
                'id'       => $product['product_id'],
                'key'      => $product['key'],
                'thumb'    => $image,
                'name'     => $product['name'],
                'model'    => $product['model'],
                'option'   => $option_data,
                'quantity' => $product['quantity'],
                'stock'    => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
                'reward'   => $product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : '',
                'price'    => $price,
                'total'    => $total,
                'href'     => $urlObj->link('product/product', 'product_id=' . $product['product_id'])
            );
        }

        // Gift Voucher
        $this->data['vouchers'] = array();

        if (isset($this->session->data['vouchers']) && $this->session->data['vouchers']) {
            foreach ($this->session->data['vouchers'] as $key => $voucher) {
                $this->data['vouchers'][] = array(
                    'key'         => $key,
                    'description' => $voucher['description'],
                    'amount'      => $this->currency->format($voucher['amount'])
                );
            }
        }

        // Calculate Totals
        $total_data = array();
        $total = 0;
        $taxes = $this->cart->getTaxes();

        if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
            $this->load->model('setting/extension');

            $sort_order = array();

            $results = $this->model_setting_extension->getExtensions('total');

            foreach ($results as $key => $value) {
                $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
            }

            array_multisort($sort_order, SORT_ASC, $results);

            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('total/' . $result['code']);

                    $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
                }
            }

            $sort_order = array();

            foreach ($total_data as $key => $value) {
                $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $total_data);
        }

        $products_count = $this->cart->countProducts();
        $json['total'] = sprintf($this->language->get('text_items'), $products_count  + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
        $json['total_sum'] = $this->currency->format($total);
        $json['products_count'] = $products_count;

        $this->data['products_count'] = $products_count;
        $this->data['totals'] = $total_data;
        $this->data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');

        $this->template = $this->context->getBasename() . '/template/module/cart.tpl';
        $json['html'] = $this->render();

        return $json;
    }
}