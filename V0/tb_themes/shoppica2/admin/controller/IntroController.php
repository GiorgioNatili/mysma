<?php

class Theme_Admin_IntroController extends TB_AdminController
{
    public function categoryIntro()
    {
        foreach ($this->tbExtension->getPlugin('intro')->setForm() as $key => $data) {
            $this->data[$key] = $data;
        }

        $this->renderAction('theme_intro_types.tpl');
    }

    public function addIntroBannerProduct()
    {
        if (!$this->validate()) {

            return $this->sendJsonError('You do not have the sufficient permissions to modify this module!');
        }

        $product_id = false;
        if (isset($this->request->get['product_id'])) {
            $product_id = (int) $this->request->get['product_id'];
        }

        $category_id = false;
        if (isset($this->request->get['category_path'])) {
            $category_path = $this->request->get['category_path'];
            $path_arr = explode('_', $category_path);
            $category_id = end($path_arr);
        }

        if (empty($product_id) || $category_id === false) {

            return $this->sendJsonError('Request Error!');
        }

        $theme_settings = $this->getModel()->getSettings();
        if (!isset($theme_settings['intro'])) {
            $theme_settings['intro'] = array();
        }

        $category_config = array();
        if (isset($theme_settings['intro']['category_' . $category_path])) {
            $category_config = $theme_settings['intro']['category_' . $category_path];
        }
        $category_config['category_path'] = $category_path;
        $category_config['type'] = 'products';

        if (!isset($category_config['products'])) {
            $category_config['products'] = array();
        }
        if (!isset($category_config['products']['size'])) {
            $category_config['products']['size'] = 2;
        }
        if (!isset($category_config['products']['ids'])) {
            $category_config['products']['ids'] = array();
        }

        $product_ids = $category_config['products']['ids'];
        $products_total = 0;
        if (false === array_search($product_id, $product_ids)) {
            $product_ids[] = $product_id;
            $category_config['products']['ids'] = $product_ids;
            $theme_settings['intro']['category_' . $category_path] = $category_config;

            $this->getModel()->setSettings($theme_settings);
            $this->getModel()->persistSettings();
            //$this->cache->delete($this->getModel()->getScope() . '_config');

            $filter_data = array('filter_selected' => 1);
            $products_total = (int) $this->getModel()->getTotalProducts($filter_data, $product_ids);
        }

        $this->sendJsonSuccess($this->language->get('text_success'), array('products_total' => $products_total));
    }

    public function removeIntroBannerProduct()
    {
        if (!$this->validate()) {
            return $this->sendJsonError('You do not have the sufficient permissions to modify this module!');
        }

        $product_id = false;
        if (isset($this->request->get['product_id'])) {
            $product_id = (int) $this->request->get['product_id'];
        }

        $category_id = false;
        if (isset($this->request->get['category_path'])) {
            $category_path = $this->request->get['category_path'];
            $path_arr = explode('_', $category_path);
            $category_id = end($path_arr);
        }

        if (empty($product_id) || $category_id === false) {
            return $this->sendJsonError('Request Error!');
        }

        $theme_settings = $this->getModel()->getSettings();
        $category_config = $theme_settings['intro']['category_' . $category_path];
        $product_ids = $category_config['products']['ids'];
        $key = array_search($product_id, $product_ids);
        $products_total = 0;
        if ($key !== false) {
            unset($product_ids[$key]);
            $category_config['products']['ids'] = $product_ids;
            $theme_settings['intro']['category_' . $category_path] = $category_config;

            $this->getModel()->setSettings($theme_settings);
            $this->getModel()->persistSettings();
            //$this->cache->delete($this->getModel()->getScope() . '_config');

            $filter_data = array('filter_selected' => 1);
            $products_total = (int) $this->getModel()->getTotalProducts($filter_data, $product_ids);
        }

        $this->sendJsonSuccess($this->language->get('text_success'), array('products_total' => $products_total));
    }

    public function getIntroBannerProductsHtml()
    {
        $this->getProductsList();

        $this->renderAction('products_modal.tpl');
    }

    protected function getProductsList()
    {
        $this->load->model('catalog/product');
        $this->load->model('tool/image');

        $language = $this->load->language('catalog/product');
        $this->data = array_merge($this->data, $language);

        $pagination_limit = 8;

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'pd.name';
        }

        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'ASC';
        }

        if (isset($this->request->get['filter_name'])) {
            $filter_name = $this->request->get['filter_name'];
        } else {
            $filter_name = null;
        }

        if (isset($this->request->get['filter_model'])) {
            $filter_model = $this->request->get['filter_model'];
        } else {
            $filter_model = null;
        }

        if (isset($this->request->get['filter_price_less'])) {
            $filter_price_less = $this->request->get['filter_price_less'];
        } else {
            $filter_price_less = null;
        }

        if (isset($this->request->get['filter_price_more'])) {
            $filter_price_more = $this->request->get['filter_price_more'];
        } else {
            $filter_price_more = null;
        }

        if (isset($this->request->get['filter_price_equals'])) {
            $filter_price_equals = $this->request->get['filter_price_equals'];
        } else {
            $filter_price_equals = null;
        }

        if (isset($this->request->get['filter_selected'])) {
            $filter_selected = $this->request->get['filter_selected'];
        } else {
            $filter_selected = null;
        }

        $url = '';

        if (isset($this->request->get['filter_name'])) {
            $url .= '&filter_name=' . $this->request->get['filter_name'];
        }

        if (isset($this->request->get['filter_model'])) {
            $url .= '&filter_model=' . $this->request->get['filter_model'];
        }

        if ($filter_price_less) {
            $url .= '&filter_price_less=' . $this->request->get['filter_price_less'];
        }

        if ($filter_price_more) {
            $url .= '&filter_price_more=' . $this->request->get['filter_price_more'];
        }

        if ($filter_price_equals) {
            $url .= '&filter_price_equals=' . $this->request->get['filter_price_equals'];
        }

        if ($filter_selected) {
            $url .= '&filter_selected=' . $this->request->get['filter_selected'];
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        $theme_settings = $this->getModel()->getSettings();
        $category_path = 0;
        if (isset($this->request->get['category_path'])) {
            $category_path = $this->request->get['category_path'];
        }
        $category_config = array();
        if (isset($theme_settings['intro']['category_' . $category_path])) {
            $category_config = $theme_settings['intro']['category_' . $category_path];
        }
        $product_ids = array();
        if (isset($category_config['products']['ids'])) {
            $product_ids = $category_config['products']['ids'];
        }

        $this->data['products'] = array();

        $data = array(
            'filter_name'         => $filter_name,
            'filter_model'        => $filter_model,
            'filter_price_less'   => $filter_price_less,
            'filter_price_more'   => $filter_price_more,
            'filter_price_equals' => $filter_price_equals,
            'filter_selected'     => $filter_selected,
            'sort'                => $sort,
            'order'               => $order,
            'start'               => ($page - 1) * $pagination_limit,
            'limit'               => $pagination_limit
        );

        $product_total = $this->getModel()->getTotalProducts($data, $product_ids);
        $results = $this->getModel()->getProducts($data, $product_ids);

        foreach ($results as $result) {

            if ($result['image'] && file_exists(DIR_IMAGE . $result['image'])) {
                $image = $this->model_tool_image->resize($result['image'], 40, 40);
            } else {
                $image = $this->model_tool_image->resize('no_image.jpg', 40, 40);
            }

            $special = false;
            $product_specials = $this->model_catalog_product->getProductSpecials($result['product_id']);
             if ($product_specials) {
                $special = reset($product_specials);
                if(($special['date_start'] != '0000-00-00' && $special['date_start'] > date('Y-m-d')) || ($special['date_end'] != '0000-00-00' && $special['date_end'] < date('Y-m-d'))) {
                    $special = false;
                }
            }

            $this->data['products'][] = array(
                'product_id' => $result['product_id'],
                'name'       => $result['name'],
                'model'      => $result['model'],
                'price'      => $result['price'],
                'special'    => $special['price'],
                'image'      => $image,
                'added'      => $result['added'],
                'quantity'   => $result['quantity'],
                'status'     => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
                'selected'   => isset($this->request->post['selected']) && in_array($result['product_id'], $this->request->post['selected'])
            );
        }

        $url = '';

        if (isset($this->request->get['filter_name'])) {
            $url .= '&filter_name=' . $this->request->get['filter_name'];
        }

        if (isset($this->request->get['filter_model'])) {
            $url .= '&filter_model=' . $this->request->get['filter_model'];
        }

        if ($filter_price_less) {
            $url .= '&filter_price_less=' . $this->request->get['filter_price_less'];
        }

        if ($filter_price_more) {
            $url .= '&filter_price_more=' . $this->request->get['filter_price_more'];
        }

        if ($filter_price_equals) {
            $url .= '&filter_price_equals=' . $this->request->get['filter_price_equals'];
        }

        if ($filter_selected) {
            $url .= '&filter_selected=' . $this->request->get['filter_selected'];
        }

        if ($order == 'ASC') {
            $url .= '&order=DESC';
        } else {
            $url .= '&order=ASC';
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . (int) $this->request->get['page'];
        }

        $this->data['sort_added'] = $this->tbUrl->generate('intro/getIntroBannerProductsHtml', 'sort=added' . $url);
        $this->data['sort_name']  = $this->tbUrl->generate('intro/getIntroBannerProductsHtml', 'sort=pd.name' . $url);
        $this->data['sort_model'] = $this->tbUrl->generate('intro/getIntroBannerProductsHtml', 'sort=p.model' . $url);
        $this->data['sort_price'] = $this->tbUrl->generate('intro/getIntroBannerProductsHtml', 'sort=p.price' . $url);

        $url = '';

        if (isset($this->request->get['filter_name'])) {
            $url .= '&filter_name=' . $this->request->get['filter_name'];
        }

        if (isset($this->request->get['filter_model'])) {
            $url .= '&filter_model=' . $this->request->get['filter_model'];
        }

        if ($filter_price_less) {
            $url .= '&filter_price_less=' . $this->request->get['filter_price_less'];
        }

        if ($filter_price_more) {
            $url .= '&filter_price_more=' . $this->request->get['filter_price_more'];
        }

        if ($filter_price_equals) {
            $url .= '&filter_price_equals=' . $this->request->get['filter_price_equals'];
        }

        if ($filter_selected) {
            $url .= '&filter_selected=' . $this->request->get['filter_selected'];
        }

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        $pagination = new Pagination();
        $pagination->total = $product_total;
        $pagination->page  = $page;
        $pagination->limit = $pagination_limit;
        $pagination->text  = $this->language->get('text_pagination');
        $pagination->url   = $this->tbUrl->generate('intro/getIntroBannerProductsHtml', 'page={page}' . $url);

        $this->data['pagination']          = $pagination->render();
        $this->data['filter_name']         = $filter_name;
        $this->data['filter_model']        = $filter_model;
        $this->data['filter_price_less']   = $filter_price_less;
        $this->data['filter_price_more']   = $filter_price_more;
        $this->data['filter_price_equals'] = $filter_price_equals;
        $this->data['filter_selected']     = $filter_selected;

        $this->data['sort']  = $sort;
        $this->data['order'] = $order;
    }
}