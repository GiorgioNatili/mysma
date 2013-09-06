<?php

class Theme_Admin_CustomStylesheetPlugin extends TB_ExtensionPlugin
{
    public function setForm()
    {
        $custom_stylesheet = $this->manager->getSettingsModel()->getScopeSettings('custom_stylesheet');

        return array('custom_stylesheet' => $custom_stylesheet);
    }

    public function saveForm($form)
    {
        $this->manager
             ->getSettingsModel()
             ->setAndPersistScopeSettings('custom_stylesheet', (string) $form['custom_stylesheet']);

        return false;
    }
}