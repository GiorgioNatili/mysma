<?php

class Theme_Catalog_SchemerBarPlugin extends TB_ExtensionPlugin
{
    public function execute(TB_DataBag $tbData)
    {
        $this->bootstrap('common');

        $tbData->schemerHTML = '';
        $session_data = $this->registry->get('session')->data;

        if (!isset($this->request->get['color_schemer_auth_hash']) && !isset($session_data['color_schemer_auth_hash'])) {
            return;
        }

        $color_schemer_auth = $this->manager->getSettingsModel()->getScopeSettings('color_schemer_auth');
        if (isset($this->request->get['color_schemer_auth_hash']) && !empty($color_schemer_auth)) {
            list($hash, $user_id) = $color_schemer_auth;
            $user = $this->getModel()->getUser($user_id);
            if ($hash != $this->request->get['color_schemer_auth_hash'] || empty($user) || $user['status'] != 1 || !in_array('module/' . $this->context->getBasename(), $user['permission']['modify'])) {
                return;
            }
            $this->registry->get('session')->data['color_schemer_auth_hash'] = $hash;
            TB_ControllerHelper::redirect($this->context->getBaseHttp());
        } else {
            if (empty($color_schemer_auth)) {
                return;
            }
            if (isset($session_data['color_schemer_auth_hash'])) {
                list($hash, $user_id) = $color_schemer_auth;
                if ($hash != $session_data['color_schemer_auth_hash']) {
                    return;
                }
                $user = $this->getModel()->getUser($user_id);
                if (empty($user) || $user['status'] != 1 || !in_array('module/' . $this->context->getBasename(), $user['permission']['modify'])) {
                    return;
                }
            }
        }

        $category_path = isset($this->request->get['path']) ? (string) $this->request->get['path'] : '0';
        $path_arr = explode('_', $category_path);
        $category_id = (int) end($path_arr);

        $predefined_schemes = $this->getModel('schemer')->getPredefinedSchemes();
        $schemer_config = $this->getModel('schemer')->getSchemerConfig($category_path);
        if (!isset($schemer['colors']['texture'])) {
            $schemer['colors']['texture'] = 'no_texture';
        }

        $json_data = $predefined_schemes;
        $json_data['parent'] = $schemer_config['parent_vars']['colors'];
        $json_data['custom'] = $schemer_config['colors'];
        $json_data = json_encode($json_data);

        $google_list = $this->getModel('fonts')->getGoogleFontsList();
        $built_list = $this->getModel('fonts')->getBuiltFontsList();

        if (isset($this->extension_settings['font'][$this->language_id])) {
            $font = $this->extension_settings['font'][$this->language_id];
        } else {
            $font = reset($this->extension_settings['font']);
        }

        $data = array();
        $data['schemer']              = $schemer_config;
        $data['schemer_json']         = $json_data;
        $data['predefined_schemes']   = $predefined_schemes;
        $data['categories']           = $this->tbExtension->getModel('category')->getCategoriesFlatTree();
        $data['category_id']          = $category_id;
        $data['backgrounds']          = $this->extension_settings['background']['images'];
        $data['font']                 = $font;
        $data['google_font_families'] = array_keys($google_list);
        $data['google_font_list']     = $google_list;
        $data['built_font_families']  = $built_list;

        $tbData->schemerHTML = $this->tbExtension->fetchTemplate('schemer', $data);
    }
}