<?php

class Theme_Catalog_Extension extends TB_CatalogExtension
{
    protected $init_order = 0;
    protected $settings;
    protected $route;

    /**
     * @var TB_ExtensionPluginBootstrap
     */
    protected $pluginBootstrapper;

    public function configure()
    {
        $this->eventDispatcher->connect('core:beforeRouting', array($this, 'beforeRouting'));
        $this->eventDispatcher->connect('core:afterRouting', array($this, 'afterRouting'));

        $this->pluginBootstrapper = new TB_ExtensionPluginBootstrap($this->context, $this, $this->tbData, $this->eventDispatcher);
        $this->pluginBootstrapper->configureAll();
    }

    public function beforeRouting()
    {
        $this->route = '';
        $this->settings = $this->getModel()->getSettings();
        $this->detectMobile();
        $this->registerRoutes();
        $this->tbData->browser_info = TB_Utils::detectBrowser();
        $this->tbData->importVars($this->tbManager->getGlobalLang()->exportVars());
    }

    protected function registerRoutes()
    {
        $this->registerCatalogRoute(array(
            'name'       => 'category_manufacturer',
            'route'      => 'category/manufacturer',
            'controller' => 'brand_category'
        ));

        $this->registerCatalogRoute(array(
            'name'       => 'tb',
            'route'      => 'tb',
            'controller' => 'tb'
        ));
    }

    public function afterRouting()
    {
        $this->route = $this->tbData->route;

        $this->tbData->current_layout_id = $this->getModel()->getLayoutIdByRoute($this->route, $this->request);

        $tbPrice = new TB_PriceFormatter($this->registry->get('currency'));

        $this->tbData->addCallable(array($this, 'getJavascriptRegistry'));
        $this->tbData->addCallable(array($tbPrice, 'format'), 'priceFormat');
        $this->tbData->addCallable(array($this->getController('tb'), 'getCartContents'));
        $this->tbData->addCallable(array($this->getModel('category'), 'getCategoryTreeWithTotalProductsMaxLevel2'));

        $this->tbData->addJavascriptVar('tb/image_url', $this->context->getImageUrl());
        $this->tbData->addJavascriptVar('tb/theme_stylesheet_url', $this->tbData->theme_stylesheet_url);
        $this->tbData->addJavascriptVar('tb/is_mobile', $this->tbData->is_mobile);
        $this->tbData->addJavascriptVar('tb/basename', $this->tbData->basename);
        $this->tbData->addJavascriptVar('tb/shopping_cart_url', $this->registry->get('url')->link('checkout/cart'));
        $this->tbData->addJavascriptVar('tb/wishlist_url', $this->registry->get('url')->link('account/wishlist'));

        $this->tbData->addJavascriptVar('lang/text_continue', $this->tbLang->text_continue);
        $this->tbData->addJavascriptVar('lang/text_continue_shopping', $this->tbLang->text_continue_shopping);
        $this->tbData->addJavascriptVar('lang/text_shopping_cart', $this->tbLang->text_shopping_cart);
        $this->tbData->addJavascriptVar('lang/text_wishlist', $this->tbLang->text_wishlist);

        $this->setCategoryPath();
        $this->pluginBootstrapper->bootstrapAll();
        $this->setVariousVars();
    }

    private function detectMobile()
    {
        $this->tbData->do_javascript_detection = false;
        /*
        $this->tbData->is_mobile = 1;
        $this->tbData->is_touch = 1;
        $this->tbData->touch_detected = true;
        return;
        */
        if (isset($_COOKIE['is_mobile'])) {
            $this->tbData->is_mobile = (int) $_COOKIE['is_mobile'];
            $this->tbData->is_touch = 1;
            $this->tbData->touch_detected = true;
        } else {
            $mobileDetect = new Mobile_Detect();
            $is_mobile = $mobileDetect->isMobile();
            if (true == $is_mobile) {
                $is_phone_device = $mobileDetect->isPhoneDevice();
                if (true == $is_phone_device) {
                    $this->tbData->is_touch = 1;
                } else {
                    $is_mobile = false;
                    $is_tablet = $mobileDetect->isTablet();
                    if (false == $is_tablet) {
                        $this->tbData->do_javascript_detection = true;
                    } else {
                        $this->tbData->is_touch = 1;
                    }
                }
            } else {
                $this->tbData->do_javascript_detection = true;
            }
            $mobile_value = $is_mobile ? 1 : 0;
            $this->tbData->is_mobile = $mobile_value;
            if (false == $this->tbData->do_javascript_detection) {
                setcookie('is_mobile', $mobile_value, time() + 604800, '/', $this->request->server['HTTP_HOST']);
            }
        }

        if (isset($_COOKIE['is_touch'])) {
            $this->tbData->is_touch = (int) $_COOKIE['is_touch'];
            $this->tbData->touch_detected = true;
        } else {
            if ($this->tbData->is_touch == 1) {
                setcookie('is_touch', 1, time() + 604800, '/', $this->request->server['HTTP_HOST']);
                $this->tbData->touch_detected = true;
            } else {
                $this->tbData->is_touch = 0;
                $this->tbData->touch_detected = false;
            }
        }
    }

    public function loadDefaultLanguage()
    {
        return $this->loadLanguage('theme');
    }

    public function loadLanguage($filename)
    {
        if (null == $this->tbLang) {
            $this->tbLang = new TB_DataBag();
        }

        $current_language = $this->getModel()->getCurrentLanguage();
        $language_file = $this->context->getCatalogLanguageDir() . '/' . $current_language['directory'] . '/' .
            $this->context->getBasename() . '/' . $filename . '.lang.php';
        if (isset($this->languages[$language_file])) {
            return $this->languages[$language_file];
        }

        $theme_config = $this->context->getThemeConfig();
        $fallback_language = $theme_config['fallback_language'];

        $fallback_dir = $this->context->getAreaDir() . '/language/' . $fallback_language;
        if (!is_dir($fallback_dir)) {
            $notice = 'The fallback language "' . $fallback_language . '" does not exist. Please, make sure the ' . $fallback_language . ' folder is accessible: ' . $fallback_dir;
            $this->tbManager->displayNotice($notice);
        }

        $fallback_file = $fallback_dir . '/' . $this->context->getBasename() . '/' . $filename . '.lang.php';
        if ($fallback_dir != $current_language['directory'] && file_exists($fallback_file)) {
            $_ = array();

            require_once TB_Utils::vqmodCheck($fallback_file);

            if (file_exists($language_file)) {
                $_fallback = $_;
                $_ = array();

                require_once TB_Utils::vqmodCheck($language_file);

                foreach ($_fallback as $key => $value) {
                    if (!isset($_[$key])) {
                        $_[$key] = $value;
                    }
                }
            }
        } else {
            $_ = array();
            if (file_exists($language_file)) {
                require_once TB_Utils::vqmodCheck($language_file);
            } else {
                $notice = 'The language file "' . $language_file . '" does not exist.';
                $this->tbManager->displayNotice($notice);
            }
        }

        $this->languages[$language_file] = $_;
        $this->tbLang->importVars($_);

        return $_ ;
    }

    protected function setCategoryPath()
    {
        $path = (isset($this->request->get['path']) && !empty($this->request->get['path'])) ? (string) $this->request->get['path'] : '0';
        $path = array_map(create_function('$value', 'return (int) $value;'), explode('_', $path));
        $path = implode('_', $path);

        $this->tbData->category_path = $path;
        $this->tbData->addJavascriptVar('tb/category_path', $path);
    }

    protected function setVariousVars()
    {
        if ($this->route == 'checkout/register' || $this->route == 'account/register' && $this->config->get('config_account_id')) {
            $information_info = $this->getOcModel('catalog/information')->getInformation($this->config->get('config_account_id'));
            if ($information_info) {
                $url = $this->registry->get('url')->link('information/information/info', 'information_id=' . $this->config->get('config_account_id') . '&iframe=true', 'SSL');
                $this->tbData->text_account_agree = sprintf($this->tbData->text_account_agree, $url, $information_info['title'], $information_info['title']);
            }
        }

        if ($this->route == 'checkout/payment_method' && $this->config->get('config_checkout_id')) {
            $information_info = $this->getOcModel('catalog/information')->getInformation($this->config->get('config_checkout_id'));
            if ($information_info) {
                $url = $this->registry->get('url')->link('information/information/info', 'information_id=' . $this->config->get('config_checkout_id') . '&iframe=true', 'SSL');
                $this->tbData->text_checkout_agree = sprintf($this->tbLang->text_checkout_agree, $url, $information_info['title'], $information_info['title']);
            }
        }

        if ($this->route == 'affiliate/register' && $this->config->get('config_affiliate_id')) {
            $information_info = $this->getOcModel('catalog/information')->getInformation($this->config->get('config_affiliate_id'));
            if ($information_info) {
                $url = $this->registry->get('url')->link('information/information/info', 'information_id=' . $this->config->get('config_affiliate_id') . '&iframe=true', 'SSL');
                $this->tbData->text_agree_affiliate = sprintf($this->tbLang->text_agree_affiliate, $url, $information_info['title'], $information_info['title']);
            }
        }

        $custom_stylesheet = $this->tbManager->getSettingsModel()->getScopeSettings('custom_stylesheet');
        $this->tbData->custom_stylesheet = html_entity_decode(str_replace("\r\n", '', $custom_stylesheet));

        $this->tbData->theme_version = $this->tbManager->getThemeVersion();
    }

    public function getJavascriptRegistry()
    {
        $bag = $this->tbData;
        if (!isset($bag['javascript']) || !is_array($bag['javascript'])) {
            return '';
        }

        $jsarr = array();
        foreach ($bag['javascript'] as $section => $vars) {
            foreach ($vars as $key => $value) {
                $jsarr['/' . $section . '/' . $key] = $value;
            }
        }

        if (empty($jsarr)) {
            return '';
        }

        return $this->fetchTemplate('javascript_registry', array('jsarr' => $jsarr));
    }
}