<?php

class Theme_CategoryModel extends TB_ExtensionModel
{
    protected $tree;
    protected $flat_tree;
    private $url_links = array();

    public function getCategoriesByParent($parent_id = 0)
    {
        $sql = 'SELECT *
                FROM '      . DB_PREFIX . 'category c
                LEFT JOIN ' . DB_PREFIX . 'category_description cd ON (c.category_id = cd.category_id)
                LEFT JOIN ' . DB_PREFIX . 'category_to_store c2s ON (c.category_id = c2s.category_id)
                WHERE c.parent_id = ' . (int) $parent_id . '
                      AND cd.language_id = ' . (int) $this->config->get('config_language_id') . '
                      AND c2s.store_id = ' . (int) $this->config->get('config_store_id') . '
                      AND c.status = 1 AND c.sort_order <> -1
                ORDER BY c.sort_order, LCASE(cd.name)';
        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function getCategoriesByParentWithTotalProducts($parent_id = 0)
    {
        $sql = 'SELECT c.*, cd.*, COUNT(p2c.category_id) AS products_count
                FROM '       . DB_PREFIX . 'category c
                INNER JOIN ' . DB_PREFIX . 'category_description cd ON (c.category_id = cd.category_id)
                INNER JOIN ' . DB_PREFIX . 'category_to_store c2s ON (c.category_id = c2s.category_id)
                LEFT JOIN '  . DB_PREFIX . 'product_to_store AS p2s ON p2s.store_id = c2s.store_id
                LEFT JOIN '  . DB_PREFIX . 'product_to_category AS p2c ON c.category_id = p2c.category_id AND p2c.product_id = p2s.product_id
                WHERE c.parent_id = ' . (int) $parent_id . '
                      AND cd.language_id = ' . (int) $this->config->get('config_language_id') . '
                      AND c2s.store_id = ' . (int) $this->config->get('config_store_id') . '
                      AND c.status = 1 AND c.sort_order <> -1
                GROUP BY c.category_id
                ORDER BY c.sort_order, LCASE(cd.name)';
        $query = $this->db->query($sql);

        return $query->rows;
    }


    public function getCategoryTreeWithTotalProductsMaxLevel2()
    {
        $tree = $this->getCategoriesTree();
        if (empty($tree)) {
            return array();
        }

        $ids = array();
        foreach  ($tree as $category_id => $category) {
            $ids[] = $category_id;
            foreach ($category['children'] as $child_id => $child) {
                $ids[] = $child_id;
                unset($tree[$category_id]['children'][$child_id]['children']);
                unset($tree[$category_id]['children'][$child_id]['children_ids']);
            }
        }

        $sql = 'SELECT c.category_id, COUNT(p2c.category_id) AS products_count, GROUP_CONCAT(p2c.product_id) AS ids
                FROM '      . DB_PREFIX . 'category c
                INNER JOIN ' . DB_PREFIX . 'category_description cd ON (c.category_id = cd.category_id)
                INNER JOIN ' . DB_PREFIX . 'category_to_store c2s ON (c.category_id = c2s.category_id)
                LEFT JOIN '  . DB_PREFIX . 'product_to_store AS p2s ON p2s.store_id = c2s.store_id
                LEFT JOIN '  . DB_PREFIX . 'product_to_category AS p2c ON c.category_id = p2c.category_id AND p2c.product_id = p2s.product_id
                WHERE c.category_id IN (' . implode(',', $ids) . ')
                      AND cd.language_id = ' . (int) $this->config->get('config_language_id') . '
                      AND c2s.store_id = ' . (int) $this->config->get('config_store_id') . '
                      AND c.status = 1 AND c.sort_order <> -1
                GROUP BY c.category_id
                ORDER BY c.sort_order, LCASE(cd.name)';
        $query = $this->db->query($sql);
        $hydrated = array();
        foreach ($query->rows as $row) {
            $row['ids'] = $row['ids'] != null ? explode(',', $row['ids']) : array();
            $hydrated[$row['category_id']] = $row;
        }

        foreach ($tree as $category_id => &$category) {
            $category['products_count'] = $hydrated[$category_id]['products_count'];
            foreach ($category['children'] as $child_id => &$child) {
                $child['products_count'] = $hydrated[$child_id]['products_count'];
                if ($a = count(array_intersect($hydrated[$child_id]['ids'], $hydrated[$category_id]['ids']))) {
                    $category['products_count'] += $child['products_count'] - $a;
                }
            }
        }

        return $tree;
    }

    public function getCategory($category_id)
    {
        $sql = 'SELECT *
                FROM ' . DB_PREFIX . 'category AS c
                LEFT JOIN ' . DB_PREFIX . 'category_description AS cd ON (c.category_id = cd.category_id)
                WHERE c.category_id = ' . (int) $category_id . '
                      AND cd.language_id = ' . (int) $this->config->get('config_language_id');
   		$query = $this->db->query($sql);

   		return $query->row;
   	}

    public function getAllCategoriesGroupedByParent()
    {
        static $result = null;

        if (null !== $result) {
            return $result;
        }

        $sql = "SELECT *
                FROM "      . DB_PREFIX . "category c
                LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id)
                LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id)
                WHERE cd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND
                      c2s.store_id = '" . (int) $this->config->get('config_store_id') . "'  AND
                      c.status = '1' AND c.sort_order <> '-1'
                ORDER BY c.sort_order, LCASE(cd.name)";
        $query = $this->db->query($sql);

        $result = array();
        foreach ((array) $query->rows as $row) {
            $id = $row['parent_id'] ? $row['parent_id'] : '';
            $result[$id][] = $row;
        }

        return $result;
    }

    public function getTreeById($category_id)
    {
        $tree = $this->getCategoriesTree();
        if (isset($tree[$category_id])) {
            return $tree[$category_id];
        }

        $flat_tree = $this->getCategoriesFlatTree();
        if (!isset($flat_tree[$category_id])) {
            return false;
        }

        $path_arr = explode('_', $flat_tree[$category_id]['path']);
        $root_id = array_shift($path_arr);

        if (!isset($tree[$root_id])) {
            return false;
        }

        return $this->getCategoryTreeByPath($path_arr, $tree[$root_id]['children']);
    }

    public function getTreeByPath($path)
    {
        $tree = $this->getCategoriesTree();

        $path_arr = explode('_', $path);
        if (count($path_arr) == 1) {
            if (isset($tree[$path])) {
                return $tree[$path];
            } else {
                return false;
            }
        }
        $root_id = array_shift($path_arr);

        return $this->getCategoryTreeByPath($path_arr, $tree[$root_id]['children']);
    }

    private function getCategoryTreeByPath(array $path_arr, $tree)
    {
        if (count($path_arr) > 1) {
            $root_id = array_shift($path_arr);
            $result = $this->getCategoryTreeByPath($path_arr, $tree[$root_id]['children']);
        } else {
            $result = $tree[$path_arr[0]];
        }

        return $result;

    }

    public function getCategoriesTree()
    {
        if (null !== $this->tree) {
            return $this->tree;
        }

        if ($this->tbManager->isExtensionInstalled('tb_smartcache')) {
            $this->tree = $this->tbManager->getExtension('tb_smartcache')->getModel()
                    ->getCacheVar('category_tree.' . $this->context->getStoreId() . '.' . (int) $this->config->get('config_language_id'), array($this, 'buildCategoriesTree'));
        } else {
            $this->tree = $this->buildCategoriesTree();
        }

        return $this->tree;
    }

    public function buildCategoriesTree()
    {
        return $this->generateCategoriesTree($this->getAllCategoriesGroupedByParent());
    }

    public function getCategoryFromFlatTree($category_id)
    {
        $flat_tree = $this->getCategoriesFlatTree();
        if (isset($flat_tree[$category_id])) {
            return $flat_tree[$category_id];
        }

        return false;
    }

    public function getCategoriesFlatTree()
    {
        if (null !== $this->flat_tree) {
            return $this->flat_tree;
        }

        if ($this->tbManager->isExtensionInstalled('tb_smartcache')) {
            $this->flat_tree = $this->tbManager->getExtension('tb_smartcache')->getModel()
                    ->getCacheVar('category_flat_tree.' . $this->context->getStoreId() . '.' . (int) $this->config->get('config_language_id'), array($this, 'buildCategoriesFlatTree'));
        } else {
            $this->flat_tree = $this->buildCategoriesFlatTree($this->getAllCategoriesGroupedByParent());
        }

        return $this->flat_tree;
    }

    public function buildCategoriesFlatTree()
    {
        return $this->generateCategoriesFlatTree($this->getAllCategoriesGroupedByParent());
    }

    private function generateCategoriesTree(array $data, $with_children = true, $value = array(), $level = 0, $current_path = '')
    {
        $level++;
        $parent_id = isset($value['category_id']) ? $value['category_id'] : '';

        if (!isset($data[$parent_id])) {
            return array();
        }

        $result = array();
        foreach ($data[$parent_id] as $val) {
            if (!$current_path) {
                $new_path = $val['category_id'];
            } else {
                $new_path = $current_path . '_' . $val['category_id'];
            }

            if (isset($data[$val['category_id']]) && $with_children) {
                $val['children'] = $this->generateCategoriesTree($data, $with_children, $val, $level, $new_path);
            } else {
                $val['children'] = array();
            }

            $children_ids = array();
            foreach ($val['children'] as $child) {
                $children_ids[] = (int) $child['category_id'];
                $children_ids = array_merge($children_ids, $child['children_ids']);
            }

            if (!isset($this->url_links[$new_path])) {
                $this->url_links[$new_path] = $this->registry->get('url')->link('product/category', 'path=' . $new_path);
            }
            $result[$val['category_id']] = array(
                'category_id'  => $val['category_id'],
                'parent_id'    => $val['parent_id'],
                'name'         => $val['name'],
                'top'          => $val['top'],
                'image'        => $val['image'],
                'path'         => $new_path,
                'level'        => $level,
                'url'          => $this->url_links[$new_path],
                'children_ids' => $children_ids,
                'children'     => $val['children']
            );
        }

        return $result;
    }

    private function generateCategoriesFlatTree(array $data, $value = array(), $level = 0, $current_path = '')
    {
        $level++;
        $parent_id = isset($value['category_id']) ? $value['category_id'] : '';

        if (!isset($data[$parent_id])) {
            return array();
        }

        $result = array();
        foreach ($data[$parent_id] as $val) {
            if (!$current_path) {
                $new_path = $val['category_id'];
            } else {
                $new_path = $current_path . '_' . $val['category_id'];
            }

            if (!isset($this->url_links[$new_path])) {
                $this->url_links[$new_path] = $this->registry->get('url')->link('product/category', 'path=' . $new_path);
            }
            $result[$val['category_id']] = array(
                'category_id' => $val['category_id'],
                'parent_id'   => $val['parent_id'],
                'name'        => $val['name'],
                'top'         => $val['top'],
                'image'       => $val['image'],
                'path'        => $new_path,
                'level'       => $level,
                'url'         => $this->url_links[$new_path]
            );

            if (isset($data[$val['category_id']])) {
                $children = $this->generateCategoriesFlatTree($data, $val, $level, $new_path);
            } else {
                $children = array();
            }

            $children_ids = array();
            foreach ($children as $child) {
                $children_ids[] = (int) $child['category_id'];
                $children_ids = array_merge($children_ids, $child['children_ids']);
            }
            $result[$val['category_id']]['children_ids'] = $children_ids;

            $result = $result + $children;
        }

        return $result;
    }
}