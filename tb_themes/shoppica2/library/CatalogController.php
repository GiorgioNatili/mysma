<?php

class TB_CatalogController extends Controller
{
    /**
     * @var TB_ThemeManager
     */
    protected $tbManager;

    /**
     * @var TB_CatalogExtension
     */
    protected $tbExtension;

    /**
     * @var TB_DataBag
     */
    protected $tbLang;

    /**
     * @var TB_DataBag
     */
    protected $tbData;

    /**
     * @var TB_Context
     */
    protected $context;

    public function __construct(TB_ThemeManager $tbManager, TB_CatalogExtension $extension)
    {
        parent::__construct($tbManager->getContext()->getRegistry());

        $this->tbManager   = $tbManager;
        $this->tbExtension = $extension;
        $this->tbLang      = $extension->getTbLang();
        $this->tbData      = $extension->getDataBag();
        $this->context     = $tbManager->getContext();
    }

    /**
     * @param string $name
     *
     * @return TB_ExtensionModel
     */
    public function getModel($name = 'default')
    {
        return $this->tbExtension->getModel($name);
    }

    protected function getRouteByName($name)
    {
        return $this->tbExtension->getRouteByName($name);
    }

    public function renderTemplate($filename)
    {
        if ($this->tbExtension->isThemeExtension()) {
            return $this->renderThemeTemplate($filename);
        } else {
            return $this->renderExtensionTemplate($filename);
        }
    }

    protected function renderExtensionTemplate($filename)
    {
        foreach ($this->children as $child) {
            $this->data[basename($child)] = $this->getChild($child);
        }

        $file = $this->tbExtension->getAreaDir() . '/view/template/' . $filename . '.tpl';

        if (!file_exists($file)) {
            throw new Exception('Could not load template ' . $file);
        }

        $this->data['tbData'] = $this->tbExtension->getDataBag();
        extract($this->data);

        ob_start();

        require TB_Utils::vqmodCheck($file);

        $this->output = ob_get_contents();

        ob_end_clean();

        return $this->output;
    }

    protected function renderThemeTemplate($filename)
    {
        $this->template = $this->context->getBasename() . '/template/tb/' . $filename . '.tpl';

        $output = $this->render();
        $this->response->setOutput($output);

        return $output;
    }
}