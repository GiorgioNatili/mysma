<?php

class Theme_Catalog_FontsPlugin extends TB_ExtensionPlugin
{
    public function execute(TB_DataBag $tbData)
    {
        $this->bootstrap('common');

        if (isset($this->extension_settings['font'][$this->language_id])) {
            $font = $this->extension_settings['font'][$this->language_id];
        } else {
            $font = reset($this->extension_settings['font']);
        }

        $event = new sfEvent($this, 'theme:catalog_fonts_plugin.filter_font', array('tbData' => $tbData));
        $font = $this->eventDispatcher->filter($event, $font)->getReturnValue();

        $webfonts = array();
        if (isset($font['combined'])) {
            foreach ($font['combined'] as $family => $values) {
                $webfonts[] = array(
                    'family' => $family . ':' . $values['variants'],
                    'subset' => $values['subsets']
                );
            }
        }

        $css_fontvars = array(
            'is_mobile'                 => $tbData->is_mobile,
            'is_touch'                  => $tbData->is_touch,
            'language'                  => $tbData->common['language_direction'],
            'price_design'              => $tbData->common['price_design'],
            'border'                    => $tbData->common['border_type'],
            'font_body'                 => $font['body_family'],
            'font_navigation'           => $font['navigation_family'],
            'font_navigation_weight'    => $font['navigation_css_weight'],
            'font_navigation_style'     => $font['navigation_css_style'],
            'font_navigation_size'      => $font['navigation_size'],
            'font_intro'                => $font['intro_family'],
            'font_intro_weight'         => $font['intro_css_weight'],
            'font_intro_style'          => $font['intro_css_style'],
            'font_intro_size'           => $font['intro_size'],
            'font_title'                => $font['title_family'],
            'font_title_weight'         => $font['title_css_weight'],
            'font_title_style'          => $font['title_css_style'],
            'font_price'                => $font['price_family'],
            'font_price_weight'         => $font['price_css_weight'],
            'font_price_style'          => $font['price_css_style'],
            'font_button'               => $font['button_family'],
            'font_button_weight'        => $font['button_css_weight'],
            'font_button_style'         => $font['button_css_style'],
            'font_button_size'          => $font['button_size']
        );

        $tbData->font = $font;
        $tbData->webfonts = $webfonts;
        $tbData->css_fontvars = $css_fontvars;
    }
}