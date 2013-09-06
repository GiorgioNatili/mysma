<?php

class Theme_Catalog_ProductListingTypePlugin extends TB_ExtensionPlugin
{
    public function execute(TB_DataBag $tbData)
    {
        if ($tbData->is_mobile) {
            $tbData->product_listing_type = 'grid';

            return;
        }

        if (isset($this->request->get['setListingType'])) {
            $listingType = (string) $this->request->get['setListingType'];
            if ($listingType == 'grid' || $listingType == 'list') {
                setcookie('listingType', $listingType, time() + 604800, '/', $this->request->server['HTTP_HOST']);
                if (!isset($_SERVER['HTTP_REFERER']) || empty($_SERVER['HTTP_REFERER'])) {
                    $_SERVER['HTTP_REFERER'] = getenv('HTTP_REFERER');
                }
                if(!empty($_SERVER['HTTP_REFERER'])){
                    header('Status: 302');
                    header('Location: ' . str_replace('&amp;', '&', $_SERVER['HTTP_REFERER']));

                    exit();
                }
            }
        } else
            if (isset($_COOKIE['listingType']) && ($_COOKIE['listingType'] == 'grid' || $_COOKIE['listingType'] = 'list')) {
                $listingType = $_COOKIE['listingType'];
            } else {
                $listingType = $this->extension_settings['common']['product_listing_type'];
            }

        $tbData->product_listing_type = $listingType;
    }
}