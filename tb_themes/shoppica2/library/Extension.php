<?php

require_once TB_THEME_ROOT . '/library/ExtensionPluginBootstrap.php';
require_once TB_THEME_ROOT . '/library/ExtensionPlugin.php';
require_once TB_THEME_ROOT . '/library/ViewSlot.php';

abstract class TB_Extension
{
    private $rootDir;

    /**
     * @var string
     */
    protected $name;

    /**
     * @var string
     */
    protected $area;

    /**
     * @var TB_ThemeManager
     */
    protected $tbManager;

    /**
     * @var TB_Context
     */
    protected $context;

    /**
     * @var sfEventDispatcher
     */
    protected $eventDispatcher;

    /**
     * @var TB_AdminUrl
     */
    protected $tbUrl;

    /**
     * @var TB_DataBag
     */
    protected $tbLang;

    /**
     * @var TB_DataBag
     */
    protected $tbData;

    /**
     * @var Registry
     */
    protected $registry;

    protected $controllers = array();
    protected $models      = array();
    protected $languages   = array();

    protected $init_order = 500;

    public function __construct(TB_ThemeManager $manager, $name)
    {
        $this->tbManager       = $manager;
        $this->context         = $manager->getContext();
        $this->eventDispatcher = $manager->getEventDispatcher();
        $this->area            = $this->context->getArea();
        $this->registry        = $this->context->getRegistry();
        $this->name            = $name;
    }

    public function setDataBag(TB_DataBag $dataBag)
    {
        $this->tbData = $dataBag;
    }

    /**
     * @return TB_DataBag
     */
    public function getDataBag()
    {
        return $this->tbData;
    }

    public function getManager()
    {
        return $this->tbManager;
    }

    protected function getArea()
    {
        return $this->area;
    }

    public function configure() {}

    public function getName()
    {
        return $this->name;
    }

    public function getInitOrder()
    {
        return $this->init_order;
    }

    public function isThemeExtension()
    {
        return $this->name == $this->context->getBasename();
    }

    public function getRootDir()
    {
        if (null === $this->rootDir) {
            $r = new ReflectionObject($this);
            $this->rootDir = realpath(dirname($r->getFileName()) . '/../');
        }

        return $this->rootDir;
    }

    public function getAreaDir()
    {
        return $this->getRootDir() . '/' . $this->area;
    }

    public function getConfig()
    {

    }

    public function getTbLang()
    {
        return $this->tbLang;
    }

    /**
     * @param string $controller_name
     *
     * @throws Exception
     * @return Controller
     */
    public function getController($controller_name)
    {
        $hash =  $this->name . '_' . $this->area . '_' . $controller_name;
        if (isset($this->controllers[$hash])) {
            return $this->controllers[$hash];
        }

        $controller_name = TB_Utils::camelize($controller_name);
        $controller_file = $this->getAreaDir() . '/controller/' . $controller_name . 'Controller.php';
        if (!file_exists($controller_file)) {
            throw new Exception('Could not include controller file ' . $controller_file);
        }

        require_once TB_Utils::vqmodCheck($controller_file);

        if ($this->isThemeExtension()) {
            $class = TB_Utils::camelize($this->context->getNamespace()) . '_' . ucfirst($this->area) . '_' .
                ucfirst($controller_name) . 'Controller';
        } else {
            $class = TB_Utils::camelize($this->name) . '_' . ucfirst($this->area) . '_' .
                ucfirst($controller_name) . 'Controller';
        }
        if (!class_exists($class)) {
            throw new Exception('Could not initialize controller ' . $class);
        }

        $this->controllers[$hash] = $this->createControllerInstance($class);

        return $this->controllers[$hash];
    }

    abstract protected function createControllerInstance($class_name);

    /**
     * @param string $model_name
     *
     * @throws Exception
     * @return TB_ExtensionModel
     */
    public function getModel($model_name = 'default')
    {
        $model_hash =  $this->name . '_' . $this->area . '_' . $model_name;
        if (isset($this->models[$model_hash])) {
            return $this->models[$model_hash];
        }

        $model_file = $this->getAreaDir() . '/model/' . $model_name . 'Model.php';
        if (file_exists($model_file)) {
            require_once TB_Utils::vqmodCheck($model_file);

            if ($this->isThemeExtension()) {
                $model_class =  TB_Utils::camelize($this->context->getNamespace());
            } else {
                $model_class =  TB_Utils::camelize($this->name);
            }
            $model_class .=  '_' . ucfirst($this->area) . '_' . ucfirst($model_name) . 'Model';
            if (!class_exists($model_class)) {
                throw new Exception('The class does not exists: ' . $model_class);
            }
        } else {
            $model_class = 'TB_ExtensionModel';
        }

        $this->models[$model_hash] = new $model_class($this->tbManager, $this);

        return $this->models[$model_hash];
    }

    public function getOcModel($name)
    {
        return $this->tbManager->getOcModel($name);
    }

    public function loadOcLanguage($filename)
    {
        if (isset($this->languages['oc_' . $filename])) {
            return $this->languages['oc_' . $filename];
        }

        $current_language = $this->getModel()->getCurrentLanguage();
        $file = $this->context->getCatalogLanguageDir() . '/' . $current_language['directory'] . '/' . $filename . '.php';
        if (!file_exists($file)) {
            throw new Exception('Could not include the language file ' . $file);
        }

        $_ = array();

        require_once TB_Utils::vqmodCheck($file);

        $this->languages['oc_' . $filename] = $_;

        return $_;
    }

    public function loadDefaultLanguage()
    {
        return $this->loadLanguage($this->name);
    }

    public function loadLanguage($filename)
    {
        if (null == $this->tbLang) {
            $this->tbLang = new TB_DataBag();
        }

        $current_language = $this->getModel()->getCurrentLanguage();
        $language_file = $this->getAreaDir() . '/language/' . $current_language['directory'] . '/' . $filename . '.lang.php';
        if (isset($this->languages[$language_file])) {
            return $this->languages[$language_file];
        }

        if (!file_exists($language_file)) {
            $config = $this->context->getThemeConfig();
            $fallback_file = $this->getAreaDir() . '/language/' . $config['fallback_language'] . '/' . $filename . '.lang.php';
            if (!file_exists($fallback_file)) {
                return array();
                //throw new Exception('Could not include the language file ' . $fallback_language_file);
            }

            $language_file = $fallback_file;
        }

        $_ = array();

        require_once TB_Utils::vqmodCheck($language_file);

        $this->languages[$language_file] = $_;
        $this->tbLang->importVars($_);

        return $_ ;
    }

    public function fetchTemplate($filename, array $data = array())
    {
        if ($this->isThemeExtension() && $this->getArea() == 'catalog') {
            $file = $this->context->getCatalogTemplateDir() . '/tb/' . $filename . '.tpl';
        } else {
            $file = $this->getAreaDir() . '/view/template/' . $filename . '.tpl';
        }

        if (!file_exists($file)) {
            throw new Exception('Could not load template ' . $file);
        }

        $data['tbData'] = $this->tbData;
        $data['tbSlot'] = $this->tbData->tbSlot;

        foreach ($this->tbLang->exportVars() as $key => $value) {
            $data['text_' . $key] = $value;
        }

        extract($data);

        ob_start();

        require TB_Utils::vqmodCheck($file);

        $content = ob_get_contents();

        ob_end_clean();

        return $content;
    }

    protected function redirect($url, $status = 302)
    {
   		header('Status: ' . $status);
   		header('Location: ' . str_replace('&amp;', '&', $url));
   		exit();
   	}
}