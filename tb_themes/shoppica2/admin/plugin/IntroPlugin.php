<?php

class Theme_Admin_IntroPlugin extends TB_ExtensionPlugin
{
    public function setForm()
    {
        if (isset($this->request->get['intro_category_path'])) {
            $category_path = (string) $this->request->get['intro_category_path'];
        } else {
            $category_path = '0';
        }

        $url_category_path = $category_path;
        $url_category_id = 0;
        if ($category_path != '0') {
            $path_arr = explode('_', $category_path);
            $url_category_id = (int) end($path_arr);
        }

        $category_config = array();
        $settings = $this->getModel()->getSettings();
        if (isset($settings['intro']['category_' . $category_path])) {
            $category_config = $settings['intro']['category_' . $category_path];
        }

        if (!isset($category_config['type'])) {
            $category_config['type'] = 'nointro';
        }

        if (!isset($category_config['products']['size'])) {
            $category_config['products']['size'] = '3';
        }

        if (!isset($category_config['products']['text_source'])) {
            $category_config['products']['text_source'] = 'details';
        }

        if (!isset($category_config['products']['ids'])) {
            $category_config['products']['ids'] = array();
        }

        if (!isset($category_config['images'])) {
            $category_config['images'] = array();
        }
        $languages = $this->getModel()->getLanguages();
        foreach ($languages as $language) {
            $lid = $language['language_id'];
            if (!isset($category_config['images'][$lid])) {
                $category_config['images'][$lid]['with_border'] = 0;
                $category_config['images'][$lid]['rotation_type'] = 'slide';
                $category_config['images'][$lid]['files'] = array();
            } else {
                if (empty($category_config['images'][$lid]['files'])) {
                    continue;
                }
                foreach ($category_config['images'][$lid]['files'] as $key => &$img) {
                    if ($img['file'] && file_exists(DIR_IMAGE . $img['file'])) {
                        $img['preview'] = $this->getOcModel('tool/image')->resize($img['file'], 100, 100);
                    } else {
                        unset($category_config['images'][$lid]['files'][$key]);
                    }
                }
            }
        }

        $products_total = 0;
        if (!empty($category_config['products']['ids'])) {
            $filter_data = array('filter_selected' => 1);
            $products_total = (int) $this->getModel()->getTotalProducts($filter_data, $category_config['products']['ids']);
        }

        $categories = $this->getModel('category')->getCategoriesFlatTree();
        if ($url_category_id != 0) {
            $category_name = str_replace('&nbsp;', '', $categories[$url_category_id]['name']);
        } else {
            $category_name = '*Global*';
        }

        return array(
            'url_intro_category_id'         => $url_category_id,
            'url_intro_category_path'       => $url_category_path,
            'intro'                         => $category_config,
            'intro_categories'              => $categories,
            'intro_category_products_count' => $products_total,
            'intro_category_name'           => $category_name
        );
    }

    public function saveForm($form)
    {
        if (!isset($form['intro'])) {
            return false;
        }

        $intro_data = $form['intro'];
        if (!isset($intro_data['category_path'])) {
            return false;
        }

        $theme_settings = $this->getModel()->getSettings();
        if (!isset($theme_settings['intro'])) {
            $theme_settings['intro'] = array();
        }

        $category_path = (string) $intro_data['category_path'];
        $category_config = array();
        if (isset($theme_settings['intro']['category_' . $category_path])) {
            $category_config = $theme_settings['intro']['category_' . $category_path];
        }
        $category_config['category_path'] = $category_path;

        $category_config['type'] = (string) $intro_data['type'];
        switch ($category_config['type']) {

            case 'nointro' :

                break;
            case 'products';

                $category_config['products']['size'] = (string) $intro_data['products']['size'];
                $category_config['products']['text_source'] = (string) $intro_data['products']['text_source'];

                break;
            case 'images':

                $category_config['images'] = array();
                $languages = $this->getModel()->getLanguages();
                foreach ($languages as $language) {
                    $lid = $language['language_id'];

                    if (!isset($intro_data['images'][$lid])) {
                        continue;
                    }

                    $maxHeight = 0;

                    if (!empty($intro_data['images'][$lid]['files'])) {
                        $orders = array();
                        foreach ($intro_data['images'][$lid]['files'] as $key => $img) {
                            $order = (int) $img['order'];
                            $orders[] = $order;
                        }
                        sort($orders);

                        $result = array();
                        foreach ($intro_data['images'][$lid]['files'] as $key => $img) {
                            $order = (int) $img['order'];
                            $key = array_search($order, $orders);
                            $result[$key] = $img;
                            unset($orders[$key]);
                        }
                        ksort($result);

                        $category_config['images'][$lid] = array();
                        foreach ($result as $key => $values) {
                            if (!empty($values['image'])) {
                                list($width, $height) = getimagesize(DIR_IMAGE . $values['image']);

                                $category_config['images'][$lid]['files'][$key]['width']  = $width;
                                $category_config['images'][$lid]['files'][$key]['height'] = $height;
                                $category_config['images'][$lid]['files'][$key]['order']  = $key + 1;
                                $category_config['images'][$lid]['files'][$key]['file']   = $values['image'];
                                $category_config['images'][$lid]['files'][$key]['url']    = $values['url'];

                                if ($height > $maxHeight) {
                                    $maxHeight = $height;
                                }
                            }
                        }
                    }

                    $category_config['images'][$lid]['with_border']   = (int) $intro_data['images'][$lid]['with_border'];
                    $category_config['images'][$lid]['rotation_type'] = $intro_data['images'][$lid]['rotation_type'];
                    $category_config['images'][$lid]['maxHeight']     = $maxHeight;
                }

                break;
        }

        $event = new sfEvent($this, 'theme:admin_intro_plugin.filter_saveForm', array('form' => $form));
        $category_config = $this->eventDispatcher->filter($event, $category_config)->getReturnValue();

        $theme_settings['intro']['category_' . $category_path] = $category_config;

        return array('intro' => $theme_settings['intro']);
    }
}