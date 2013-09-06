<?php

define('TB_BASENAME', basename(basename(__FILE__), '.php'));
define('TB_THEME_ROOT', realpath(DIR_SYSTEM . '../') . '/tb_themes/' . TB_BASENAME);
define('TB_EXTENSIONS_ROOT', realpath(DIR_SYSTEM . '../') . '/tb_extensions');

$utils_file = TB_THEME_ROOT . '/library/Utils.php';
if (!file_exists($utils_file)) {
    trigger_error('Cannot find the framework utils file. The theme files are not properly uploaded.', E_USER_ERROR);
    exit();
}

require_once TB_THEME_ROOT . '/library/Utils.php';
require_once TB_THEME_ROOT . '/library/Context.php';
require_once TB_THEME_ROOT . '/library/AdminDispatcher.php';

class ControllerModuleShoppica2 extends Controller
{
    public function index()
    {
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && !$this->user->hasPermission('modify', 'module/' . TB_BASENAME)) {
            return new Action('error/permission');
        }

        $this->load->model('setting/extension');
        if (!in_array(TB_BASENAME, $this->model_setting_extension->getInstalled('module'))) {
            return new Action('error/permission');
        }

        $dispatcher = new TB_AdminDispatcher($this->registry, TB_BASENAME);
        $dispatcher->dispatch();
    }

    public function install()
    {
        $dispatcher = new TB_AdminDispatcher($this->registry, TB_BASENAME);
        $dispatcher->installTheme();
    }
}