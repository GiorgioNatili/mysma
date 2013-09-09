<?php

class Theme_Admin_Extension extends TB_AdminExtension
{
    protected $init_order = 0;

    /**
     * @var TB_ExtensionPluginBootstrap
     */
    protected $pluginBootstrapper;

    public function getConfig() {}

    public function configure()
    {
        $this->eventDispatcher->connect('core:extensions_preconfigure', array($this, 'configurePlugins'));
        $this->eventDispatcher->connect('core:extensions_postconfigure', array($this, 'bootstrapPlugins'));
        $this->eventDispatcher->connect('core:extension_postconfigure.tb_smartcache', array($this, 'registerPurgeVarsListener'));
        $this->eventDispatcher->connect('core:admin_dispatch', array($this, 'checkCurrentStoreSettings'));
        $this->eventDispatcher->connect('core:admin_module_install', array($this, 'checkCurrentStoreSettings'));
    }

    public function configurePlugins()
    {
        $this->pluginBootstrapper = new TB_ExtensionPluginBootstrap($this->context, $this, $this->tbData, $this->eventDispatcher);
        $this->pluginBootstrapper->configureAll();
    }

    public function checkCurrentStoreSettings()
    {
        $settings = $this->getModel()->getSettings();
        if (empty($settings)) {
            $default_file = $this->context->getThemeDir() . '/default_data.php';
            if (!file_exists($default_file)) {
                throw new Exception('Cannot find the default initialization data file: ' . $default_file);
            }

            $default_data = require $default_file;

            $config = $this->context->getThemeConfig();
            $settings_group = $config['settings_group'];
            $default_data['first_time'] = 1;

            $languages = $this->getModel()->getLanguages();

            $footerInfo = reset($default_data['footerInfo']);
            $default_data['footerInfo'] = array();
            foreach ($languages as $language) {
                $default_data['footerInfo'][$language['id']] = $footerInfo;
            }

            $font = reset($default_data['font']);
            $default_data['font'] = array();
            foreach ($languages as $language) {
                $default_data['font'][$language['id']] = $font;
            }

            $this->tbManager->getSettingsModel()->setAndPersistScopeSettings($settings_group, $default_data);

            $common = $this->getModel()->getSetting('common');
            $this->getPlugin('common')->setDefaultOcImageSettings($common['products_per_row'], $common['product_gallery_position']);
        }
    }

    public function registerPurgeVarsListener(sfEvent $event)
    {
        $event['extension']->getModel()->registerPurgeVars(
            array('category_tree', 'category_flat_tree', 'menu_categories_html'),
            array('oc:category.delete_cache', 'oc:setting.save_settings')
        );
    }

    public function getInitOptions()
    {
        return false;
    }

    public function bootstrapPlugins()
    {
        $this->pluginBootstrapper->bootstrapAll();
    }

    public function getPlugins()
    {
        return $this->pluginBootstrapper->getPlugins();
    }

    public function getPlugin($name)
    {
        return $this->pluginBootstrapper->getPlugin($name);
    }

    public function loadDefaultLanguage()
    {
        return $this->loadLanguage('theme');
    }
}