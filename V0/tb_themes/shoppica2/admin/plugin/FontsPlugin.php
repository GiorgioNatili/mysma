<?php

class Theme_Admin_FontsPlugin extends TB_ExtensionPlugin
{
    public function saveForm($form)
    {
        if (isset($form['font'])) {
            return array('font' => $this->tbExtension->getModel('fonts')->combineFormData($form['font']));
        }

        return false;
    }
}