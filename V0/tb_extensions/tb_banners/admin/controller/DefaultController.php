<?php

class TbBanners_Admin_DefaultController extends TB_AdminController
{
    protected $settings;

    public function init()
    {
        $this->load->model('tool/image');
        $this->load->model('design/layout');
        
        $this->settings = $this->getModel()->getSettings();
    }

    public function index()
    {
        $this->renderAction('index.tpl');
    }

    public function checkPermissions()
    {
        if (!$this->validate()) {
            return $this->sendJsonError('You do not have sufficient permissions to modify this module!');
        }

        return $this->sendJsonSuccess('Success');
    }

    public function listPositions()
    {
        $positions = $this->tbManager->getSettingsModel()->getScopeSettings($this->tbExtension->getName() . '_module');
        $positions = !empty($positions) ? $positions : array();

        $this->data['positions']    = $positions;
        $this->data['layouts']      = $this->model_design_layout->getLayouts();
        $this->data['banners_sets'] = isset($this->settings['sets']) ? $this->settings['sets'] : array();
        $this->data['form_scope']   = $this->tbExtension->getName();

        $this->renderAction('positions.tpl');
    }

    public function savePositions()
    {
        if ($this->request->server['REQUEST_METHOD'] != 'POST' || !$this->validate()) {
            return $this->sendJsonError('You do not have sufficient permissions to modify this module!');
        }

        $scope = $this->tbExtension->getName() . '_module';
        $data = isset($this->request->post[$scope]) ? $this->request->post[$scope] : array();
        $this->tbManager->getSettingsModel()->setAndPersistScopeSettings($scope, $data);

        return $this->sendJsonSuccess($this->data['text_save_position_success']);
    }

    public function listSets()
    {
        $this->data['sets'] = isset($this->settings['sets']) ? $this->settings['sets'] : array();

        $this->renderAction('list_sets.tpl');
    }

    public function displaySet()
    {
        if (isset($this->request->get['setId'])) {
            $setId = (string) $this->request->get['setId'];
            if (!isset($this->settings['sets'][$setId])) {
                return $this->sendJsonError('The set with id ' . $setId . ' does not exist in the database');
            }
            $set = $this->settings['sets'][$setId];
            $set_action = 'edit';
        } else {
            $setId = uniqid();
            $set = array();
            $set_action = 'add';
        }

        $images = isset($set['images']) && !empty($set['images']) ? $set['images'] : array();
        $languages = $this->getModel()->getLanguages();

        if (!empty($images)) {
            foreach ($languages as $language) {
                if (!isset($images[$language['language_id']])) {
                    $images[$language['language_id']] = array();
                } else {
                    foreach ($images[$language['language_id']] as $key => &$values) {
                        if ($values['file'] && file_exists(DIR_IMAGE . $values['file'])) {
                            $values['preview'] = $this->model_tool_image->resize($values['file'], 110, 70);
                            if (!isset($values['new_window'])) {
                                $values['new_window'] = 0;
                            }
                        } else {
                            unset($images[$language['language_id']][$key]);
                        }
                    }
                }
            }
        } else {
            foreach ($languages as $language) {
                $images[$language['language_id']] = array();
            }
        }

        $set['id']     = $setId;
        $set['action'] = $set_action;
        $set['images'] = $images;
        $set['name']   = isset($set['name']) ? $set['name'] : '';

        $event = new sfEvent($this, 'controller:tb_banners\admin\edit_set.filter_set', array('set' => $set));
        $set = $this->tbManager->getEventDispatcher()->filter($event, $set)->getReturnValue();

        $this->data['set']                = $set;
        $this->data['languages']          = $this->getModel()->getLanguages();
        $this->data['no_image']           = $this->model_tool_image->resize('no_image.jpg', 100, 100);
        $this->data['text_image_manager'] = $this->language->get('text_image_manager');

        $this->renderAction('edit_set.tpl');
    }

    public function deleteSet()
    {
        if (!$this->validate()) {
            return $this->sendJsonError('You do not have sufficient permissions to modify this module!');
        }

        if (!isset($this->request->get['setId']) || empty($this->request->get['setId'])) {
            return $this->sendJsonError('The set cannot be deleted!');
        }

        $setId = (string) $this->request->get['setId'];
        if (!isset($this->settings['sets'][$setId])) {
            return $this->sendJsonError('The set does not exist!');
        }

        $positions = $this->config->get($this->tbExtension->getName() . '_module');
        foreach ((array) $positions as $module) {
            if ($setId == $module['setId']) {
                return $this->sendJsonError('You cannot delete this set as it is currently used in a layout!');
            }
        }

        unset($this->settings['sets'][$setId]);
        $this->getModel()->setAndPersistSettings($this->settings);

        return $this->sendJsonSuccess('The banner set has been deleted!');
    }

    public function saveSet()
    {
        if ($this->request->server['REQUEST_METHOD'] != 'POST' || !$this->validate()) {
            return $this->sendJsonError('You do not have sufficient permissions to modify this module!');
        }

        $form_data = isset($this->request->post['set']) ? $this->request->post['set'] : array();

        $config = array();
        if (isset($form_data['images']) && !empty($form_data['images']) && is_array($form_data['images'])) {
            foreach ($form_data['images'] as $language_id => $form_images) {
                if (!isset($form_data['images'][$language_id]) || empty($form_images) || !is_array($form_images)) {
                    $config[$language_id] = '';
                    continue;
                }

                $images = array();
                $orders = array();
                foreach ($form_images as $key => $values) {
                    $order = (int) $values['order'];
                    $orders[] = $order;
                }
                sort($orders);

                $result = array();
                foreach ($form_images as $key => $values) {
                    $order = (int) $values['order'];
                    $key = array_search($order, $orders);
                    $result[$key] = $values;
                    unset($orders[$key]);
                }
                ksort($result);

                foreach ($result as $key => $values) {
                    if (!empty($values['image'])) {
                        $images[$key]['order']      = $key + 1;
                        $images[$key]['file']       = $values['image'];
                        $images[$key]['new_window'] = isset($values['new_window']) ? 1 : 0;
                        $images[$key]['url']        = $values['url'];
                    }
                }

                $config[$language_id] = $images;
            }
        }

        if (!isset($this->settings['sets'])) {
            $this->settings['sets'] = array();
        }

        $set['name']   = $form_data['name'];
        $set['images'] = $config;

        $event = new sfEvent($this, 'controller:tb_banners\admin\edit_set.filter_saveForm', array('form' => $form_data));
        $set = $this->tbManager->getEventDispatcher()->filter($event, $set)->getReturnValue();

        $setId = (string) $form_data['setId'];
        $this->settings['sets'][$setId] = $set;

        $this->getModel()->setAndPersistSettings($this->settings);

        return $this->sendJsonSuccess($this->language->get('text_success'));
    }
}