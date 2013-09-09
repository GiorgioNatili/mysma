<?php

class Theme_Catalog_SubcategoriesPlugin extends TB_ExtensionPlugin
{
    public function execute(TB_DataBag $tbData)
    {
        $this->bootstrap('common');

        $tbData->subcategories = array();

        if ($tbData->route != 'product/category' ||
            !isset($this->request->get['path']) ||
            !$tbData->common['subcategories_enabled']) {

            return;
        }

        $path = (string) $this->request->get['path'];
        $path_arr = explode('_', $path);
        $category_id = (int) end($path_arr);

        if (!$category_id) {
            return;
        }

        if ($tbData->common['subcategories_count_enabled']) {
            $subcategories = $this->getModel('category')->getCategoriesByParentWithTotalProducts($category_id);
        } else {
            $subcategories = $this->getModel('category')->getCategoriesByParent($category_id);
        }
        if (empty($subcategories)) {
            return;
        }

        foreach ($subcategories as &$category) {
            if ($this->extension_settings['common']['subcategories_style'] == 'thumbs')  {
                if ($category['image']) {
                    $image = $category['image'];
                } else {
                    $image = 'no_image.jpg';
                }
                $category['thumb'] = (string) $this->getOcModel('tool/image')
                    ->resize($image, $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
            }

            if (!$tbData->common['subcategories_count_enabled']) {
                $category['products_count'] = null;
            }

            $category_from_tree = $this->getModel('category')->getCategoryFromFlatTree($category['category_id']);
            $category['url'] = $category_from_tree['url'];

            $category['description'] = html_entity_decode($category['description'], ENT_QUOTES, 'UTF-8');
            $category['path']  = $path . '_' . $category['category_id'];
        }

        $tbData->subcategories = $subcategories;
    }
}