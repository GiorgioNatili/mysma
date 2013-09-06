<?php

require_once dirname(__FILE__) . '/../../model/schemerModel.php';

class Theme_Catalog_SchemerModel extends Theme_SchemerModel
{
    public function getSchemerCss($schemer_config)
    {
        $colors = $schemer_config['colors'];
        $backgrounds = isset($this->settings['background']['images']) ? $this->settings['background']['images'] : array();
        if (!isset($colors['texture'])) {
            $colors['texture'] = 'no_texture';
        }

        if (isset($backgrounds[$colors['texture']])) {
            $background = $backgrounds[$colors['texture']];
            $colors['texture_image']      = $this->context->getImageUrl() . $background['image'];
            $colors['texture_repeat']     = $background['repeat'];
            $colors['texture_position']   = $background['position'];
            $colors['texture_attachment'] = $background['attachment'];
        } else {
            if ($colors['texture'] != 'no_texture') {
                $colors['texture_image'] = $this->context->getThemeCatalogImageUrl() . $colors['texture'] . '.png';
            } else {
                $colors['texture_image'] = 'none';
            }

            $colors['texture_repeat']     = 'repeat';
            $colors['texture_position']   = 'top left';
            $colors['texture_attachment'] = 'scroll';
        }

        $tpl = $this->context->getCatalogTemplateDir() . '/tb/schemer.css.tpl';
        $css = file_get_contents($tpl);
        if ($colors['texture_image'] != 'none') {
            $colors['texture_image'] = 'url(\'' . $colors['texture_image'] . '\')';
        }
        foreach ($colors as $key => $value) {
            if (!is_array($value)) {
                $css = str_replace("%{$key}%", $value, $css);
            }
        }
        $css = preg_replace('/%(.*)%/', '000000', $css);
        $css = preg_replace('/[\n\r]/', ' ', $css);

        return $css;
    }
}