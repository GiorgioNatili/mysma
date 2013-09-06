<?php

class Theme_Admin_SchemerPlugin extends TB_ExtensionPlugin
{
    public function setForm()
    {
        if (isset($this->request->get['schemer_category_path'])) {
            $category_path = (string) $this->request->get['schemer_category_path'];
        } else {
            $category_path = '0';
        }

        $url_category_path = $category_path;
        $url_category_id = 0;
        if ($category_path != '0') {
            $path_arr = explode('_', $category_path);
            $url_category_id = (int) end($path_arr);
        }

        $predefined_schemes = $this->getModel('schemer')->getPredefinedSchemes();
        $schemer = $this->getModel('schemer')->getSchemerConfig($category_path);

        $schemer_json_data = $predefined_schemes;
        $schemer_json_data['parent'] = $schemer['parent_vars']['colors'];
        $schemer_json_data['custom'] = $schemer['colors'];
        $schemer_json_data = json_encode($schemer_json_data);

        $has_color_schemer = false;
        $color_schemer_auth = $this->manager->getSettingsModel()->getScopeSettings('color_schemer_auth');
        if (!empty($color_schemer_auth)) {
            $has_color_schemer  = true;
        }

        return array(
            'url_schemer_category_id'   => $url_category_id,
            'url_schemer_category_path' => $url_category_path,
            'schemer'                   => $schemer,
            'predefined_schemes'        => $predefined_schemes,
            'schemer_json_data'         => $schemer_json_data,
            'has_color_schemer'         => $has_color_schemer,
            'schemer_categories'        => $this->getModel('category')->getCategoriesFlatTree()
        );
    }

    public function saveForm($form)
    {
        if (!isset($form['schemer'])) {
            return false;
        }

        $schemer_form = $form['schemer'];
        $settings = $this->getModel()->getSettings();

        if (!isset($settings['schemer'])) {
            $settings['schemer'] = array();
        }

        $path = (string) $schemer_form['path'];
        $settings['schemer'][$path] = $schemer_form;

        return array('schemer' => $settings['schemer']);
    }
}