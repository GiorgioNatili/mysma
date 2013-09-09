<?php

require_once dirname(__FILE__) . '/../../model/categoryModel.php';

class Theme_Catalog_CategoryModel extends Theme_CategoryModel
{
    public function getCategoryChildrenIds($category_id)
    {
        $category = $this->getCategoryFromFlatTree($category_id);
        if (false === $category) {
            return array();
        }

        return $category['children_ids'];
    }
}