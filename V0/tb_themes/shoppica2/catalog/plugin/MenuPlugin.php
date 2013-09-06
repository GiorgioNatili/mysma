<?php

class Theme_Catalog_MenuPlugin extends TB_ExtensionPlugin
{
    protected $tbData;

    public function execute(TB_DataBag $tbData)
    {
        $this->bootstrap('common');

        $this->tbData = $tbData;

        $lang_vars = $this->tbExtension->loadOcLanguage('common/footer');
        $category_tree = $this->getModel('category')->getCategoriesTree();
        if ($this->tbExtension->getManager()->isExtensionInstalled('tb_smartcache')) {
            $language_id = $this->getModel()->getCurrentLanguage('language_id');
            $menu_categories = $this->tbExtension->getManager()->getExtension('tb_smartcache')->getModel()
                ->getCacheVar('menu_categories_html.' . $this->context->getStoreId() . '.' . $language_id,
                array($this, 'fetchMenuCategories'), array($lang_vars, $category_tree)
            );
        } else {
            $menu_categories = $this->fetchMenuCategories($lang_vars, $category_tree);
        }
        $tbData->category_tree = $category_tree;
        $informations = $this->getOcModel('catalog/information')->getInformations();

        $menu = $this->tbExtension->fetchTemplate('menu', array(
            'informations' => $informations, 'menu_categories' => $menu_categories) + $lang_vars
        );

        $tbData->menuHTML = $menu;
    }

    public function fetchMenuCategories($lang_vars, $category_tree)
    {
        $this->tbData->addCallable(array($this, 'getCategorySubMenu'));
        $this->tbData->addCallable(array($this, 'getCategoryManufacturers'));

        return $this->tbExtension->fetchTemplate('menu_categories', array('category_tree' => $category_tree) + $lang_vars);
    }


    public function getCategorySubMenu($category)
    {
        if (!empty($category['children'])) {
            return $this->tbExtension->fetchTemplate('menu_categories_item', array('category' => $category));
        }

        return '';
    }

    public function getCategoryManufacturers($category)
    {
        $category['children_ids'][] = $category['category_id'];

        return $this->getModel('manufacturer')->getManufacturersByCategoryIds($category['children_ids']);
    }
}