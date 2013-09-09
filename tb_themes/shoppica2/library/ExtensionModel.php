<?php
class TB_ExtensionModel
{
    /**
     * @var TB_Extension
     */
    protected $tbExtension;

    /**
     * @var TB_ThemeSettingsModel
     */
    protected $settingsModel;

    /**
     * @var TB_ThemeManager
     */
    protected $tbManager;

    /*
     * @var TB_Context
     */
    protected $context;

    /**
     * @var TB_DbHelper
     */
    protected $dbHelper;

    /**
     * OpenCart Config class
     *
     * @var Config
     */
    protected $config;

    /**
     * OpenCart Config class
     *
     * @var Customer
     */
    protected $customer;

    /**
     * OpenCart DB class
     *
     * @var DB
     */
    protected $db;

    /**
     * @var int
     */
    protected $store_id;

    /**
     * @var Registry
     */
    protected $registry;

    private $language_data;

    public function __construct(TB_ThemeManager $tbManager, TB_Extension $extension)
    {
        $this->tbManager   = $tbManager;
        $this->tbExtension = $extension;

        $this->context       = $tbManager->getContext();
        $this->dbHelper      = $tbManager->getDbHelper();
        $this->settingsModel = $tbManager->getSettingsModel();
        $this->settings      = $this->getSettings();
        $this->store_id      = $this->context->getStoreId();
        $this->registry      = $this->context->registry;
        $this->config        = $this->context->config;
        $this->customer      = $this->context->customer;
        $this->db            = $this->context->db;

    }

    public function getContext()
    {
        return $this->context;
    }

    public function getStoreId()
    {
        return $this->store_id;
    }

    public function getDbHelper()
    {
        return $this->dbHelper;
    }

    public function getSetting($name)
    {
        $settings = $this->getSettings();
        if (!isset($settings[$name])) {
            return null;
        }

        return $settings[$name];
    }

    public function getSettings()
    {
        return $this->settingsModel[$this->tbExtension->getName()];
    }

    public function setSettings($settings)
    {
        $this->settingsModel[$this->tbExtension->getName()] = $settings;
    }

    public function persistSettings()
    {
        $this->settingsModel->persistScopeSettings($this->tbExtension->getName());
    }

    public function setAndPersistSettings($settings)
    {
        $this->setSettings($settings);
        $this->persistSettings();
    }

    public function getCurrentLanguage($key = null)
    {
        static $current = null;

        if (null === $current) {
            $languages = $this->getLanguages();
            $current   = $languages[$this->config->get('config_language')];
        }

        return $key !== null ? $current[$key] : $current;
    }

    public function getLanguages()
    {
        if (null !== $this->language_data) {
            return $this->language_data;
        }

        $language_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "language ORDER BY sort_order, name");
        foreach ($query->rows as $result) {
            $language_data[$result['code']] = array(
                'id'          => $result['language_id'],
                'language_id' => $result['language_id'],
                'name'        => $result['name'],
                'code'        => $result['code'],
                'locale'      => $result['locale'],
                'image'       => $result['image'],
                'directory'   => $result['directory'],
                'filename'    => $result['filename'],
                'status'      => $result['status']
                );
        }

        $this->language_data = $language_data;

   		return $language_data;
   	}
}