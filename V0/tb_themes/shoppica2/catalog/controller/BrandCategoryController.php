<?php

class Theme_Catalog_BrandCategoryController extends TB_CatalogController
{
    public function index()
    {
        $this->data = array_merge(
            $this->data,
            $this->language->load('product/category'),
            $this->language->load('product/manufacturer'),
            $this->language->load('product/compare')
        );

        $this->load->model('catalog/manufacturer');
        $this->load->model('catalog/category');
        $this->load->model('tool/image');

        $this->data['breadcrumbs'] = array();
        $this->data['breadcrumbs'][] = array(
            'href'      => $this->url->link('common/home'),
            'text'      => $this->language->get('text_home'),
            'separator' => FALSE
        );

        $category_id = 0;
        if (isset($this->request->get['c_id'])) {
            $category_id = (int) $this->request->get['c_id'];
        }
        $category_info = $this->model_catalog_category->getCategory($category_id);

        $manufacturer_id = 0;
        if (isset($this->request->get['man_id'])) {
            $manufacturer_id = (int) $this->request->get['man_id'];
        }
        $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($manufacturer_id);

        if (!$category_info || !$manufacturer_info || $category_id == 0 || $manufacturer_id == 0) {
            return $this->showErrorProductsByManufacturerAndCategory();
        }

        $this->data['breadcrumbs'][] = array(
            'href'      => $this->url->link('product/category', 'path=' . $category_id),
            'text'      => $category_info['name'],
            'separator' => $this->language->get('text_separator')
        );

        $this->document->setTitle($category_info['name']);
        $this->document->setDescription($category_info['meta_description']);
        $this->document->setKeywords($category_info['meta_keyword']);

        $this->data['category_name']     = $category_info['name'];
        $this->data['manufacturer_name'] = $manufacturer_info['name'];
        $this->data['text_compare']      = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));

        $this->data['breadcrumbs'][] = array(
            'href'      => html_entity_decode($_SERVER['REQUEST_URI']),
            'text'      => $manufacturer_info['name'],
            'separator' => $this->language->get('text_separator')
        );

        $this->data['thumb'] = '';
        if ($manufacturer_info['image']) {
            $this->data['thumb'] = $this->model_tool_image->resize($manufacturer_info['image'], 80, 80);
        }

        if (isset($this->request->get['sort'])) {
            $sort = (string) $this->request->get['sort'];
        } else {
            $sort = 'p.sort_order';
        }

        if (isset($this->request->get['order'])) {
            $order = (string) $this->request->get['order'];
        } else {
            $order = 'ASC';
        }

        if (isset($this->request->get['page'])) {
            $page = (int) $this->request->get['page'];
        } else {
            $page = 1;
        }

        if (isset($this->request->get['limit'])) {
            $limit = (int) $this->request->get['limit'];
        } else {
            $limit = $this->config->get('config_catalog_limit');
        }
        $start = ($page - 1) * $limit;

        $url = '';
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . (string) $this->request->get['sort'];
        }
        if (isset($this->request->get['order'])) {
            $url .= '&order=' . (string) $this->request->get['order'];
        }

        $product_total = $this->getModel('products')->getTotalProductsByManufacturerAndCategory($manufacturer_id, $category_id);

        $this->data['products'] = array();

        $results = $this->getModel('products')->getProductsByManufacturerAndCategory($manufacturer_id, $category_id, $sort, $order, $start, $limit);

        foreach ($results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
            } else {
                $image = false;
            }

            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $price = false;
            }

            if ((float)$result['special']) {
                $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $special = false;
            }

            if ($this->config->get('config_tax')) {
                $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
            } else {
                $tax = false;
            }

            if ($this->config->get('config_review_status')) {
                $rating = (int) $result['rating'];
            } else {
                $rating = false;
            }

            $this->data['products'][] = array(
                'product_id'  => $result['product_id'],
                'thumb'       => $image,
                'name'        => $result['name'],
                'description' => substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 250) . '..',
                'price'       => $price,
                'special'     => $special,
                'tax'         => $tax,
                'rating'      => $rating
            );
        }

        $sorts_url = '';
        if (isset($this->request->get['limit'])) {
            $sorts_url .= '&limit=' . (int) $this->request->get['limit'];
        }
        $sorts_url = $this->url->link('category/manufacturer', 'man_id=' . $manufacturer_id . '&c_id=' . $category_id . $sorts_url);
        $this->data['sorts'] = $this->getModel('products')->getSorts($sorts_url);

        $limits_url = '';
        if (isset($this->request->get['sort'])) {
            $limits_url .= '&sort=' . (string) $this->request->get['sort'];
        }
        if (isset($this->request->get['order'])) {
            $limits_url .= '&order=' . (string) $this->request->get['order'];
        }
        $limits_url = $this->url->link('category/manufacturer', 'man_id=' . $manufacturer_id . '&c_id=' . $category_id . $limits_url);
        $this->data['limits'] = $this->getModel('products')->getLimits($limits_url);


        $url = '';
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . (string) $this->request->get['sort'];
        }
        if (isset($this->request->get['order'])) {
            $url .= '&order=' . (string) $this->request->get['order'];
        }
        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . (int) $this->request->get['limit'];
        }

        $pagination = new Pagination();
        $pagination->total = $product_total;
        $pagination->page  = $page;
        $pagination->limit = $limit;
        $pagination->text  = $this->language->get('text_pagination');
        $pagination->url   = $this->url->link($this->getRouteByName('category_manufacturer'), 'man_id=' . $manufacturer_id . '&c_id=' . $category_id .  $url . '&page={page}');

        $this->data['pagination'] = $pagination->render();

        $this->data['sort'] = $sort;
        $this->data['order'] = $order;
        $this->data['limit'] = $limit;

        $this->data['heading_title'] = sprintf($this->tbLang->brand_products, $manufacturer_info['name'], $category_info['name']);

        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/content_top',
            'common/content_bottom',
            'common/footer',
            'common/header'
        );

        $this->renderTemplate('brand_category');
    }

    private function showErrorProductsByManufacturerAndCategory()
    {
        $url = '';
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }
        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }
        if (isset($this->request->get['page'])) {
            $url .= '&page=' . (int) $this->request->get['page'];
        }

        $category_id = 0;
        if (isset($this->request->get['c_id'])) {
            $category_id = (int) $this->request->get['c_id'];
        }

        if (isset($this->request->get['path'])) {
            $this->document->breadcrumbs[] = array(
                'href'      => $this->url->link('product/category', 'path=' . $category_id),
                'text'      => $this->language->get('text_error'),
                'separator' => $this->language->get('text_separator')
            );
        }

        $this->document->setTitle($this->language->get('text_error'));

        $this->data['heading_title']   = $this->language->get('text_error');
        $this->data['text_error']      = $this->language->get('text_error');
        $this->data['button_continue'] = $this->language->get('button_continue');

        $this->data['continue'] = HTTP_SERVER . 'index.php?route=common/home';

        $this->children = array(
            'common/column_right',
            'common/column_left',
            'common/footer',
            'common/header'
        );

        $this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
        $this->response->setOutput($this->render());
    }
}