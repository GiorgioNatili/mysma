<?php

class Theme_Catalog_RightColumnEmptyPlugin extends TB_ExtensionPlugin
{
    public function execute(TB_DataBag $tbData)
    {
        $layout_id = $tbData->current_layout_id;
        $column_empty = true;
        foreach ($this->tbExtension->getOcModel('setting/extension')->getExtensions('module') as $extension) {
            $modules = $this->config->get($extension['code'] . '_module');
            if (is_array($modules) && !empty($modules)) {
                foreach ($modules as $module) {
                    if ($module['layout_id'] == $layout_id && $module['position'] == 'column_right' && $module['status']) {
                        $column_empty = false;
                    }
                }
            }
        }

        $event = new sfEvent($this, 'theme:catalog_RightColumnEmpty_plugin.filter_columnEmpty', array('tbData' => $tbData));
        $column_empty = $this->eventDispatcher->filter($event, $column_empty)->getReturnValue();

        $tbData->right_column_empty = $column_empty;
    }
}