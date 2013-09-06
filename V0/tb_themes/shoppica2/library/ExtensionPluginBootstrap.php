<?php

class TB_ExtensionPluginBootstrap
{
    protected $initialized = false;
    protected $booted = false;

    /**
     * @var array Loaded plugin instances
     */
    protected $plugins = array();

    /**
     * @var array Plugins that have been run
     */
    protected $run = array();

    /**
     * @var array Plugins that have been started but not yet completed (circular dependency detection)
     */
    protected $started = array();

    /**
     * @var TB_Context
     */
    protected $context;

    /**
     * @var TB_Extension
     */
    protected $tbExtension;

    /**
     * @var sfEventDispatcher
     */
    protected $eventDispatcher;

    /**
     * @var TB_DataBag
     */
    protected $tbData;

    public function __construct(TB_Context $context, TB_Extension $extension, TB_DataBag $tbData, sfEventDispatcher $eventDispatcher)
    {
        $this->context         = $context;
        $this->tbExtension     = $extension;
        $this->eventDispatcher = $eventDispatcher;
        $this->tbData          = $tbData;
    }

    public function getPlugins()
    {
        if (!$this->initialized) {
            throw new Exception('ExtensionPluginBootstrap the plugins have not been initialized: ' . get_class($this));
        }

        return $this->plugins;
    }

    public function getPlugin($plugin_name)
    {
        $plugin_name = TB_Utils::camelize($plugin_name);

        if (!in_array($plugin_name, $this->run)) {
            throw new Exception('ExtensionPluginBootstrap the plugin ' . $plugin_name . ' has not been initialized: ' . get_class($this));
        }

        return $this->plugins[$plugin_name];
    }

    public function bootstrap($plugin_name)
    {
        $plugin_name = TB_Utils::camelize($plugin_name);

        if (in_array($plugin_name, $this->run)) {
            return false;
        }

        if (isset($this->started[$plugin_name]) && $this->started[$plugin_name]) {
            throw new Exception('Circular resource dependency detected');
        }

        $this->loadPlugins();
        if (!isset($this->plugins[$plugin_name])) {
            throw new Exception('Extension plugin not found: ' . $plugin_name);
        }

        $this->started[$plugin_name] = true;
        $result = $this->plugins[$plugin_name]->execute($this->tbData);
        unset($this->started[$plugin_name]);
        if (!in_array($plugin_name, $this->run)) {
            $this->run[] = $plugin_name;
        }

        return $result;
    }

    public function configureAll()
    {
        if ($this->initialized) {
            throw new Exception('ExtensionPluginBootstrap already initialized: ' . get_class($this));
        }

        $this->loadPlugins();
        foreach ($this->plugins as $plugin) {
            $plugin->configure($this->tbData);
        }

        $this->initialized = true;
    }

    public function bootstrapAll()
    {
        if (!$this->initialized) {
            throw new Exception('You must first initialize the plugins before bootstraping them: ' . get_class($this));
        }

        if ($this->booted) {
            throw new Exception('ExtensionPluginBootstrap already booted: ' . get_class($this));
        }

        foreach ($this->plugins as $plugin) {
            $this->bootstrap($plugin->getName());
        }

        $this->booted = true;
    }

    protected function loadPlugins()
    {
        if (!empty($this->plugins)) {
            return;
        }

        $plugins_dir = $this->tbExtension->getAreaDir() . '/plugin';
        $files = sfFinder::type('file')->maxdepth(0)->in($plugins_dir);
        foreach ($files as $file) {

            require_once TB_Utils::vqmodCheck($file);

            $fileinfo = pathinfo($file);
            $filename = $fileinfo['filename'];
            $area     = ucfirst($this->context->getArea());

            if ($this->tbExtension->isThemeExtension()) {
                $classname = $this->context->getNamespace() . '_' . $area . '_' . $filename;
            }    else {
                $classname = $this->tbExtension->getName() . '_' . $area . '_' . $filename;
            }

            if (!class_exists($classname)) {
                throw new Exception('The class cannot be found: ' . $classname);
            }

            if (!is_subclass_of($classname, 'TB_ExtensionPlugin')) {
                throw new Exception('The class ' . $classname . ' is not subclass of TB_ExtensionPlugin');
            }

            $class = new $classname($this, $this->tbExtension, $this->context, $this->eventDispatcher);
            $class->setName(substr_replace($filename, '', -6, 6)); // Remove 'Plugin' from the end
            $plugins[$class->getInitOrder() . '-' . TB_Utils::genRandomString()] = $class;
        }

        ksort($plugins);
        foreach ($plugins as $plugin) {
            $this->plugins[$plugin->getName()] = $plugin;
        }
    }
}