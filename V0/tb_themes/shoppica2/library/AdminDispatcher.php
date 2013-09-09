<?php

require_once TB_THEME_ROOT . '/library/AdminManager.php';
require_once TB_THEME_ROOT . '/library/AdminController.php';
require_once TB_THEME_ROOT . '/library/AdminExtension.php';
require_once TB_THEME_ROOT . '/library/AdminUrl.php';

class TB_AdminDispatcher
{
    /**
     * @var TB_AdminManager
     */
    private static $tbManager;

    /**
     * @var array
     */
    private static $config;

    /**
     * @var Registry
     */
    private $registry;

    /**
     * @var string
     */
    private $basename;

    public function __construct($registry, $basename)
    {
        $this->registry = $registry;
        $this->basename = $basename;
        $this->initTbManager();
    }

    public function dispatch()
    {
        $request = $this->registry->get('request');

        $extension_name = $this->basename;
        if (isset($request->get['extension'])) {
            $extension_name = (string) $request->get['extension'];
        }
        if (isset($request->post['extension'])) {
            $extension_name = (string) $request->post['extension'];
        }

        $controller_name = 'default';
        if (isset($request->get['controller'])) {
            $controller_name = (string) $request->get['controller'];
        }
        if (isset($request->post['controller'])) {
            $controller_name = (string) $request->post['controller'];
        }

        $action = 'index';
        if (isset($request->get['action'])) {
            $action = (string) $request->get['action'];
        }
        if (isset($request->post['action'])) {
            $action = (string) $request->post['action'];
        }

        $event = new sfEvent($this, 'core:admin_dispatch', array(
            'controller_name' => $controller_name,
            'action_name'     => $action,
            'extension_name'  => $extension_name
        ));
        self::$tbManager->getEventDispatcher()->notify($event);

        $extension = self::$tbManager->getExtension($extension_name);
        $this->initExtensionDataBag($extension);

        $controller = $extension->getController($controller_name);
        if (method_exists($controller, 'init')) {
            call_user_func(array($controller, 'init'));
        }
        if (method_exists($controller, $action)) {
            call_user_func(array($controller, $action));
        } else {
            throw new Exception('Controller action not found: ' . $controller_name . '->' . $action);
        }
    }

    protected function initTbManager()
    {
        if (null !== self::$tbManager) {
            return;
        }

        $request = $this->registry->get('request');
        $store_id = 0;
        if (isset($request->get['store_id'])) {
            $store_id = (int) $request->get['store_id'];
        } else
        if (isset($request->post['store_id'])) {
            $store_id = (int) $request->post['store_id'];
        }

        $this->initThemeConfig();
        $context = new TB_Context($this->registry, self::$config, $store_id, 'admin');
        self::$tbManager = TB_AdminManager::getInstance($context);
        self::$tbManager->initExtensions($this->getDataBag());

        $this->registry->set('tbManager', self::$tbManager);
    }

    protected function initThemeConfig()
    {
        if (null !== self::$config) {
            return;
        }

        $config_file = realpath(DIR_SYSTEM . '../') . '/tb_themes/' . $this->basename . '/config.php';
        if (!file_exists($config_file)) {
            throw new Exception('The theme config file cannot be found: ' . $config_file);
        }

        $theme_config = require $config_file;
        if (!is_array($theme_config)) {
            throw new Exception('Theme config structure is not array');
        }

        $theme_config['basename'] = $this->basename;

        self::$config = $theme_config;
    }

    protected function getDataBag()
    {
        $dataBag = new TB_DataBag();
        $context = self::$tbManager->getContext();

        $init_vars = array();

        $init_vars['current_url']  = $context->getRequestUrl();
        $init_vars['base_http']    = $context->getBaseHttp();
        $init_vars['base_https']   = $context->getBaseHttps();
        $init_vars['base_httpsIf'] = $context->getBaseHttpsIf();
        $init_vars['basename']     = $context->getBasename();
        $init_vars['store_id']     = $context->getStoreId();
        $init_vars['token']        = isset($this->registry->get('session')->data['token']) ? $this->registry->get('session')->data['token'] : null;
        $init_vars['basename']     = $this->basename;
        $init_vars['isHTTPS']      = TB_Utils::isRequestHTTPS();

        $init_vars['theme_catalog_resource_url']   = $context->getThemeCatalogResourceUrl();
        $init_vars['theme_catalog_image_url']      = $context->getThemeCatalogImageUrl();
        $init_vars['theme_catalog_stylesheet_url'] = $context->getThemeCatalogStylesheetUrl();
        $init_vars['theme_catalog_javascript_url'] = $context->getThemeCatalogJavascriptUrl();

        $init_vars['theme_admin_resource_url']   = $context->getThemeAdminResourceUrl();
        $init_vars['theme_admin_image_url']      = $context->getThemeAdminImageUrl();
        $init_vars['theme_admin_stylesheet_url'] = $context->getThemeAdminStylesheetUrl();
        $init_vars['theme_admin_javascript_url'] = $context->getThemeAdminJavascriptUrl();

        $dataBag->importVars($init_vars);
        $dataBag->tbSlot = new TB_ViewSlot(self::$tbManager->getEventDispatcher());

        return $dataBag;
    }

    protected function initExtensionDataBag(TB_AdminExtension $extension)
    {
        $dataBag = $extension->getDataBag();
        $context = self::$tbManager->getContext();

        if ($extension->isThemeExtension()) {
            $init_vars['extension_catalog_resource_url'] = $context->getThemeCatalogResourceUrl();
            $init_vars['extension_admin_resource_url']   = $context->getThemeAdminResourceUrl();
        } else {
            $extensions_url = $context->getBaseHttpsIf() . 'tb_extensions/' . $extension->getName() . '/';
            $init_vars['extension_catalog_resource_url'] = $extensions_url . 'catalog/view/';
            $init_vars['extension_admin_resource_url']   = $extensions_url . 'admin/view';
        }

        $dataBag->importVars($init_vars);
    }

    public function installTheme()
    {
        $event = new sfEvent($this, 'core:admin_module_install');
        self::$tbManager->getEventDispatcher()->notify($event);
    }
}