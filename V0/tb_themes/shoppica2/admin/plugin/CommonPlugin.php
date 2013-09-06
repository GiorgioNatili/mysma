<?php

class Theme_Admin_CommonPlugin extends TB_ExtensionPlugin
{
    public function setForm()
    {
        $vars = array(
            'layout_type'                  => 'fixed',
            'column_position'              => 'right',
            'product_listing_type'         => 'grid',
            'products_per_row'             => 'size_1',
            'show_search_bar'              => 0,
            'subcategories_enabled'        => 1,
            'subcategories_style'          => 'thumbs',
            'subcategories_count_enabled'  => 0,
            'cart_menu_position'           => 'right',
            'show_cart_label'              => 0,
            'border_type'                  => 0,
            'manufacturers_enabled'        => 1,
            'compare_enabled'              => 1,
            'wishlist_enabled'             => 1,
            'checkout_enabled'             => 1,
            'voucher_enabled'              => 1,
            'affiliate_enabled'            => 1,
            'returns_enabled'              => 1,
            'footer_navigation_enabled'    => 1,
            'footer_categories_enabled'    => 1,
            'product_social_share_enabled' => 1,
            'menu_brands_enabled'          => 1,
            'menu_infopages_enabled'       => 1,
            'product_gallery_position'     => 'tab',
            'product_gallery_type'         => 'prettyphoto',
            'product_zoom_position'        => 'right',
            'price_design'                 => 'label',
            'price_size'                   => 'large'
        );

        $model_settings = $this->getModel()->getSettings();
        $vars = TB_FormHelper::initFlatVars($vars, 'common', $model_settings, $this->request->post);
        $vars['common']['language_direction'] = TB_FormHelper::transformLangVar(
            array('language_direction' => 'ltr'),
            'common',
            $model_settings,
            $this->getModel()->getLanguages());
        $vars['common']['theme_version'] = $this->manager->getThemeVersion();

        return $vars;
    }

    public function saveForm($form)
    {
        $common = $this->getModel()->getSetting('common');
        if ($common['products_per_row'] != $form['common']['products_per_row']) {
            $this->setProductsPerRowImageSettings($form['common']['products_per_row']);
        }
        if ($common['product_gallery_position'] != $form['common']['product_gallery_position']) {
            $this->setProductGalleryPositionImageSettings($form['common']['product_gallery_position']);
        }

        return array('common' => $form['common']);
    }

    public function getDefaultOcImageSettings()
    {
        return array(
            'config_image_category_width'  => 100,
            'config_image_category_height' => 100,
            'config_image_thumb_width'     => 340,
            'config_image_thumb_height'    => 340,
            'config_image_popup_height'    => 600,
            'config_image_popup_width'     => 600,
            'config_image_compare_width'   => 80,
            'config_image_compare_height'  => 80,
            'config_image_wishlist_width'  => 80,
            'config_image_wishlist_height' => 80,
            'config_image_cart_width'      => 80,
            'config_image_cart_height'     => 80
        );
    }

    public function setDefaultOcImageSettings($products_per_row, $product_gallery_position)
    {
        $image_settings = $this->getDefaultOcImageSettings();

        $this->manager->getDbSettingsHelper()->persistGroup('config', $image_settings, $this->context->getStoreId());
        $this->setProductsPerRowImageSettings($products_per_row);
        $this->setProductGalleryPositionImageSettings($product_gallery_position);
    }

    public function getCurrentOcImageSettings()
    {
        $dbHelper = $this->manager->getDbSettingsHelper();
        $store_id = $this->context->getStoreId();

        return array(
            'config_image_category_width'  => $dbHelper->getKey('config_image_category_width', $store_id, 'config'),
            'config_image_category_height' => $dbHelper->getKey('config_image_category_height', $store_id, 'config'),
            'config_image_thumb_width'     => $dbHelper->getKey('config_image_thumb_width', $store_id, 'config'),
            'config_image_thumb_height'    => $dbHelper->getKey('config_image_thumb_height', $store_id, 'config'),
            'config_image_popup_height'    => $dbHelper->getKey('config_image_popup_height', $store_id, 'config'),
            'config_image_popup_width'     => $dbHelper->getKey('config_image_popup_width', $store_id, 'config'),
            'config_image_compare_width'   => $dbHelper->getKey('config_image_compare_width', $store_id, 'config'),
            'config_image_compare_height'  => $dbHelper->getKey('config_image_compare_height', $store_id, 'config'),
            'config_image_wishlist_width'  => $dbHelper->getKey('config_image_wishlist_width', $store_id, 'config'),
            'config_image_wishlist_height' => $dbHelper->getKey('config_image_wishlist_height', $store_id, 'config'),
            'config_image_cart_width'      => $dbHelper->getKey('config_image_cart_width', $store_id, 'config'),
            'config_image_cart_height'     => $dbHelper->getKey('config_image_cart_height', $store_id, 'config')
        );
    }

    public function setProductsPerRowImageSettings($products_per_row)
    {
        $image_settings = $this->getCurrentOcImageSettings();

        switch ($products_per_row) {
            case 'size_1':
                $image_settings = array_merge($image_settings, array(
                    'config_image_product_width'     => 180,
                    'config_image_product_height'    => 180,
                    'config_image_related_width'     => 180,
                    'config_image_related_height'    => 180
                ));
                break;
            case 'size_2':
                $image_settings = array_merge($image_settings, array(
                    'config_image_product_width'     => 140,
                    'config_image_product_height'    => 140,
                    'config_image_related_width'     => 140,
                    'config_image_related_height'    => 140
                ));
                break;
        }

        $this->manager->getDbSettingsHelper()->persistGroup('config', $image_settings, $this->context->getStoreId());

        return $image_settings;
    }

    public function setProductGalleryPositionImageSettings($product_gallery_position)
    {
        $image_settings = $this->getCurrentOcImageSettings();

        if ($product_gallery_position == 'tab') {
            $image_settings['config_image_additional_width']  = 140;
            $image_settings['config_image_additional_height'] = 140;
        } else
        if ($product_gallery_position == 'under_preview') {
            $image_settings['config_image_additional_width']  = 70;
            $image_settings['config_image_additional_height'] = 70;
        }

        $this->manager->getDbSettingsHelper()->persistGroup('config', $image_settings, $this->context->getStoreId());

        return $image_settings;
    }
}