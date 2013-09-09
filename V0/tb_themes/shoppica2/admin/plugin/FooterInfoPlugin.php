<?php

class Theme_Admin_FooterInfoPlugin extends TB_ExtensionPlugin
{
    public function setForm()
    {
        $langVars = array(
            'info_enabled'            => 0,
            'info_title'              => '',
            'info_text'               => '',
            'contacts_enabled'        => 0,
            'skypename_show'          => 0,
            'skypename1'              => '',
            'skypename2'              => '',
            'email_show'              => 0,
            'email1'                  => '',
            'email2'                  => '',
            'mobile_show'             => 0,
            'mobile1'                 => '',
            'mobile2'                 => '',
            'phone_show'              => 0,
            'phone1'                  => '',
            'phone2'                  => '',
            'fax_show'                => 0,
            'fax1'                    => '',
            'fax2'                    => '',
            'twitter_enabled'         => 0,
            'twitter_column_title'    => 'Twitter',
            'twitter_integration'     => 'default',
            'twitter_widget_code'     => '',
            'twitter_username'        => '',
            'twitter_max_tweets'      => 2,
            'twitter_button'          => 0,
            'twitter_button_text'     => 'en',
            'twitter_hide_replies'    => 0,
            'twitter_consumer_key'    => '',
            'twitter_consumer_secret' => '',
            'twitter_access_token'    => '',
            'twitter_access_secret'   => '',
            'facebook_enabled'        => 0,
            'facebook_column_title'   => 'Facebook',
            'facebook_url'            => 'http://www.facebook.com/themeburn',
            'facebook_id'             => '141972485900147',
            'facebook_show_header'    => 1,
            'facebook_widget_type'    => 'fan_box',
            'facebook_connections'    => 8,
            'facebook_width'          => 304,
            'facebook_height'         => 264,
            'facebook_bg_color'       => '#fff',
            'facebook_border_color'   => '#e3e3e3',
            'facebook_locale'         => 'en_US',
            'facebook_appid'          => '',
            'facebook_channel'        => ''
        );

        // FooterInfo is used because it conflicts with the opencart $footer layout variable
        return TB_FormHelper::initLangVars(
            $langVars,
            'footerInfo',
            $this->getModel()->getSettings(),
            $this->request->post,
            $this->getModel()->getLanguages()
        );
    }

    public function saveForm($form)
    {
        return array('footerInfo' => $form['footer']);
    }
}