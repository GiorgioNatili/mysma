<?php
abstract class Controller {
    protected $registry;
    protected $id;
    protected $layout;
    protected $template;
    protected $children = array();
    protected $data = array();
    protected $output;

    public function __construct($registry) {
        $this->registry = $registry;
        // TB Modification 1 BEGIN
        if ($registry instanceof Registry && (null != ($tbManager = $registry->get('tbManager')))) {
            if ($tbManager->getContext()->getArea() == 'catalog' && $tbManager->isThemeExtensionLoaded()) {
                $tbData = $tbManager->getThemeExtension()->getDataBag();
                $this->data['tbData'] = $tbData;
                $this->data['tbSlot'] = $tbData->tbSlot;
            }
        }
        // TB Modification 1 END
    }

    public function __get($key) {
        return $this->registry->get($key);
    }

    public function __set($key, $value) {
        $this->registry->set($key, $value);
    }

    protected function forward($route, $args = array()) {
        return new Action($route, $args);
    }

    protected function redirect($url, $status = 302) {
        header('Status: ' . $status);
        header('Location: ' . str_replace(array('&amp;', "\n", "\r"), array('&', '', ''), $url));
        exit();
    }

    protected function getChild($child, $args = array()) {
        // TB Modification 2 BEGIN
        if (false !== strpos($child, '/')) list($type, $extension_name) = explode('/', $child, 2);
        if (isset($type) && $type == 'module' && $this->registry instanceof Registry && (null != ($tbManager = $this->registry->get('tbManager')))) {
            if ($tbManager->getContext()->getArea() == 'catalog' && $tbManager->isThemeExtensionLoaded() &&
                $tbManager->getThemeExtension()->getModel()->themeModuleForOCExists($extension_name)) {
                $tbExtension = $tbManager->getExtension($extension_name);
            }
        }
        if (isset($tbExtension)) {
            $action = new TB_CatalogModuleAction($tbExtension, $args);
        } else {
            $action = new Action($child, $args);
        }
        // TB Modification 2 END

        if (file_exists($action->getFile())) {
            require_once($action->getFile());

            $class = $action->getClass();

            // TB Modification 3 BEGIN
            if (isset($tbExtension) && is_subclass_of($class, 'TB_CatalogController')) {
                $controller = new $class($tbManager, $tbExtension);
            } else {
                $controller = new $class($this->registry);
            }
            if (isset($type) && $type == 'module' && !empty($args)) {
                $controller->data['module_instance']  = $args;
                $controller->data['module_position']  = $args['position'];
                $controller->data['module_layout_id'] = $args['layout_id'];
            }
            // TB Modification 3 END
            $controller->{$action->getMethod()}($action->getArgs());

            return $controller->output;
        } else {
            trigger_error('Error: Could not load controller ' . $child . '!');
            exit();
        }
    }

    protected function render() {
        foreach ($this->children as $child) {
            $this->data[basename($child)] = $this->getChild($child);
        }

        if (file_exists(DIR_TEMPLATE . $this->template)) {
            extract($this->data);

            ob_start();

            require(DIR_TEMPLATE . $this->template);

            $this->output = ob_get_contents();

            ob_end_clean();

            return $this->output;
        } else {
            trigger_error('Error: Could not load template ' . DIR_TEMPLATE . $this->template . '!');
            exit();
        }
    }
}
?>