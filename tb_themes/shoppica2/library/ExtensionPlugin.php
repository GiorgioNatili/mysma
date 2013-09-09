<?php

abstract class TB_ExtensionPlugin
{
    /**
     * @var TB_ExtensionPluginBootstrap
     */
    protected $bootstrapper;

    /**
     * @var TB_Extension
     */
    protected $tbExtension;

    /**
     * @var TB_ThemeManager
     */
    protected $manager;

    /**
     * @var TB_Context
     */
    protected $context;

    /**
     * @var sfEventDispatcher
     */
    protected $eventDispatcher;

    /**
     * @var Registry
     */
    protected $registry;

    /**
     * @var Config
     */
    protected $config;

    /**
     * @var Request
     */
    protected $request;

    /**
     * The current active language id
     *
     * @var int
     */
    protected $language_id;
    protected $extension_settings;
    protected $name;
    protected $init_order = 500;

    public function __construct(TB_ExtensionPluginBootstrap $bootstrapper, TB_Extension $extension, TB_Context $context, sfEventDispatcher $eventDispatcher)
    {
        $this->bootstrapper       = $bootstrapper;
        $this->tbExtension        = $extension;
        $this->manager            = $extension->getManager();
        $this->context            = $context;
        $this->eventDispatcher    = $eventDispatcher;
        $this->registry           = $context->getRegistry();
        $this->config             = $this->registry->get('config');
        $this->request            = $this->registry->get('request');
        $this->extension_settings = $extension->getModel()->getSettings();
        $this->language_id        = $extension->getModel()->getCurrentLanguage('language_id');
    }

    protected function bootstrap($plugin_name = '')
    {
        if (empty($plugin_name)) {
            $plugin_name = $this->name;
        }

        return $this->bootstrapper->bootstrap($plugin_name);
    }

    public function setName($name)
    {
        $this->name = $name;
    }

    public function getName()
    {
        return $this->name;
    }

    public function getInitOrder()
    {
        return $this->init_order;
    }

    protected function getModel($name = 'default')
    {
        return $this->tbExtension->getModel($name);
    }

    protected function getOcModel($name)
    {
        return $this->tbExtension->getOcModel($name);
    }

    public function configure(TB_DataBag $tbData) {}
    public function execute(TB_DataBag $tbData) {}
}