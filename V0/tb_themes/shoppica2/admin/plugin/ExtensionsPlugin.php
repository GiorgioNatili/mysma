<?php

class Theme_Admin_ExtensionsPlugin extends TB_ExtensionPlugin
{
    public function setForm()
    {
        return array(
            'not_installed_extensions' => $this->manager->getNotInstalledExtensions(),
            'installed_extensions'     => $this->manager->getExtensions()
        );
    }
}