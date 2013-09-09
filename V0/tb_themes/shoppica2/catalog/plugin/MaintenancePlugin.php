<?php

class Theme_Catalog_MaintenancePlugin extends TB_ExtensionPlugin
{
    protected $init_order = 0;

    public function configure(TB_DataBag $tbData)
    {
        $this->eventDispatcher->connect('core:beforeRouting', array($this, 'checkMaintenance'));
    }

    public function checkMaintenance()
    {
        $this->bootstrap();
    }

    public function execute(TB_DataBag $tbData)
    {
        $action = new Action('common/maintenance');

        require_once $action->getFile();
        $class = $action->getClass();
        $controller = new $class($this->registry);
        $result = call_user_func(array($controller, 'index'));
        if (is_object($result) && get_class($result) == 'Action') {
            $maintenance = true;
        } else {
            $maintenance = false;
        }

        if ($maintenance) {
            $this->bootstrap('FooterInfo');
            $this->bootstrap('PaymentImages');
            $this->bootstrap('SchemerStyles');
            $this->bootstrap('Fonts');

            $controller = $this->tbExtension->getController('maintenance');
            $controller->index();
            $this->registry->get('response')->output();
            exit;
        }
    }
}