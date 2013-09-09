<?php

class Theme_Admin_BackgroundImagesPlugin extends TB_ExtensionPlugin
{
    public function setForm()
    {
        $settings = $this->getModel()->getSettings();
        if (!isset($settings['background']['images']) || empty($settings['background']['images'])) {
            return array('background_images' => array());
        }

        $backgrounds = (array) $settings['background']['images'];
        foreach ($backgrounds as $key => &$values) {
            if ($values['image'] && file_exists(DIR_IMAGE . $values['image'])) {
                $values['preview'] = $this->getOcModel('tool/image')->resize($values['image'], 100, 100);
            } else {
                unset($backgrounds[$key]);
            }
        }

        return array('background_images' => $backgrounds);
    }

    public function saveForm($form)
    {
        if (!isset($form['background']['images']) || empty($form['background']['images'])) {
            return array('background' => array('images' => array()));
        }

        $images = (array) $form['background']['images'];
        $config = array();
        foreach ($images as $key => $values) {
            if (!empty($values['image'])) {
                if (empty($values['name'])) {
                    $values['name'] = 'random' . rand(0, 999999);
                }
                $config[$values['id']] = $values;
            }
        }

        return array('background' => array('images' => $config));
    }
}