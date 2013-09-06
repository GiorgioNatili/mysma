<?php

class Theme_Catalog_PaymentImagesPlugin extends TB_ExtensionPlugin
{
    public function execute(TB_DataBag $tbData)
    {
        $payment_images = array();
        if (isset($this->extension_settings['payment']['images'])) {
            $payment_images = $this->extension_settings['payment']['images'];
            foreach($payment_images as &$image) {
                $image['http_file'] = $this->context->getImageUrl() . $image['file'];
            }
        }

        $event = new sfEvent($this, 'theme:catalog_paymentImages_plugin.filter_images', array('tbData' => $tbData));
        $payment_images = $this->eventDispatcher->filter($event, $payment_images)->getReturnValue();

        $tbData->payment_images = $payment_images;
    }
}