<?php

class Theme_Catalog_FacebookMetaPlugin extends TB_ExtensionPlugin
{
    public function execute(TB_DataBag $tbData)
    {
        $fb_meta = '';
        if ($tbData->route == 'product/product' && isset($this->request->get['product_id'])) {
            $product_id = (int) $this->request->get['product_id'];
            $product_info = $this->getOcModel('catalog/product')->getProduct($product_id);
            if ($product_info) {
                if ($product_info['image']) {
                    $width = $this->config->get('config_image_thumb_width');
                    $height = $this->config->get('config_image_thumb_height');
                    $thumb = $this->getOcModel('tool/image')->resize($product_info['image'], $width, $height);
                } else {
                    $thumb = $tbData->res_url . '/image/no_image.jpg';
                }
                $fb_meta = '<meta property="og:image" content="' . $thumb . '" />';
            }
        }

        $tbData->fbMeta = $fb_meta;
    }
}