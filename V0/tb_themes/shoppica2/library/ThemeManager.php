<?php

require_once TB_THEME_ROOT . '/library/vendor/sfFinder.class.php';
require_once TB_THEME_ROOT . '/library/vendor/sfEventDispatcher.php';

require_once TB_THEME_ROOT . '/library/FormHelper.php';
require_once TB_THEME_ROOT . '/library/ExtensionModel.php';
require_once TB_THEME_ROOT . '/library/DbHelper.php';
require_once TB_THEME_ROOT . '/library/DbSettingsHelper.php';
require_once TB_THEME_ROOT . '/library/ThemeSettingsModel.php';

class TB_ThemeManager
{
    protected static $instances = array();

    /**
     * @var sfEventDispatcher
     */
    protected static $eventDispatcher;

    /**
     * @var TB_DbSettingsHelper
     */
    protected static $dbSettingsHelper;

    /**
     * @var TB_ThemeSettingsModel
     */
    protected static $settingsModel;

    /*
     * @var TB_DbHelper
     */
    protected static $dbHelper;

    /**
     * @var TB_Context
     */
    protected $context;

    /**
     * @var Registry
     */
    protected $registry;

    /**
     * @var TB_Extension
     */
    protected $themeExtension;

    /**
     * @var TB_DataBag
     */
    protected $routesBag;

    /**
     * @var array
     */
    protected $extensions;

    protected function __construct(TB_Context $context)
    {
        $registry = $context->getRegistry();

        $this->registry = $registry;
        $this->context  = $context;

        if (empty(self::$instances)) {
            self::$dbHelper         = new TB_DbHelper($registry->get('db'), $context->getDbPrefix());
            self::$eventDispatcher  = new sfEventDispatcher();
            self::$dbSettingsHelper = new TB_DbSettingsHelper(self::$dbHelper);
            self::$settingsModel    = new TB_ThemeSettingsModel(self::$dbSettingsHelper, $this->context);
        }
    }

    /**
     * @param TB_Context $context
     *
     * @return TB_ThemeManager
     */
    public static function getInstance(TB_Context $context)
    {
        $area = $context->getArea();
        if (!isset(self::$instances[$area])) {
            self::$instances[$area] = new self($context);
        }

        return self::$instances[$area];
    }

    /**
     * @return TB_Context
     */
    public function getContext()
    {
        return $this->context;
    }

    /**
     * @return TB_DbHelper
     */
    public function getDbHelper()
    {
        return self::$dbHelper;
    }

    /**
     * @return TB_ThemeSettingsModel
     */
    public function getSettingsModel()
    {
        return self::$settingsModel;
    }

    /**
     * @return TB_DbSettingsHelper
     */
    public function getDbSettingsHelper()
    {
        return self::$dbSettingsHelper;
    }

    protected function loadThemeExtension()
    {
        if (null !== $this->themeExtension) {
            return $this->themeExtension;
        }

        $extension = $this->loadExtensionsFromPath($this->context->getThemeDir());
        $extension = array_shift($extension);
        if (empty($extension)) {
            throw new Exception('Could not initialize the theme extension');
        }

        $this->themeExtension = $extension;

        return $extension;
    }

    protected function loadExtensions($installed_only = true)
    {
        $paths = sfFinder::type('dir')->maxdepth(0)->in($this->context->getExtensionDir());

        return $this->loadExtensionsFromPath($paths, $installed_only);
    }

    protected function loadExtensionsFromPath($path, $installed_only = false)
    {
        $area = $this->context->getArea();
        $extensions = array();
        foreach ((array) $path as $extension_path) {
            if (!is_dir($extension_path . '/' . $area)) {
                continue;
            }

            $extension_name = strtolower(basename($extension_path));

            if ($this->isThemeExtensionLoaded() && $installed_only &&
                !$this->getThemeModel('extensions')->isExtensionInstalled($extension_name)) {
                continue;
            }

            $extension_file = $extension_path . '/' . $area . '/';
            if ($extension_name == $this->context->getBasename()) {
                $extension_file .= TB_Utils::camelize($this->context->getNamespace()) . ucfirst($area) . 'Extension.php';
            } else {
                $extension_file .= TB_Utils::camelize($extension_name) . ucfirst($area) . 'Extension.php';
            }
            if (!file_exists($extension_file)) {
                throw new Exception('Could not initialize extension file ' . $extension_file);
            }

            require_once TB_Utils::vqmodCheck($extension_file);

            if ($extension_name == $this->context->getBasename()) {
                $class_name = $this->context->getNamespace() . '_' . ucfirst($area) . '_Extension';
            } else {
                $class_name = TB_Utils::camelize($extension_name) . '_' . ucfirst($area) . '_Extension';
            }

            if (!class_exists($class_name)) {
                throw new Exception('Could not initialize extension class ' . $class_name);
            }

            $extension = new $class_name($this, $extension_name);
            $extensions[$extension->getInitOrder() . '-' . TB_Utils::genRandomString()] = $extension;
        }
        ksort($extensions);

        return $extensions;
    }

    public function getExtensions()
    {
        return $this->extensions;
    }

    /**
     * @param $name
     *
     * @throws Exception
     * @return TB_Extension
     */
    public function getExtension($name)
    {
        if ($name == $this->context->getBasename()) {
            return $this->themeExtension;
        }

        if (!isset($this->extensions[$name])) {
            throw new Exception('The following extension does not exists: ' . $name);
        }

        return $this->extensions[$name];
    }

    /**
     * @return TB_Extension
     */
    public function getThemeExtension()
    {
        return $this->themeExtension;
    }

    /**
     * @param $name
     *
     * @return bool
     */
    public function isExtensionInstalled($name)
    {
        return isset($this->extensions[$name]);
    }

    /**
     * @return bool
     */
    public function isThemeExtensionLoaded()
    {
        return null !== $this->themeExtension;
    }

    /**
     * @param string $name
     * @return TB_ExtensionModel
     */
    public function getThemeModel($name = 'default')
    {
        return $this->getThemeExtension()->getModel($name);
    }

    public function getOcModel($name)
    {
        $model_full_name = 'model_' . str_replace('/', '_', $name);
        if (!$this->registry->has($model_full_name)) {
            $this->registry->get('load')->model($name);
        }

        return $this->registry->get($model_full_name);
    }

    /**
     * @return sfEventDispatcher
     */
    public function getEventDispatcher()
    {
        return self::$eventDispatcher;
    }

    public function getRoutesBag()
    {
        if (null !== $this->routesBag) {
            return $this->routesBag;
        }

        $this->routesBag = new TB_DataBag();

        return $this->routesBag;
    }

    public function isThemeEnabled()
    {
        return $this->registry->get('config')->get('config_template') == $this->context->getBasename();
    }

    public function displayNotice($notice)
    {
        static $hashes = array();

        $hash = md5($notice);
        if (in_array($hash, $hashes)) {
            return;
        }

        $hashes[] = $hash;
        trigger_error($notice);
    }

    /**
     * Returns the theme version
     *
     * @return string
     */
    public function getThemeVersion()
    {
        return '2.2.3';
    }

    /**
     * Returns the theme machine name. Useful when checking compatibility. Do not change it, it may prevent
     * extensions from working.
     *
     * @return string
     */
    public function getThemeMachineName()
    {
        return 'shoppica2';
    }
}
