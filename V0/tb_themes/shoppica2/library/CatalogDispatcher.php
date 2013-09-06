<?php

require_once TB_THEME_ROOT . '/library/CatalogManager.php';
require_once TB_THEME_ROOT . '/library/CatalogController.php';
require_once TB_THEME_ROOT . '/library/CatalogExtension.php';
require_once TB_THEME_ROOT . '/library/CatalogModuleAction.php';

class TB_CatalogDispatcher
{
    /**
     * @var Registry
     */
    protected $registry;

    /**
     * @var Config
     */
    protected $config;

    /**
     * @var TB_ThemeManager
     */
    protected $tbManager;

    /**
     * @var Front
     */
    protected $front_controller;

    public function __construct(TB_Context $context, $registry, $front_controller)
    {
        $this->registry = $registry;
        $this->config = $this->registry->get('config');

        $this->tbManager = TB_CatalogManager::getInstance($context);
        $registry->set('tbManager', $this->tbManager);

        $this->front_controller = $front_controller;
    }

    public function dispatch()
    {
        $registry = $this->registry;
        $context = $this->tbManager->getContext();
        $dataBag = $this->createDataBag($context);

        $this->tbManager->initExtensions($dataBag);

        $request  = $registry->get('request');
        $eventDispatcher = $this->tbManager->getEventDispatcher();

        // chance to replace the default Url class
        $event = new sfEvent($registry, 'core:replaceUrl', array('tbData' => $dataBag, 'request' => $request));
        $eventDispatcher->notifyUntil($event);
        if ($event->isProcessed() && $event->getReturnValue() instanceof TB_Url) {
            $this->registry->set('url', $event->getReturnValue());
        }

        $this->doRouting($eventDispatcher, $request, $dataBag);
    }

    protected function doRouting(sfEventDispatcher $eventDispatcher, $request, $dataBag)
    {
        $event = new sfEvent($this->registry, 'core:beforeRouting', array('tbData' => $dataBag, 'request' => $request));
        $eventDispatcher->notify($event);

        $event = new sfEvent($this->registry, 'core:onRouting', array('tbData' => $dataBag, 'request' => $request));
        $eventDispatcher->notifyUntil($event);
        if ($event->isProcessed()) {
            $route = $event->getReturnValue();
        } else {
            if (!($this->registry->get('url') instanceof TB_Url)) {
                // prevent double rewrite after common/seo_url.php action
                $ocUrl = clone $this->registry->get('url');
            }

            $theme_config = $this->tbManager->getContext()->getThemeConfig();
            $seoAction = new Action($theme_config['seo_action']);

            require_once TB_Utils::vqmodCheck($seoAction->getFile());

            $class = $seoAction->getClass();
            $seo_controller = new $class($this->registry);

            call_user_func_array(array($seo_controller, $seoAction->getMethod()), $seoAction->getArgs());

            if (isset($this->registry->get('request')->get['route'])) {
                $route = $request->get['route'];
            } else {
                $route = 'common/home';
            }
        }

        $event = new sfEvent($this->registry, 'core:filter_route', array('tbData' => $dataBag, 'request' => $request));
        $route = $eventDispatcher->filter($event, $route)->getReturnValue();

        unset($request->get['_route_']);
        $request->get['route'] = $route;
        $dataBag->route = $route;

        $event = new sfEvent($this->registry, 'core:afterRouting', array('tbData' => $dataBag, 'request' => $request, 'route' => $route));
        $eventDispatcher->notify($event);

        $this->doExtensionsRoutesDispatching($route);

        if (isset($ocUrl)) {
            $this->registry->set('url', $ocUrl);
        }
    }

    public function doExtensionsRoutesDispatching($request_route)
    {
        $extension_name = '';
        $registered_routes = $this->tbManager->getRoutesBag()->exportVars();
        foreach ($registered_routes as $extension => $routes) {
            foreach ($routes as $route) {
                if (0 === stripos($request_route, $route['route'])) {
                    $extension_name = $extension;
                    $controller_name = $route['controller'];
                    $action = trim(substr($request_route, strlen($route['route'])), '/');
                    if (empty($action)) {
                        $action = 'index';
                    }
                    break;
                }
            }
        }

        if (empty($extension_name)) {
            return;
        }

        $controller = $this->tbManager->getExtension($extension_name)->getController($controller_name);
        if (!method_exists($controller, $action)) {
            return;
        }

        $controller->$action();
        $this->registry->get('response')->output();

        exit();
    }

    protected function createDataBag(TB_Context $context)
    {
        $init_vars = array();
        $init_vars['current_url']          = $context->getRequestUrl();
        $init_vars['base_http']            = $context->getBaseHttp();
        $init_vars['base_https']           = $context->getBaseHttps();
        $init_vars['base_httpsIf']         = $context->getBaseHttpsIf();
        $init_vars['basename']             = $context->getBasename();
        $init_vars['theme_stylesheet_url'] = $context->getThemeCatalogStylesheetUrl();
        $init_vars['theme_javascript_url'] = $context->getThemeCatalogJavascriptUrl();
        $init_vars['theme_images_url']     = $context->getThemeCatalogImageUrl();

        $dataBag  = new TB_DataBag();
        $dataBag->importVars($init_vars);
        $dataBag->route = '';
        $dataBag->isHTTPS = TB_Utils::isRequestHTTPS();
        $dataBag->tbSlot = new TB_ViewSlot($this->tbManager->getEventDispatcher());
        $dataBag->context = $context;

        return $dataBag;
    }
}