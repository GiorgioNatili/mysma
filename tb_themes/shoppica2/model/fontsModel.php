<?php

class Theme_FontsModel extends TB_ExtensionModel
{
    public function getGoogleFontsList()
    {
        static $result = array();

        if (!empty($result)) {
            return $result;
        }

        require_once $this->context->getThemeDir() . '/library/WebfontsParser.php';

        $fonts_file = $this->context->getThemeDir() . '/webfonts.json';

        $result = WebfontsParser::parseJson($fonts_file);

        return $result;
    }

    public function combineFormData($form_data)
    {
        $combined = array();
        $google_list = $this->getGoogleFontsList();
        foreach ($form_data as $lid => $values) {
            foreach ($values as $key => $family) {
                if (false !== stripos($key, '_family')) {
                    $prefix = str_ireplace('_family', '', $key);
                    $type = $values[$prefix . '_type'];
                    if ($type != 'google') {
                        if ($type == 'built' && $prefix != 'body') {
                            $variant = $values[$prefix . '_variant'];
                            $css_weight = 'normal';
                            $css_style = 'default';
                            if ($variant  == 'bold') {
                                $css_weight = 'bold';
                            } else
                                if ($variant == 'italic') {
                                    $css_weight = 'normal';
                                    $css_style = 'italic';
                                } else
                                    if ($variant == 'bolditalic') {
                                        $css_weight = 'bold';
                                        $css_style = 'italic';
                                    }

                            $form_data[$lid][$prefix . '_css_weight'] = $css_weight;
                            $form_data[$lid][$prefix . '_css_style'] = $css_style;
                        } else {
                            $form_data[$lid][$prefix . '_css_weight'] = 'default';
                            $form_data[$lid][$prefix . '_css_style'] = 'default';
                        }

                        continue;
                    }

                    if (!isset($combined[$lid][$family]['variants'])) {
                        $combined[$lid][$family]['variants'] = array();
                        $combined[$lid][$family]['subsets'] = array();
                    }

                    $variants = explode(',', $values[$prefix . '_variant']);
                    $subsets = explode(',', $values[$prefix . '_subsets']);

                    if (!isset($google_list[$family]->variants[$variants[0]])) {
                        $google_family_variant = reset($google_list[$family]->variants);
                        $form_data[$lid][$prefix . '_variant'] = $google_family_variant['css_weight'];
                    } else {
                        $google_family_variant = $google_list[$family]->variants[$variants[0]];
                    }

                    $form_data[$lid][$prefix . '_css_weight'] = $google_family_variant['css_weight'];
                    $form_data[$lid][$prefix . '_css_style'] = $google_family_variant['css_style'];

                    $variants = array_unique(array_merge($combined[$lid][$family]['variants'], $variants));
                    $subsets = array_unique(array_merge($combined[$lid][$family]['subsets'], $subsets));

                    $combined[$lid][$family]['variants'] = $variants;
                    $combined[$lid][$family]['subsets'] = $subsets;
                }
            }
        }
        foreach ($combined as $lid => $family) {
            foreach ($family as $name => $values) {
                $values['variants'] = implode(',', $values['variants']);
                $values['subsets'] = implode(',', $values['subsets']);
                $form_data[$lid]['combined'][$name] = $values;
            }
        }

        return $form_data;
    }

    public function getBuiltFontsList()
    {
        return array(
            'Arial',
            'Tahoma',
            'Verdana',
            'Trebuchet MS',
            'Lucida Sans Unicode',
            'Georgia',
            'Times New Roman'
        );
    }
}