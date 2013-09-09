<?php

class TB_AdminUrl
{
    private $default_connection = 'NONSSL';
    private $default_args = '';
    private $default_extension;
    private $parentUrl;
    private $basename;

    public function __construct($registry)
    {
        $this->parentUrl = $registry->get('url');
    }

	public function link($route, $args = '', $connection = null)
    {
        if (empty($connection)) {
            $connection = $this->default_connection;
        }

        if (!empty($this->default_args)) {
            $args .= '&' . ltrim($this->default_args, '&');
        }

        return $this->parentUrl->link($route, $args, $connection);
	}

    public function generate($controller_action, $args = '', $params = array())
    {
        $parts = explode('/', $controller_action);
        $controller = $parts[0];
        $action = isset($parts[1]) ? $parts[1] : 'index';

        $route = 'module/' . $this->basename;
        $extension = isset($params['extension']) ? $params['extension'] : $this->default_extension;
        $args_arr = array(
            'extension='  . $extension,
            'controller=' . $controller,
            'action='     . $action
        );
        $args .= '&' . implode('&', $args_arr);

        return $this->link($route, $args);
    }

    public function generateJs($controller_action, $args = '', $params = array())
    {
        return str_replace('&amp;', '&', $this->generate($controller_action, $args, $params));
    }

    public function setBasename($basename)
    {
        $this->basename = $basename;
    }

    public function setDefaultExtension($extension)
    {
        $this->default_extension = $extension;
    }

    public function setDefaultConnection($connection)
    {
        $this->default_connection = $connection;
    }

    public function setDefaultArgs($args)
    {
        $this->default_args = $args;
    }
}
 
