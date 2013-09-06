<?php

class Theme_Catalog_IntroPlugin extends TB_ExtensionPlugin
{
    public function execute(TB_DataBag $tbData)
    {
        $route = $tbData->route;
        $tbData->introHTML = '';

        if ($route != 'product/category' && $route != 'common/home') {
            return;
        }

        $category_path = isset($this->request->get['path']) ? (string) $this->request->get['path'] : '0';
        $config = $this->getModel()->getIntroCascadeConfig($category_path);
        if ($config['type'] == 'products' && $tbData->is_mobile) {
            $config['products']['size'] = '1';
        }

        $intro_data = $this->getModel()->getIntroData($config);
        $event = new sfEvent($this, 'theme:catalog_intro_plugin.filter_intro', array('tbData' => $tbData));
        $intro_data = $this->eventDispatcher->filter($event, $intro_data)->getReturnValue();
        if (false === $intro_data || $intro_data['type'] == 'nointro') {
            return;
        }

        $intro = $this->tbExtension->fetchTemplate('intro/' . $intro_data['type'], $intro_data['data']);
        $tbData->introHTML = $intro;
    }
}