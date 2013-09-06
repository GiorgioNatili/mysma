<?php

class Theme_Catalog_SchemerStylesPlugin extends TB_ExtensionPlugin
{
    public function execute(TB_DataBag $tbData)
    {
        $category_path = isset($this->request->get['path']) ? (string) $this->request->get['path'] : '0';
        $schemer_config = $this->getModel('schemer')->getSchemerConfig($category_path);
        $css = $this->getModel('schemer')->getSchemerCss($schemer_config);
        $tbData->addJavascriptVar('tb/schemer_config', $schemer_config);

        $tbData->schemer_css = $css;
    }
}