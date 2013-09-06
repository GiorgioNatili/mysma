<?php

class Theme_Admin_PaymentImagesPlugin extends TB_ExtensionPlugin
{
    public function setForm()
    {
        $settings = $this->getModel()->getSettings();
        if (!isset($settings['payment']['images']) || empty($settings['payment']['images'])) {
            return array('payment_images' => array());
        }

        $images = $settings['payment']['images'];
        foreach ($images as $key => &$values) {
            if ($values['file'] && file_exists(DIR_IMAGE . $values['file'])) {
                $values['preview'] = $this->getOcModel('tool/image')->resize($values['file'], 51, 32);
            } else {
                unset($images[$key]);
            }
        }

        return array('payment_images' => $images);
    }

    public function saveForm($form)
    {
        if (!isset($form['payment']['images']) || empty($form['payment']['images'])) {

            return array('payment' => array('images' => array()));
        }

        $images = (array) $form['payment']['images'];
        $orders = array();
        foreach ($images as $key => $values) {
            $order = (int) $values['order'];
            $orders[] = $order;
        }
        sort($orders);

        $result = array();
        foreach ($images as $key => $values) {
            $order = (int) $values['order'];
            $key = array_search($order, $orders);
            $result[$key] = $values;
            unset($orders[$key]);
        }
        ksort($result);

        foreach ($result as $key => $values) {
            if (!empty($values['image'])) {
                $result[$key]['order']  = $key + 1;
                $result[$key]['file']   = $values['image'];
                $result[$key]['url']    = $values['url'];
            }
        }

        return array('payment' => array('images' => $result));
    }
}