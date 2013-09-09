<?php

require_once TB_THEME_ROOT . '/library/DataBag.php';
require_once TB_THEME_ROOT . '/library/ControllerHelper.php';

class TB_Context extends Model
{
    /**
     * @var Registry
     */
    public $registry;

    /*
     * @var int
     */
    protected $store_id;

    /**
     * @var TB_DataBag
     */
    protected $themeConfig;

    /**
     * @var string
     */
    protected $namespace;

    /**
     * @var string
     */
    protected $basename;

    /**
     * @var string
     */
    protected $settings_group;

    /**
     * @var string
     */
    protected $area;

    protected $base_http;
    protected $base_https;
    protected $base_httpsIf;
    protected $request_url;

    public function __construct($registry, array $theme_config, $store_id, $area)
    {
        parent::__construct($registry);

        $this->registry  = $registry;
        $this->area      = $area;
        $this->store_id  = $store_id;

        if ($area == 'admin') {
            $registry->get('config')->set('config_store_id', $store_id);
        }

        $dataBag = new TB_DataBag();
        $dataBag->importVars($theme_config);
        $this->themeConfig = $dataBag;

        $this->namespace      = $theme_config['namespace'];
        $this->basename       = $theme_config['basename'];
        $this->settings_group = $theme_config['settings_group'];

        if ($this->area == 'admin') {
            $config_url = HTTP_CATALOG;
            if (empty($config_url)) {
                $config_url = substr(HTTP_SERVER, 0, -6);
            }

            $config_ssl = HTTP_CATALOG;
            if (empty($config_ssl)) {
                $config_ssl = substr(HTTP_SERVER, 0, -6);
            }
        } else {
            $config_url = $this->config->get('config_url');
            if (empty($config_url)) {
                $config_url = HTTP_SERVER;
            }

            $config_ssl = $this->config->get('config_ssl') ? $this->config->get('config_ssl') : $config_url;
            if (empty($config_ssl)) {
                $config_ssl = HTTPS_SERVER;
            }
        }

        $http_host = TB_Utils::getHost();
        if (empty($http_host)) {
            $http_host = $config_url;
        }

        $this->base_http = TB_Utils::modifyBase($config_url, $http_host);
        if (TB_Utils::compareUrlHostsEqual($config_url, $config_ssl)) {
            $this->base_https =  TB_Utils::modifyBase($config_ssl, $http_host, true);
        } else {
            $this->base_https =  $config_ssl;
        }

        if (TB_ControllerHelper::isRequestHTTPS()) {
            $this->request_url = "https://" . $http_host . $_SERVER['REQUEST_URI'];
            $this->base_httpsIf = $this->base_https;
        } else {
            $this->request_url = "http://" . $http_host . $_SERVER['REQUEST_URI'];
            $this->base_httpsIf = $this->base_http;
        }
    }

    public function getRequestUrl()
    {
        return $this->request_url;
    }

    public function getBaseHttp()
    {
        return $this->base_http;
    }

    public function getBaseHttps()
    {
        return $this->base_https;
    }

    /**
     * Returns the base ssl url only if the request is secure
     *
     * @return string
     */
    public function getBaseHttpsIf()
    {
        return $this->base_httpsIf;
    }

    public function getThemeAdminResourceUrl()
    {
        return $this->base_httpsIf . 'tb_themes/' . $this->basename . '/' . $this->themeConfig['admin_folder'] . '/view/';
    }

    public function getThemeAdminImageUrl()
    {
        return $this->getThemeAdminResourceUrl() . 'images/';
    }

    public function getThemeAdminStylesheetUrl()
    {
        return $this->getThemeAdminResourceUrl() . 'stylesheet/';
    }

    public function getThemeAdminJavascriptUrl()
    {
        return $this->getThemeAdminResourceUrl() . 'javascript/';
    }

    public function getThemeCatalogResourceUrl()
    {
        return $this->base_httpsIf . 'catalog/view/theme/' . $this->basename . '/';
    }

    public function getThemeCatalogImageUrl()
    {
        return $this->getThemeCatalogResourceUrl() . 'images/';
    }

    public function getThemeCatalogStylesheetUrl()
    {
        return $this->getThemeCatalogResourceUrl() . 'stylesheet/';
    }

    public function getThemeCatalogStylesheetUrlHttp()
    {
        return $this->base_http . 'catalog/view/theme/' . $this->basename . '/stylesheet/';
    }

    public function getThemeCatalogJavascriptUrl()
    {
        return $this->getThemeCatalogResourceUrl() . 'javascript/';
    }

    public function getThemeConfig()
    {
        return $this->themeConfig;
    }

    public function getBasename()
    {
        return $this->basename;
    }

    public function getNamespace()
    {
        return $this->namespace;
    }

    public function getSettingsGroup()
    {
        return $this->settings_group;
    }

    public function getStoreId()
    {
        return $this->store_id;
    }

    public function getArea()
    {
        return $this->area;
    }

    /**
     * @return Registry
     */
    public function getRegistry()
    {
        return $this->registry;
    }

    public function getDbPrefix()
    {
        return DB_PREFIX;
    }

    public function getExtensionDir()
    {
        return realpath(DIR_SYSTEM . '../') . '/tb_extensions';
    }

    public function getThemesDir()
    {
        return realpath(DIR_SYSTEM . '../') . '/tb_themes';
    }

    public function getThemeDir()
    {
        return $this->getThemesDir() . '/' . $this->basename;
    }

    public function getRootDir()
    {
        return dirname($this->getAreaDir());
    }

    public function getAreaDir()
    {
        if ($this->area == 'admin') {
            return $this->getAdminDir();
        } else {
            return $this->getCatalogDir();
        }
    }

    public function getCatalogDir()
    {
        if ($this->area == 'admin') {
            return rtrim(DIR_CATALOG, '/');
        }

        return rtrim(DIR_APPLICATION, '/');
    }

    public function getCatalogTemplateDir()
    {
        return $this->getCatalogDir() . '/view/theme/' .  $this->basename . '/template';
    }

    public function getCatalogLanguageDir()
    {
        return $this->getCatalogDir() . '/language';
    }

    public function getAdminDir()
    {
        if ($this->area == 'admin') {
            return rtrim(DIR_APPLICATION, '/');
        }

        return dirname(DIR_APPLICATION) . '/' . substr(HTTP_ADMIN, strlen(HTTP_SERVER));
    }

    public function getImageUrl()
    {
        return $this->base_httpsIf . 'image/';
    }
}
