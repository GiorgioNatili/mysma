<?php

class Theme_Catalog_CommonPlugin extends TB_ExtensionPlugin
{
    public function execute(TB_DataBag $tbData)
    {
        $common = $this->extension_settings['common'];
        if ($tbData->is_mobile) {
            if ($common['price_design'] == 'label' && $common['price_size'] == '3') {
                $common['price_size'] = '2';
            }

            $common['column_position']              = 'right';
            $common['products_per_row']             = 'size_2';
            $common['compare_enabled']              = 0;
            $common['product_social_share_enabled'] = 0;
            $common['product_gallery_position']     = 'under_preview';
        }

        $event = new sfEvent($this, 'theme:catalog_common_plugin.filter_common', array('tbData' => $tbData));
        $common = $this->eventDispatcher->filter($event, $common)->getReturnValue();

        if (isset($common['language_direction'][$this->language_id])) {
            $common['language_direction'] = $common['language_direction'][$this->language_id];
        } else {
            $common['language_direction'] = 'ltr';
        }

        $tbData->common = $common;
    }
}