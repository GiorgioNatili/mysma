<?php

require_once TB_THEME_ROOT . '/library/ThemeManager.php';

class TB_AdminManager extends TB_ThemeManager
{
    protected $not_installed_extensions = array();

    /**
     * @param TB_Context $context
     *
     * @return TB_AdminManager
     */
    public static function getInstance(TB_Context $context)
    {
        if (!isset(self::$instances['admin'])) {
            self::$instances['admin'] = new self($context);
        }

        return self::$instances['admin'];
    }

    public function initExtensions(TB_DataBag $dataBag)
    {
        if (null !== $this->extensions) {
            return $this->extensions;
        }

        $theme_extension = $this->loadThemeExtension();
        $theme_extension->setDataBag($dataBag);
        $theme_extension->configure();
        $theme_extension->loadDefaultLanguage();
        $global_lang_vars = $theme_extension->loadLanguage('global');

        self::$eventDispatcher->notify(new sfEvent($this, 'core:extensions_preconfigure'));

        $this->extensions = array();
        $this->not_installed_extensions = array();
        $extensions = $this->loadExtensions(false);
        foreach ($extensions as $key => $extension) {
            $extension->loadDefaultLanguage();
            $extension->getTbLang()->importVars($global_lang_vars);
            if (!$theme_extension->getModel('extensions')->isExtensionInstalled($extension->getName())) {
                $this->not_installed_extensions[$extension->getName()] = $extension;
                unset($extensions[$key]);
            } else {
                $extension->setDataBag($dataBag);
                $this->extensions[$extension->getName()] = $extension;
                $extension->configure();
                self::$eventDispatcher->notify(new sfEvent($this, 'core:extension_postconfigure.' . $extension->getName(),
                    array('extension' => $extension)));
            }
        }

        self::$eventDispatcher->notify(new sfEvent($this, 'core:extensions_postconfigure'));

        return $this->extensions;
    }

    public function getNotInstalledExtensions()
    {
        return $this->not_installed_extensions;
    }
}