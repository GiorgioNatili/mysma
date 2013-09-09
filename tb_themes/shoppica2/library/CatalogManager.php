<?php

require_once TB_THEME_ROOT . '/library/ThemeManager.php';

class TB_CatalogManager extends TB_ThemeManager
{
    /**
     * @var TB_DataBag
     */
    protected $globalLang;

    /**
     * @param TB_Context $context
     *
     * @return TB_CatalogManager
     */
    public static function getInstance(TB_Context $context)
    {
        if (!isset(self::$instances['catalog'])) {
            self::$instances['catalog'] = new self($context);
        }

        return self::$instances['catalog'];
    }

    public function initExtensions(TB_DataBag $dataBag)
    {
        if (null !== $this->extensions) {
            return $this->extensions;
        }

        $this->globalLang = new TB_DataBag();

        $theme_extension = $this->loadThemeExtension();
        $theme_extension->setDataBag($dataBag);
        $theme_extension->configure();
        $theme_extension->loadDefaultLanguage();
        $this->globalLang->importVars($theme_extension->loadLanguage('global'));

        self::$eventDispatcher->notify(new sfEvent($this, 'core:extensions_preconfigure'));

        $this->extensions = array();
        foreach ($this->loadExtensions() as $extension) {
            $extension->setDataBag($dataBag);
            $this->extensions[$extension->getName()] = $extension;
            $extension->loadDefaultLanguage();
            $extension->configure();
            self::$eventDispatcher->notify(new sfEvent($this, 'core:extension_postconfigure.' . $extension->getName(),
                array('extension' => $extension)));
        }

        self::$eventDispatcher->notify(new sfEvent($this, 'core:extensions_postconfigure'));

        return $this->extensions;
    }

    public function getGlobalLang()
    {
        return $this->globalLang;
    }
}