<?php

require_once TB_THEME_ROOT . '/library/Extension.php';
require_once TB_THEME_ROOT . '/library/PriceFormatter.php';
require_once TB_THEME_ROOT . '/library/vendor/Mobile_Detect.php';

abstract class TB_CatalogExtension extends TB_Extension
{
    /**
     * @var Request
     */
    protected $request;

    /**
     * @var Config
     */
    protected $config;

    /**
     * @var Loader
     */
    protected $load;

    /**
     * @var Url
     */
    protected $url;

    /**
     * @var TB_CatalogManager
     */
    protected $tbManager;

    public function __construct(TB_CatalogManager $manager, $name)
    {
        parent::__construct($manager, $name);

        $this->request = $this->registry->get('request');
        $this->config  = $this->registry->get('config');
        $this->load    = $this->registry->get('load');
        $this->url     = $this->registry->get('url');
    }

    protected function createControllerInstance($class_name)
    {
        return new $class_name($this->tbManager, $this);
    }

    public function registerCatalogRoute($route)
    {
        $routeBag = $this->tbManager->getRoutesBag();
        if (!isset($routeBag[$this->getName()] )) {
            $routeBag[$this->getName()]  = array();
            $extensions_routes = array();
        } else {
            $extensions_routes = $routeBag[$this->getName()];
        }
        $extensions_routes[$route['name']] = $route;
        $routeBag[$this->getName()] = $extensions_routes;
    }


    public function getRouteByName($name)
    {
        $routesBag = $this->tbManager->getRoutesBag();

        return $routesBag[$this->getName()][$name]['route'];
    }

    public function getExtensionLink($route, $args = '', $connection = 'NONSSL')
    {
        return $this->registry->get('url')->link($this->getName() . '/' . $route, $args, $connection);
    }
}