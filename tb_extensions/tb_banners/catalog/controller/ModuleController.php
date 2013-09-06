<?php

class TbBanners_Catalog_ModuleController extends TB_CatalogController
{
    public function index($setting)
    {
        $extension_settings = $this->getModel()->getSettings();
        $sets = $extension_settings['sets'];
        $images = array();
        if (false !== $sets && isset($sets[$setting['setId']])) {
            $set = $sets[$setting['setId']];

            $event = new sfEvent($this, 'tb_banners:catalog_module_controller.filter_set', array('tbData' => $this->tbData));
            $set = $this->tbManager->getEventDispatcher()->filter($event, $set)->getReturnValue();

            if (empty($set)) {
                return;
            }

            $language_id = $this->getModel()->getCurrentLanguage('id');
            if (isset($set['images'][$language_id]) && is_array($set['images'][$language_id])) {
                $images = $set['images'][$language_id];
                foreach($images as &$image) {
                    $image['http_file'] = $this->context->getImageUrl() . $image['file'];
                }
            } else {
                return;
            }
        }
        $this->data['banners'] = $images;

        $this->renderTemplate('banners');
    }
}