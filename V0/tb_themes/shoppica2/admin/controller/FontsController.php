<?php

class Theme_Admin_FontsController extends TB_AdminController
{
    public function index()
    {
        foreach ($this->setForm() as $key => $data) {
            $this->data[$key] = $data;
        }

        $this->renderAction('theme_design_typography.tpl');
    }

    protected function setForm()
    {
        $lang_vars = array(
            'body_family'        => 'default',
            'body_type'          => 'default',
            'body_variant'       => '',
            'body_subsets'       => '',
            'navigation_family'  => 'default',
            'navigation_type'    => 'default',
            'navigation_variant' => '',
            'navigation_subsets' => '',
            'navigation_size'    => '16',
            'intro_family'       => 'default',
            'intro_type'         => 'default',
            'intro_variant'      => '',
            'intro_subsets'      => '',
            'intro_size'         => '32',
            'title_family'       => 'default',
            'title_type'         => 'default',
            'title_variant'      => '',
            'title_subsets'      => '',
            'price_family'       => 'default',
            'price_type'         => 'default',
            'price_variant'      => '',
            'price_subsets'      => '',
            'button_family'      => 'default',
            'button_type'        => 'default',
            'button_variant'     => '',
            'button_subsets'     => '',
            'button_size'        => '16'
        );

        $lang_vars = TB_FormHelper::initLangVars(
            $lang_vars,
            'font',
            $this->getModel()->getSettings(),
            $this->request->post,
            $this->getModel()->getLanguages()
        );
        $google_list = $this->getModel('fonts')->getGoogleFontsList();
        $built_list = $this->getModel('fonts')->getBuiltFontsList();
        $built_variants = array('regular', 'bold', 'italic', 'bolditalic');

        return array(
            'google_font_list'     => $google_list,
            'google_font_families' => array_keys($google_list),
            'built_font_families'  => $built_list,
            'built_font_variants'  => $built_variants,
            'font'                 => $lang_vars['font']
        );
    }

    public function getFontData()
    {
        $name = (string) $this->request->get['font_name'];
        $list = $this->getModel('fonts')->getGoogleFontsList();

        $font = $list[$name];
        $this->setOutput(json_encode($font));
    }
}