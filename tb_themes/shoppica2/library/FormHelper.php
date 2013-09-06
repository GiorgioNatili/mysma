<?php

class TB_FormHelper
{
    public static function initFlatVars(array $vars, $form_scope, $model_settings, $request_vars)
    {
        $result = array();
        foreach ($vars as $key => $value) {
            if (isset($request_vars[$form_scope][$key])) {
                $result[$key] = $request_vars[$form_scope][$key];
            } else {
                if (isset($model_settings[$form_scope][$key])) {
                    $result[$key] = $model_settings[$form_scope][$key];
                } else {
                    $result[$key] = $value;
                }
            }
        }

        return array($form_scope => $result);
    }

    public static function initLangVars(array $vars, $form_scope, $model_settings, $request_vars, $languages)
    {
        $result = array();
        foreach ($languages as $language) {
            $lid = $language['language_id'];
            foreach ($vars as $key => $value) {
                if (isset($request_vars[$form_scope][$lid][$key])) {
                    $result[$lid][$key] = $request_vars[$form_scope][$lid][$key];
                } else {
                    if (isset($model_settings[$form_scope][$lid][$key])) {
                        $result[$lid][$key] = $model_settings[$form_scope][$lid][$key];
                    } else {
                        $result[$lid][$key] = $value;
                    }
                }
            }
        }

        return array($form_scope => $result);
    }

    public static function transformLangVar($data, $key, $model_settings, $languages)
    {
        $result = array();
        list($var_name, $default_value) = each($data);
        foreach ($languages as $language) {
            $lid = $language['language_id'];
            if (isset($model_settings[$key][$var_name][$lid])) {
                $result[$lid] = $model_settings[$key][$var_name][$lid];
            } else {
                $result[$lid] = $default_value;
            }
        }

        return $result;
    }
}