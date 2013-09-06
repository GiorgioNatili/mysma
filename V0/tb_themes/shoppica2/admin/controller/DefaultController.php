<?php

class Theme_Admin_DefaultController extends TB_AdminController
{
    public function index()
    {
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
            $this->saveSettings($this->request->post);
            $this->redirect($this->tbUrl->generate('default'));
        }

        $this->document->setTitle($this->tbLang['heading_title']);

        $extension_plugins = $this->tbExtension->getPlugins();
        foreach ($extension_plugins as $plugin) {
            if (method_exists($plugin, 'setForm')) {
                $result = call_user_func(array($plugin, 'setForm'));
                if (is_array($result)) {
                    foreach ($result as $key => $data) {
                        $this->data[$key] = $data;
                    }
                }
            }
        }

        $this->data['first_time'] = $this->getModel()->getSetting('first_time');

        $this->children = array(
            'common/header',
            'common/footer'
        );
        $this->renderAction('theme.tpl');
    }

    protected function saveSettings($form_data)
    {
        $theme_settings = $this->getModel()->getSettings();
        if (empty($theme_settings)) {
            $theme_settings = array();
        }

        $extension_plugins = $this->tbExtension->getPlugins();
        foreach ($extension_plugins as $plugin) {
            if (method_exists($plugin, 'saveForm')) {
                $result = call_user_func(array($plugin, 'saveForm'), $form_data);
                if (false !== $result && null !== $result) {
                    $theme_settings = array_replace($theme_settings, $result);
                    $this->getModel()->setSettings($theme_settings);
                }
            }
        }

        $filterEvent = new sfEvent($this->getModel(), 'controller:theme\admin\default.saveForm', array('form' => $form_data));
        $this->tbManager->getEventDispatcher()->notify($filterEvent);

        $theme_settings['first_time'] = 0;
        $this->getModel()->setAndPersistSettings($theme_settings);

        $this->session->data['success'] = $this->language->get('text_success');
    }

    public function installSampleData()
    {
        $data_file = $this->context->getThemeDir() . '/sample_data.php';
        if (!file_exists($data_file)) {
            return $this->sendJsonError('Cannot find the default initialization data file: ' . $data_file);
        }

        $languages = $this->getModel()->getLanguages();
        $theme_name = $this->tbExtension->getName();

        $sample_data = require $data_file;

        foreach ($sample_data['theme'] as $key => $value) {
            if ($key == $theme_name) {
                $footerInfo = reset($value['footerInfo']);
                $value['footerInfo'] = array();
                foreach ($languages as $language) {
                    $value['footerInfo'][$language['id']] = $footerInfo;
                }

                foreach  ($value['intro'] as $category => $settings) {
                    $images = reset($settings['images']);
                    $settings['images'] = array();
                    foreach ($languages as $language) {
                        $settings['images'][$language['id']] = $images;
                    }
                    $value['intro'][$category]['images'] = $settings['images'];
                }

                $font = reset($value['font']);
                $value['font'] = array();
                foreach ($languages as $language) {
                    $value['font'][$language['id']] = $font;
                }
            }

            if ($key == 'tb_banners') {
                foreach ($value['sets'] as $id => $settings) {
                    $images = reset($settings['images']);
                    $settings['images'] = array();
                    foreach ($languages as $language) {
                        $settings['images'][$language['id']] = $images;
                    }
                    $value['sets'][$id]['images'] = $settings['images'];
                }
            }

            $this->tbManager->getSettingsModel()->setAndPersistScopeSettings($key, $value);
        }

        foreach ($sample_data['oc'] as $group => $data) {
            $this->getOcModel('setting/extension')->uninstall('module', $group);
            $this->getOcModel('setting/setting')->deleteSetting($group);
            if ($group == 'welcome') {
                $description = reset($data['welcome_module']['1']['description']);
                $data['welcome_module']['1']['description'] = array();
                foreach ($languages as $language) {
                    $data['welcome_module']['1']['description'][$language['id']] = $description;
                }
            }
            if (!empty($data)) {
                $this->getOcModel('setting/extension')->install('module', $group);
                $this->getOcModel('user/user_group')->addPermission($this->user->getId(), 'access', 'module/' . $group);
                $this->getOcModel('user/user_group')->addPermission($this->user->getId(), 'modify', 'module/' . $group);
                $this->getOcModel('setting/setting')->editSetting($group, $data);
            }
        }

        $this->tbManager->getDbSettingsHelper()->persistGroup('config', array('config_logo' => 'data/sample_data/theme_logo.png'), $this->context->getStoreId());

        $common = $this->getModel()->getSetting('common');
        $this->tbExtension->getPlugin('common')->setDefaultOcImageSettings($common['products_per_row'], $common['product_gallery_position']);

        $this->getModel()->getDbHelper()->updateRecord('category', array('top' => 0), array('category_id' => 17));

        $this->session->data['success_alert'] = 'The sample data has been installed';

        return $this->sendJsonSuccess();
    }
}
