<?php

class TB_AdminController extends Controller
{
    /**
     * @var TB_AdminManager
     */
    protected $tbManager;

    /**
     * @var TB_AdminExtension
     */
    protected $tbExtension;

    /**
     * @var TB_AdminUrl
     */
    protected $tbUrl;

    /**
     * @var TB_Context
     */
    protected $context;

    /**
     * @var array
     */
    protected $error;

    /**
     * @var Request
     */
    protected $request;

    /**
     * @var Response
     */
    protected $response;

    /**
     * @var Session
     */
    protected $session;

    public function __construct(TB_ThemeManager $tbManager, TB_AdminExtension $extension)
    {
        $registry = $tbManager->getContext()->getRegistry();

        parent::__construct($registry);

        $this->request  = $registry->get('request');
        $this->response = $registry->get('response');
        $this->session  = $registry->get('session');

        $this->tbExtension = $extension;
        $this->tbUrl       = $extension->getTbUrl();

        $this->tbManager = $tbManager;
        $this->context   = $tbManager->getContext();

        $this->error = array();

        $this->initDataVars();
    }

    private function initDataVars()
    {
        if (isset($this->session->data['success'])) {
            $this->data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $this->data['success'] = '';
        }

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        $this->data['error_alert'] = '';
        if (isset($this->session->data['error_alert'])) {
            $this->data['error_alert'] = $this->session->data['error_alert'];
            unset($this->session->data['error_alert']);
        };

        $this->data['warning_alert'] = '';
        if (isset($this->session->data['warning_alert'])) {
            $this->data['warning_alert'] = $this->session->data['warning_alert'];
            unset($this->session->data['warning_alert']);
        };

        $this->data['success_alert'] = '';
        if (isset($this->session->data['success_alert'])) {
            $this->data['success_alert'] = $this->session->data['success_alert'];
            unset($this->session->data['success_alert']);
        };

        $dataBag = $this->tbExtension->getDataBag();
        foreach ($dataBag->exportVars() as $key => $value) {
            $this->data[$key] = $value;
        }

        $this->data['languages'] = $this->getModel()->getLanguages();
        $this->data['stores']    = $this->getOcModel('setting/store')->getStores();
        $this->data['no_image']  = $this->getOcModel('tool/image')->resize('no_image.jpg', 100, 100);
        $this->data['tbUrl']     = $this->tbUrl;

        $this->mergeLanguageVars($this->tbExtension->getTbLang()->exportVars());
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

    public function getOcModel($name)
    {
        return $this->tbExtension->getOcModel($name);
    }

    public function getExtensionName()
    {
        return $this->tbExtension->getName();
    }

    public function getStoreId()
    {
        return $this->context->getStoreId();
    }

    protected function mergeLanguageVars(array $language_vars)
    {
        $viewData = array();
        foreach ($language_vars as $key => $value) {
            $viewData['text_' . $key] = $value;
        }
        $this->data = array_merge($this->data, $viewData);
    }

    protected function validate()
    {
        if (!$this->user->hasPermission('modify', 'module/' . $this->context->getBasename())) {
            $this->error['warning'] = $this->tbExtension->getTbLang()->error_permission;
        }

        if (!$this->error) {
            return true;
        }

        return false;
    }

    protected function sendJsonError($msg, array $vars = array())
    {
        if (!isset($vars['reload'])) {
            $vars['reload'] = 0;
        }

        $this->setOutput(
            json_encode(array('success' => false, 'message' => $msg) + $vars)
        );

        return true;
    }

    protected function sendJsonSuccess($msg = '', array $vars = array())
    {
        if (!isset($vars['reload'])) {
            $vars['reload'] = 0;
        }

        $this->setOutput(
            json_encode(array('success' => true, 'message' => $msg) + $vars)
        );

        return true;
    }

    protected function renderAction($template)
    {
        foreach ($this->children as $child) {
            $this->data[basename($child)] = $this->getChild($child);
        }

        $template_file =  $this->tbExtension->getAreaDir() . '/view/template/' . $template;

        if (!file_exists($template_file)) {
            throw new Exception('Could not load template ' . $template_file);
        }

        extract($this->data);

        ob_start();

        require(TB_Utils::vqmodCheck($template_file));

        $output = ob_get_contents();

        ob_end_clean();

        $this->setOutput($output);
    }

    protected function setOutput($output)
    {
        $this->output = $output;
        $this->response->addHeader('Theme-Basename: ' . $this->context->getBasename());
        $this->response->setOutput($output);
    }

    public function __toString()
    {
        return get_class($this);
    }
}