<?php

require_once TB_THEME_ROOT . '/library/Extension.php';

abstract class TB_AdminExtension extends TB_Extension
{
    protected $init_options;

    protected function createControllerInstance($class_name)
    {
        return new $class_name($this->tbManager, $this);
    }

    public function getInitOptions()
    {
        if (null !== $this->init_options) {
            return $this->init_options;
        }

        $this->init_options = array(
            'title'   => $this->tbLang['display_name'],
            'id'      => $this->name,
            'actions' => array()
        );

        return $this->init_options;
    }

    public function getInitOption($name)
    {
        $options = $this->getInitOptions();
        if (isset($options[$name])) {
            return $options[$name];
        }

        return false;
    }

    /**
     * @param string $controller_name
     *
     * @throws Exception
     * @return TB_AdminController
     */
    public function getController($controller_name)
    {
        $controller = parent::getController($controller_name);
        if (!is_subclass_of($controller, 'TB_AdminController')) {
            throw new Exception('Controller not subclass of TB_AdminController');
        }

        return $controller;
    }

    public function getTbUrl()
    {
        if (null != $this->tbUrl) {
            return $this->tbUrl;
        }

        $registry = $this->context->registry;

        $tbUrl = new TB_AdminUrl($registry);
        $tbUrl->setBasename($this->context->getBasename());
        $tbUrl->setDefaultExtension($this->name);
        $tbUrl->setDefaultConnection('SSL');
        $tbUrl->setDefaultArgs(
            'token='     . $registry->get('session')->data['token'] .
            '&store_id=' . $this->context->getStoreId()
        );
        $this->tbUrl = $tbUrl;

        return $this->tbUrl;
    }

    public function fetchTemplate($filename, array $data = array())
    {
        $data['tbUrl'] = $this->getTbUrl();

        return parent::fetchTemplate($filename, $data);
    }
}