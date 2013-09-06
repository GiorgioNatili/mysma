<?php

class Theme_Admin_SchemerController extends TB_AdminController
{
    public function index()
    {
        foreach ($this->tbExtension->getPlugin('schemer')->setForm() as $key => $data) {
            $this->data[$key] = $data;
        }

        $this->renderAction('theme_design_schemer.tpl');
    }

    public function showCatalogSchemer()
    {
        $hash = sha1(uniqid(TB_Utils::genRandomString(10), true));
        $data = array($hash, $this->user->getId());
        $this->tbManager->getSettingsModel()->setAndPersistScopeSettings('color_schemer_auth', $data);

        if ($this->context->getStoreId() == 0) {
            $this->redirect(HTTP_CATALOG . '?color_schemer_auth_hash=' . $hash);
        } else {
            $url = $this->tbManager->getDbSettingsHelper()->getKey('config_url', $this->context->getStoreId());
            $this->redirect($url . '?color_schemer_auth_hash=' . $hash);
        }
    }
}