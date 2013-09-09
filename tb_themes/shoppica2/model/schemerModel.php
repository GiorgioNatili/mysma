<?php

class Theme_SchemerModel extends TB_ExtensionModel
{
    protected $schemes = array();

    public function getSchemerConfig($path)
    {
        static $result = array();

        if(empty($path)) {
            $path = '0';
        } else {
            settype($path, 'string');
        }

        if (isset($result[$path])) {
            return $result[$path];
        }

        $config = $this->getCascadeConfig($path);
        $category_id = 0;
        if ($path != '0') {
            $path_arr = explode('_', $path);
            $category_id = (int) end($path_arr);
        }

        $category = false;
        if ($category_id != 0) {
            $category = $this->tbExtension->getModel('category')->getCategory($category_id);
        }

        if ($category) {
            if ($category['parent_id'] != 0) {
                $parent = $this->tbExtension->getModel('category')->getCategory($category['parent_id']);
                $config['parent_name'] = $parent['name'];
            } else {
                $config['parent_name'] = 'Global';
            }
        }

        $result[$path] = $config;

        return $config;
    }

    protected function getCascadeConfig($path)
    {
        static $result = array();

        if(empty($path)) {
            $path = '0';
        } else {
            settype($path, 'string');
        }

        if (!empty($result[$path])) {
            return $result[$path];
        }

        $ipath = $path;
        if ($path != '0') {
            $path = '0_' . $path;
        }

        $settings = $this->getSettings();
        $config = isset($settings['schemer']) ? $settings['schemer'] : array();
        $schemes = $this->getPredefinedSchemes();
        $default_scheme = $this->context->getThemeConfig()->default_scheme;
        $vars = array();
        $parts = explode('_', $path);
        for ($i = 0, $j = count($parts); $i < $j; $i++) {
            if ($path != '0') {
                $path = substr($path, 2);
            }
            if (isset($config[$path]) && isset($config[$path]['predefined_scheme']) && $config[$path]['predefined_scheme'] != 'parent') {
                if ($config[$path]['predefined_scheme'] == 'custom') {
                    $vars = $config[$path];
                    break;
                }
                if (in_array($config[$path]['predefined_scheme'], array_keys($schemes))) {
                    $config[$path]['colors'] = $schemes[$config[$path]['predefined_scheme']];
                    $vars = $config[$path];
                    break;
                }
            }
            $path = implode('_', array_slice($parts, 0, $j-$i-1));
        }

        if (empty($vars)) {
            $vars['path']              = '0';
            $vars['is_parent']         = '1';
            $vars['predefined_scheme'] = $default_scheme;
            $vars['parent_scheme']     = $default_scheme;
            $vars['colors']            = $schemes[$default_scheme];
            $vars['parent_vars']       = array();
            $vars['parent_vars']['colors']  = $schemes[$default_scheme];
        } else {

            if ($vars['path'] != $ipath) {
                // Parent config
                $vars['is_parent'] = '1';
                $vars['parent_scheme'] = $vars['predefined_scheme'];
                $copy_vars = $vars;
                $vars['parent_vars']  = $copy_vars;

            } else {
                // Direct hit, a configuration exists for the initial path
                $vars['is_parent'] = '0';
                if ($path != '0') {
                    array_pop($parts);
                    array_shift($parts);
                    $parent_vars = $this->getCascadeConfig(implode('_', $parts));
                    $vars['parent_scheme'] = $parent_vars['predefined_scheme'];
                    $vars['parent_vars']   = $parent_vars;
                } else {
                    $vars['parent_vars']  = array();
                    $vars['parent_vars']['colors']  = array();
                }
            }
        }

        $result[$ipath] = $vars;

        return $vars;
    }

    public function getPredefinedSchemes()
    {
        if(!empty($this->schemes)) {
            return $this->schemes;
        }

        $schemes_dir = $this->tbExtension->getRootDir() . '/schemes/';
        $files = $paths = sfFinder::type('file')->maxdepth(0)->in($schemes_dir);
        foreach ($files as $file) {
            $this->schemes += require $file;
        }

        return $this->schemes;
    }
}