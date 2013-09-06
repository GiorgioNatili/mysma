<div id="footer_info_tabs" class="tb_tabs tb_htabs tb_top_tabs">
  <ul class="tb_tabs_nav clearfix">
    <li><a href="#footer_info_settings"><span class="s_icon_16"><span class="s_icon s_page_white_edit_16"></span><?php echo $text_menu_footer_info; ?></span></a></li>
    <li><a href="#footer_contacts_settings"><span class="s_icon_16"><span class="s_icon s_contact_email_16"></span><?php echo $text_menu_footer_contacts; ?></span></a></li>
    <li><a href="#footer_twitter_settings"><span class="s_icon_16"><span class="s_icon tb_twitter_16"></span><?php echo $text_menu_footer_twitter; ?></span></a></li>
    <li><a href="#footer_facebook_settings"><span class="s_icon_16"><span class="s_icon tb_facebook_16"></span><?php echo $text_menu_footer_facebook; ?></span></a></li>
    <li><a href="#footer_payment_settings"><span class="s_icon_16"><span class="s_icon s_paypal_16"></span><?php echo $text_menu_footer_payments; ?></span></a></li>
  </ul>

  <div id="footer_info_settings">

    <h2><span><?php echo $text_title_footer_info; ?></span></h2>

    <?php if (count($languages) > 1): ?>
    <div id="footer_info_language_tabs" class="htabs clearfix">
      <?php foreach ($languages as $language): ?>
      <a href="#footer_info_language_<?php echo $language['language_id']; ?>">
        <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>images/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
      </a>
      <?php endforeach; ?>
    </div>
    <?php endif; ?>

    <?php foreach ($languages as $language): ?>
    <?php $language_id = $language['language_id']; ?>
    <div id="footer_info_language_<?php echo $language_id; ?>" class="divtab">
      <div class="s_row_2 first clearfix">
        <label for="footer_info_yes"><?php echo $text_enabled; ?></label>
        <input type="hidden" name="footer[<?php echo $language_id; ?>][info_enabled]" value="0" />
        <input id="footer_info_yes" class="tb_toggle" type="checkbox" name="footer[<?php echo $language_id; ?>][info_enabled]" value="1"<?php if($footerInfo[$language_id]['info_enabled'] == '1') echo ' checked="checked"';?> />
      </div>
      <div class="s_row_2 clearfix">
        <label><?php echo $text_label_footer_info_title; ?></label>
        <div class="s_full">
          <input type="text" name="footer[<?php echo $language_id; ?>][info_title]" size="45" value="<?php echo $footerInfo[$language_id]['info_title']; ?>" />
        </div>
      </div>
      <div class="s_row_2 clearfix">
        <label><?php echo $text_label_footer_info_text; ?></label>
        <div class="s_full">
          <textarea name="footer[<?php echo $language_id; ?>][info_text]" cols="43" rows="12"><?php echo $footerInfo[$language_id]['info_text']; ?></textarea>
        </div>
      </div>
    </div>
    <?php endforeach; ?>
  </div>

  <div id="footer_contacts_settings">

    <h2><span><?php echo $text_title_footer_contacts; ?></span></h2>

    <?php if (count($languages) > 1): ?>
    <div id="footer_contacts_language_tabs" class="htabs clearfix">
      <?php foreach ($languages as $language): ?>
      <a href="#footer_contacts_language_<?php echo $language['language_id']; ?>">
        <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>images/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
      </a>
      <?php endforeach; ?>
    </div>
    <?php endif; ?>

    <?php foreach ($languages as $language): ?>
    <?php $language_id = $language['language_id']; ?>
    <div id="footer_contacts_language_<?php echo $language_id; ?>" class="divtab">
      <div class="s_row_2 first clearfix">
        <label for="footer_contacts_yes"><?php echo $text_enabled; ?></label>
        <input type="hidden" name="footer[<?php echo $language_id; ?>][contacts_enabled]" value="0" />
        <input id="footer_contacts_yes" class="tb_toggle" type="checkbox" name="footer[<?php echo $language_id; ?>][contacts_enabled]" value="1"<?php if($footerInfo[$language_id]['contacts_enabled'] == '1') echo ' checked="checked"';?> />
      </div>

      <div class="s_row_2 clearfix">
        <input type="hidden" name="footer[<?php echo $language_id; ?>][skypename_show]" value="0">
        <label><?php echo $text_label_footer_contacts_skype; ?></label>
        <input class="inline" type="text" name="footer[<?php echo $language_id; ?>][skypename1]" value="<?php echo $footerInfo[$language_id]['skypename1']; ?>" />&nbsp;&nbsp;
        <input class="inline" type="text" name="footer[<?php echo $language_id; ?>][skypename2]" value="<?php echo $footerInfo[$language_id]['skypename2']; ?>" />
        <label class="s_checkbox left"><input type="checkbox" value="1" name="footer[<?php echo $language_id; ?>][skypename_show]"<?php if($footerInfo[$language_id]['skypename_show'] == '1') echo ' checked="checked"';?> /> <?php echo $text_show; ?></label>
      </div>

      <div class="s_row_2 clearfix">
        <input type="hidden" name="footer[<?php echo $language_id; ?>][email_show]" value="0">
        <label><?php echo $text_label_footer_contacts_email; ?></label>
        <label class="s_checkbox left"><input type="checkbox" value="1" name="footer[<?php echo $language_id; ?>][email_show]"<?php if($footerInfo[$language_id]['email_show'] == '1') echo ' checked="checked"';?> /> <?php echo $text_show; ?></label>
        <input class="inline" type="text" name="footer[<?php echo $language_id; ?>][email1]" value="<?php echo $footerInfo[$language_id]['email1']; ?>" />&nbsp;&nbsp;
        <input class="inline" type="text" name="footer[<?php echo $language_id; ?>][email2]" value="<?php echo $footerInfo[$language_id]['email2']; ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <input type="hidden" name="footer[<?php echo $language_id; ?>][mobile_show]" value="0">
        <label><?php echo $text_label_footer_contacts_mobile; ?></label>
        <label class="s_checkbox left"><input type="checkbox" value="1" name="footer[<?php echo $language_id; ?>][mobile_show]"<?php if($footerInfo[$language_id]['mobile_show'] == '1') echo ' checked="checked"';?> /> <?php echo $text_show; ?></label>
        <input class="inline" type="text" name="footer[<?php echo $language_id; ?>][mobile1]" value="<?php echo $footerInfo[$language_id]['mobile1']; ?>" />&nbsp;&nbsp;
        <input class="inline" type="text" name="footer[<?php echo $language_id; ?>][mobile2]" value="<?php echo $footerInfo[$language_id]['mobile2']; ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <input type="hidden" name="footer[<?php echo $language_id; ?>][phone_show]" value="0">
        <label><?php echo $text_label_footer_contacts_phone; ?></label>
        <label class="s_checkbox left"><input type="checkbox" value="1" name="footer[<?php echo $language_id; ?>][phone_show]"<?php if($footerInfo[$language_id]['phone_show'] == '1') echo ' checked="checked"';?> /> <?php echo $text_show; ?></label>
        <input class="inline" type="text" name="footer[<?php echo $language_id; ?>][phone1]" value="<?php echo $footerInfo[$language_id]['phone1']; ?>" />&nbsp;&nbsp;
        <input class="inline" type="text" name="footer[<?php echo $language_id; ?>][phone2]" value="<?php echo $footerInfo[$language_id]['phone2']; ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <input type="hidden" name="footer[<?php echo $language_id; ?>][fax_show]" value="0">
        <label><?php echo $text_label_footer_contacts_fax ; ?></label>
        <label class="s_checkbox left"><input type="checkbox" value="1" name="footer[<?php echo $language_id; ?>][fax_show]"<?php if($footerInfo[$language_id]['fax_show'] == '1') echo ' checked="checked"';?> /> <?php echo $text_show; ?></label>
        <input class="inline" type="text" name="footer[<?php echo $language_id; ?>][fax1]" value="<?php echo $footerInfo[$language_id]['fax1']; ?>" />&nbsp;&nbsp;
        <input class="inline" type="text" name="footer[<?php echo $language_id; ?>][fax2]" value="<?php echo $footerInfo[$language_id]['fax2']; ?>" />
      </div>
    </div>
    <?php endforeach; ?>
  </div>

  <div id="footer_twitter_settings">

    <h2><span><?php echo $text_title_footer_twitter; ?></span></h2>

    <?php if (count($languages) > 1): ?>
    <div id="footer_twitter_language_tabs" class="htabs clearfix">
      <?php foreach ($languages as $language): ?>
      <a href="#footer_twitter_language_<?php echo $language['language_id']; ?>">
        <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>images/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
      </a>
      <?php endforeach; ?>
    </div>
    <?php endif; ?>

    <?php foreach ($languages as $language): ?>
    <?php $language_id = $language['language_id']; ?>
    <div id="footer_twitter_language_<?php echo $language_id; ?>" class="divtab">
      <div class="s_row_2 first clearfix">
        <label for="footer_twitter_yes"><?php echo $text_enabled; ?></label>
        <input type="hidden" name="footer[<?php echo $language_id; ?>][twitter_enabled]" value="0" />
        <input id="footer_twitter_yes" class="tb_toggle" type="checkbox" name="footer[<?php echo $language_id; ?>][twitter_enabled]" value="1"<?php if($footerInfo[$language_id]['twitter_enabled'] == '1') echo ' checked="checked"';?> />
      </div>

      <div class="s_row_2 clearfix">
        <label>Title</label>
        <input type="text" name="footer[<?php echo $language_id; ?>][twitter_column_title]" value="<?php echo $footerInfo[$language_id]['twitter_column_title']; ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label>Twitter integration</label>
        <select name="footer[<?php echo $language_id; ?>][twitter_integration]" id="twitter_integration">
          <option value="default"<?php if($footerInfo[$language_id]['twitter_integration'] == 'default') echo ' selected="selected"';?>>Default widget</option>
          <option value="custom"<?php if($footerInfo[$language_id]['twitter_integration'] == 'custom') echo ' selected="selected"';?>>Custom widget</option>
        </select>
      </div>

      <div class="s_row_2 clearfix opt_default">
        <label>Widget code</label>
        <textarea name="footer[<?php echo $language_id; ?>][twitter_widget_code]" rows="12" cols="43"><?php echo $footerInfo[$language_id]['twitter_widget_code']; ?></textarea>
      </div>

      <?php if (function_exists('curl_init')): ?>

      <div class="s_row_2 clearfix opt_custom">
        <label><?php echo $text_label_footer_tweets; ?></label>
        <select name="footer[<?php echo $language_id; ?>][twitter_max_tweets]">
          <option value="1"<?php if($footerInfo[$language_id]['twitter_max_tweets'] == '1') echo ' selected="selected"';?>>1</option>
          <option value="2"<?php if($footerInfo[$language_id]['twitter_max_tweets'] == '2') echo ' selected="selected"';?>>2</option>
          <option value="3"<?php if($footerInfo[$language_id]['twitter_max_tweets'] == '3') echo ' selected="selected"';?>>3</option>
        </select>
      </div>

      <div class="s_row_2 clearfix opt_custom">
        <label><?php echo $text_label_footer_twitter_username; ?></label>
        <input type="text" name="footer[<?php echo $language_id; ?>][twitter_username]" value="<?php echo $footerInfo[$language_id]['twitter_username']; ?>" />
      </div>

      <div class="s_row_2 clearfix opt_custom">
        <label for="footer_twitter_button_toggle"><?php echo $text_label_footer_twitter_button; ?></label>
        <input type="hidden" name="footer[<?php echo $language_id; ?>][twitter_button]" value="0" />
        <input id="footer_twitter_button_toggle" class="tb_toggle" type="checkbox" name="footer[<?php echo $language_id; ?>][twitter_button]" value="1"<?php if($footerInfo[$language_id]['twitter_button'] == '1') echo ' checked="checked"';?> />
      </div>

      <div class="s_row_2 clearfix opt_custom">
        <label><?php echo $text_label_footer_twitter_button_text; ?></label>
        <select name="footer[<?php echo $language_id; ?>][twitter_button_text]">
          <option value="ja"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'ja') echo ' selected="selected"'; ?>>Japanese - 日本語</option>
          <option value="pt"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'pt') echo ' selected="selected"'; ?>>Portuguese - Português</option>
          <option value="da"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'da') echo ' selected="selected"'; ?>>Danish - Dansk</option>
          <option value="sv"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'sv') echo ' selected="selected"'; ?>>Swedish - Svenska</option>
          <option value="uk"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'uk') echo ' selected="selected"'; ?>>Ukrainian - Українська мова</option>
          <option value="it"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'it') echo ' selected="selected"'; ?>>Italian - Italiano</option>
          <option value="msa"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'msa') echo ' selected="selected"'; ?>>Malay - Bahasa Melayu</option>
          <option value="zh-tw"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'zh-tw') echo ' selected="selected"'; ?>>Traditional Chinese - 繁體中文</option>
          <option value="es"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'es') echo ' selected="selected"'; ?>>Spanish - Español</option>
          <option value="fr"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'fr') echo ' selected="selected"'; ?>>French - français</option>
          <option value="tr"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'tr') echo ' selected="selected"'; ?>>Turkish - Türkçe</option>
          <option value="hi"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'hi') echo ' selected="selected"'; ?>>Hindi - हिन्दी</option>
          <option value="he"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'he') echo ' selected="selected"'; ?>>Hebrew - עִבְרִית</option>
          <option value="id"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'id') echo ' selected="selected"'; ?>>Indonesian - Bahasa Indonesia</option>
          <option value="th"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'th') echo ' selected="selected"'; ?>>Thai - ภาษาไทย</option>
          <option value="ar"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'ar') echo ' selected="selected"'; ?>>Arabic - العربية</option>
          <option value="zh-cn"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'zh-cn') echo ' selected="selected"'; ?>>Simplified Chinese - 简体中文</option>
          <option value="en"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'en') echo ' selected="selected"'; ?>>English</option>
          <option value="de"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'de') echo ' selected="selected"'; ?>>German - Deutsch</option>
          <option value="pl"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'pl') echo ' selected="selected"'; ?>>Polish - Polski</option>
          <option value="ca"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'ca') echo ' selected="selected"'; ?>>Catalan - català</option>
          <option value="ko"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'ko') echo ' selected="selected"'; ?>>Korean - 한국어</option>
          <option value="no"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'no') echo ' selected="selected"'; ?>>Norwegian - Norsk</option>
          <option value="nl"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'nl') echo ' selected="selected"'; ?>>Dutch - Nederlands</option>
          <option value="hu"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'hu') echo ' selected="selected"'; ?>>Hungarian - Magyar</option>
          <option value="fa"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'fa') echo ' selected="selected"'; ?>>Farsi - فارسی</option>
          <option value="ur"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'ur') echo ' selected="selected"'; ?>>Urdu - اردو</option>
          <option value="ru"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'ru') echo ' selected="selected"'; ?>>Russian - Русский</option>
          <option value="fil"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'fil') echo ' selected="selected"'; ?>>Filipino - Filipino</option>
          <option value="fi"<?php if($footerInfo[$language_id]['twitter_button_text'] == 'fi') echo ' selected="selected"'; ?>>Finnish - Suomi</option>
        </select>
      </div>

      <div class="s_row_2 clearfix opt_custom">
        <label for="footer_twitter_button_toggle">Hide replies</label>
        <input type="hidden" name="footer[<?php echo $language_id; ?>][twitter_hide_replies]" value="0" />
        <input id="footer_twitter_button_toggle" class="tb_toggle" type="checkbox" name="footer[<?php echo $language_id; ?>][twitter_hide_replies]" value="1"<?php if($footerInfo[$language_id]['twitter_hide_replies'] == '1') echo ' checked="checked"';?> />
      </div>

      <div class="s_row_2 clearfix opt_custom">
        <label>Consumer key</label>
        <input type="text" name="footer[<?php echo $language_id; ?>][twitter_consumer_key]" value="<?php echo $footerInfo[$language_id]['twitter_consumer_key']; ?>" />
      </div>

      <div class="s_row_2 clearfix opt_custom">
        <label>Consumer secret</label>
        <input type="text" name="footer[<?php echo $language_id; ?>][twitter_consumer_secret]" value="<?php echo $footerInfo[$language_id]['twitter_consumer_secret']; ?>" />
      </div>

      <div class="s_row_2 clearfix opt_custom">
        <label>Access token</label>
        <input type="text" name="footer[<?php echo $language_id; ?>][twitter_access_token]" value="<?php echo $footerInfo[$language_id]['twitter_access_token']; ?>" />
      </div>

      <div class="s_row_2 clearfix opt_custom">
        <label>Access secret</label>
        <input type="text" name="footer[<?php echo $language_id; ?>][twitter_access_secret]" value="<?php echo $footerInfo[$language_id]['twitter_access_secret']; ?>" />
      </div>

      <?php else: ?>

      <div class="s_row_2 clearfix opt_custom">
        <p>
          The php extension <strong>curl</strong> does not seem to be available in your server configuration. Please, ask your server administrator to install it in order to use the custom twitter widget.
        </p>
      </div>

      <?php endif; ?>

    </div>
    <?php endforeach; ?>

  </div>

  <div id="footer_facebook_settings">

    <h2><span><?php echo $text_title_footer_facebook; ?></span></h2>

    <?php if (count($languages) > 1): ?>
    <div id="footer_facebook_language_tabs" class="htabs clearfix">
      <?php foreach ($languages as $language): ?>
      <a href="#footer_facebook_language_<?php echo $language['language_id']; ?>">
        <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>images/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
      </a>
      <?php endforeach; ?>
    </div>
    <?php endif; ?>

    <?php foreach ($languages as $language): ?>
    <?php $language_id = $language['language_id']; ?>
    <div id="footer_facebook_language_<?php echo $language_id; ?>" class="divtab">
      <div class="s_row_2 first clearfix">
        <label for="footer_facebook_yes"><?php echo $text_enabled; ?></label>
        <input type="hidden" name="footer[<?php echo $language_id; ?>][facebook_enabled]" value="0" />
        <input id="footer_facebook_yes" class="tb_toggle" type="checkbox" name="footer[<?php echo $language_id; ?>][facebook_enabled]" value="1"<?php if($footerInfo[$language_id]['facebook_enabled'] == '1') echo ' checked="checked"';?> />
      </div>
      <div class="s_row_2 clearfix">
        <label><?php echo $text_label_footer_facebook_column_title; ?></label>
        <input type="text" name="footer[<?php echo $language_id; ?>][facebook_column_title]" value="<?php echo $footerInfo[$language_id]['facebook_column_title']; ?>" />
      </div>
      <div class="s_row_2 clearfix">
        <label><?php echo $text_label_footer_facebook_widget_type; ?></label>
        <select name="footer[<?php echo $language_id; ?>][facebook_widget_type]" id="facebook_widget_type">
          <option value="fan_box"<?php if($footerInfo[$language_id]['facebook_widget_type'] == 'fan_box') echo ' selected="selected"';?>><?php echo $text_opt_facebook_widget_fan; ?></option>
          <option value="like_box"<?php if($footerInfo[$language_id]['facebook_widget_type'] == 'like_box') echo ' selected="selected"';?>><?php echo $text_opt_facebook_widget_like; ?></option>
        </select>
      </div>
      <div class="s_row_2 clearfix opt_fan_box">
        <label><?php echo $text_label_footer_facebook_id; ?></label>
        <input type="text" name="footer[<?php echo $language_id; ?>][facebook_id]" value="<?php echo $footerInfo[$language_id]['facebook_id']; ?>" />
      </div>
      <div class="s_row_2 clearfix opt_fan_box">
        <label><?php echo $text_label_footer_facebook_connections; ?></label>
        <input type="text" name="footer[<?php echo $language_id; ?>][facebook_connections]" value="<?php echo $footerInfo[$language_id]['facebook_connections']; ?>" />
      </div>
      <div class="s_row_2 clearfix opt_like_box">
        <label><?php echo $text_label_footer_facebook_url; ?></label>
        <input type="text" name="footer[<?php echo $language_id; ?>][facebook_url]" value="<?php echo $footerInfo[$language_id]['facebook_url']; ?>" />
      </div>
      <div class="s_row_2 clearfix opt_like_box">
        <label><?php echo $text_label_footer_facebook_show_header; ?></label>
        <input type="hidden" name="footer[<?php echo $language_id; ?>][facebook_show_header]" value="0" />
        <input class="tb_toggle" type="checkbox" name="footer[<?php echo $language_id; ?>][facebook_show_header]" value="1"<?php if($footerInfo[$language_id]['facebook_show_header'] == '1') echo ' checked="checked"';?> />
      </div>
      <div class="s_row_2 clearfix opt_like_box">
        <label><?php echo $text_label_footer_facebook_width; ?></label>
        <input type="text" name="footer[<?php echo $language_id; ?>][facebook_width]" value="<?php echo $footerInfo[$language_id]['facebook_width']; ?>" />
      </div>
      <div class="s_row_2 clearfix">
        <label><?php echo $text_label_footer_facebook_height; ?></label>
        <input type="text" name="footer[<?php echo $language_id; ?>][facebook_height]" value="<?php echo $footerInfo[$language_id]['facebook_height']; ?>" />
      </div>
      <div class="s_row_2 clearfix opt_like_box">
        <label><?php echo $text_label_footer_facebook_bg_color; ?></label>
        <input type="text" name="footer[<?php echo $language_id; ?>][facebook_bg_color]" value="<?php echo $footerInfo[$language_id]['facebook_bg_color']; ?>" />
      </div>
      <div class="s_row_2 clearfix opt_like_box">
        <label><?php echo $text_label_footer_facebook_border_color; ?></label>
        <input type="text" name="footer[<?php echo $language_id; ?>][facebook_border_color]" value="<?php echo $footerInfo[$language_id]['facebook_border_color']; ?>" />
      </div>
      <div class="s_row_2 clearfix">
        <label><?php echo $text_label_footer_facebook_locale; ?></label>
        <select name="footer[<?php echo $language_id; ?>][facebook_locale]">
            <option value="af_ZA"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'af_ZA') echo ' selected="selected"'; ?>>Afrikaans</option>
            <option value="sq_AL"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'sq_AL') echo ' selected="selected"'; ?>>Albanian</option>
            <option value="ar_AR"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'ar_AR') echo ' selected="selected"'; ?>>Arabic</option>
            <option value="az_AZ"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'az_AZ') echo ' selected="selected"'; ?>>Azeri</option>
            <option value="hy_AM"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'hy_AM') echo ' selected="selected"'; ?>>Armenian</option>
            <option value="be_BY"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'be_BY') echo ' selected="selected"'; ?>>Belarusian</option>
            <option value="bg_BG"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'bg_BG') echo ' selected="selected"'; ?>>Bulgarian</option>
            <option value="eu_ES"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'eu_ES') echo ' selected="selected"'; ?>>Basque</option>
            <option value="bn_IN"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'bn_IN') echo ' selected="selected"'; ?>>Bengali</option>
            <option value="bs_BA"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'bs_BA') echo ' selected="selected"'; ?>>Bosnian</option>
            <option value="ca_ES"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'ca_ES') echo ' selected="selected"'; ?>>Catalan</option>
            <option value="cs_CZ"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'cs_CZ') echo ' selected="selected"'; ?>>Czech</option>
            <option value="hr_HR"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'hr_HR') echo ' selected="selected"'; ?>>Croatian</option>
            <option value="da_DK"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'da_DK') echo ' selected="selected"'; ?>>Danish</option>
            <option value="nl_NL"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'nl_NL') echo ' selected="selected"'; ?>>Dutch</option>
            <option value="en_US"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'en_US') echo ' selected="selected"'; ?>>English</option>
            <option value="eo_EO"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'eo_EO') echo ' selected="selected"'; ?>>Esperanto</option>
            <option value="et_EE"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'et_EE') echo ' selected="selected"'; ?>>Estonian</option>
            <option value="fi_FI"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'fi_FI') echo ' selected="selected"'; ?>>Finnish</option>
            <option value="fo_FO"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'fo_FO') echo ' selected="selected"'; ?>>Faroese</option>
            <option value="tl_PH"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'tl_PH') echo ' selected="selected"'; ?>>Filipino</option>
            <option value="fr_FR"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'fr_FR') echo ' selected="selected"'; ?>>French</option>
            <option value="fy_NL"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'fy_NL') echo ' selected="selected"'; ?>>Frisian</option>
            <option value="de_DE"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'de_DE') echo ' selected="selected"'; ?>>German</option>
            <option value="el_GR"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'el_GR') echo ' selected="selected"'; ?>>Greek</option>
            <option value="gl_ES"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'gl_ES') echo ' selected="selected"'; ?>>Galician</option>
            <option value="ka_GE"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'ka_GE') echo ' selected="selected"'; ?>>Georgian</option>
            <option value="he_IL"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'he_IL') echo ' selected="selected"'; ?>>Hebrew</option>
            <option value="hi_IN"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'hi_IN') echo ' selected="selected"'; ?>>Hindi</option>
            <option value="hu_HU"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'hu_HU') echo ' selected="selected"'; ?>>Hungarian</option>
            <option value="ga_IE"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'ga_IE') echo ' selected="selected"'; ?>>Irish</option>
            <option value="id_ID"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'id_ID') echo ' selected="selected"'; ?>>Indonesian</option>
            <option value="is_IS"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'is_IS') echo ' selected="selected"'; ?>>Icelandic</option>
            <option value="it_IT"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'it_IT') echo ' selected="selected"'; ?>>Italian</option>
            <option value="ja_JP"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'ja_JP') echo ' selected="selected"'; ?>>Japanese</option>
            <option value="km_KH"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'km_KH') echo ' selected="selected"'; ?>>Khmer</option>
            <option value="ko_KR"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'ko_KR') echo ' selected="selected"'; ?>>Korean</option>
            <option value="ku_TR"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'ku_TR') echo ' selected="selected"'; ?>>Kurdish</option>
            <option value="lt_LT"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'lt_LT') echo ' selected="selected"'; ?>>Lithuanian</option>
            <option value="lv_LV"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'lv_LV') echo ' selected="selected"'; ?>>Latvian</option>
            <option value="ml_IN"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'ml_IN') echo ' selected="selected"'; ?>>Malayalam</option>
            <option value="ms_MY"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'ms_MY') echo ' selected="selected"'; ?>>Malay</option>
            <option value="ne_NP"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'ne_NP') echo ' selected="selected"'; ?>>Nepali</option>
            <option value="nn_NO"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'nn_NO') echo ' selected="selected"'; ?>>Norwegian</option>
            <option value="pa_IN"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'pa_IN') echo ' selected="selected"'; ?>>Punjabi</option>
            <option value="pl_PL"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'pl_PL') echo ' selected="selected"'; ?>>Polish</option>
            <option value="fa_IR"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'fa_IR') echo ' selected="selected"'; ?>>Persian</option>
            <option value="pt_BR"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'pt_BR') echo ' selected="selected"'; ?>>Portuguese (Brazil)</option>
            <option value="pt_PT"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'pt_PT') echo ' selected="selected"'; ?>>Portuguese (Portugal)</option>
            <option value="ro_RO"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'ro_RO') echo ' selected="selected"'; ?>>Romanian</option>
            <option value="ru_RU"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'ru_RU') echo ' selected="selected"'; ?>>Russian</option>
            <option value="sk_SK"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'sk_SK') echo ' selected="selected"'; ?>>Slovak</option>
            <option value="es_ES"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'es_ES') echo ' selected="selected"'; ?>>Spanish</option>
            <option value="sl_SI"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'sl_SI') echo ' selected="selected"'; ?>>Slovenian</option>
            <option value="sr_RS"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'sr_RS') echo ' selected="selected"'; ?>>Serbian</option>
            <option value="sv_SE"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'sv_SE') echo ' selected="selected"'; ?>>Swedish</option>
            <option value="sw_KE"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'sw_KE') echo ' selected="selected"'; ?>>Swahili</option>
            <option value="zh_CN"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'zh_CN') echo ' selected="selected"'; ?>>Simplified Chinese (China)</option>
            <option value="ta_IN"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'ta_IN') echo ' selected="selected"'; ?>>Tamil</option>
            <option value="te_IN"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'te_IN') echo ' selected="selected"'; ?>>Telugu</option>
            <option value="th_TH"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'th_TH') echo ' selected="selected"'; ?>>Thai</option>
            <option value="zh_HK"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'zh_HK') echo ' selected="selected"'; ?>>Traditional Chinese (Hong Kong)</option>
            <option value="zh_TW"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'zh_TW') echo ' selected="selected"'; ?>>Traditional Chinese (Taiwan)</option>
            <option value="tr_TR"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'tr_TR') echo ' selected="selected"'; ?>>Turkish</option>
            <option value="uk_UA"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'uk_UA') echo ' selected="selected"'; ?>>Ukrainian</option>
            <option value="vi_VN"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'vi_VN') echo ' selected="selected"'; ?>>Vietnamese</option>
            <option value="cy_GB"<?php if ($footerInfo[$language_id]['facebook_locale'] == 'cy_GB') echo ' selected="selected"'; ?>>Welsh</option>
        </select>
      </div>
      <div class="s_row_2 clearfix">
        <label><?php echo $text_label_footer_facebook_appid; ?></label>
        <input type="text" name="footer[<?php echo $language_id; ?>][facebook_appid]" value="<?php echo $footerInfo[$language_id]['facebook_appid']; ?>" />
      </div>
      <div class="s_row_2 clearfix">
        <label><?php echo $text_label_footer_facebook_channel; ?></label>
        <input type="text" name="footer[<?php echo $language_id; ?>][facebook_channel]" value="<?php echo $footerInfo[$language_id]['facebook_channel']; ?>" />
      </div>
    </div>
    <?php endforeach; ?>

  </div>


  <div id="footer_payment_settings">
    <h2><span><?php echo $text_title_footer_payments; ?></span></h2>

    <table id="payment_images_table" class="s_table" width="100%" cellpadding="0" cellspacing="0" border="0">
      <thead>
        <tr>
          <td class="first" width="60"><?php echo $text_image; ?></td>
          <td width="23">#</td>
          <td><?php echo $text_url; ?></td>
          <td width="30">&nbsp;</td>
        </tr>
      </thead>
      <tbody>
        <?php $payment_image_row = 0; ?>
        <?php foreach ($payment_images as $banner_image): ?>
        <tr id="payment_image_row<?php echo $payment_image_row; ?>">
          <td>
            <input type="hidden" name="payment[images][<?php echo $payment_image_row; ?>][image]" value="<?php echo $banner_image['file']; ?>" id="payment_image<?php echo $payment_image_row; ?>"  />
            <img src="<?php echo $banner_image['preview']; ?>" alt="" id="payment_preview<?php echo $payment_image_row; ?>" class="image" onclick="image_upload('payment_image<?php echo $payment_image_row; ?>', 'payment_preview<?php echo $payment_image_row; ?>');" />
          </td>
          <td><input type="text" name="payment[images][<?php echo $payment_image_row; ?>][order]" value="<?php echo $banner_image['order']; ?>" style="width: 15px;" size="1" /></td>
          <td><input type="text" name="payment[images][<?php echo $payment_image_row; ?>][url]" value="<?php echo $banner_image['url']; ?>" style="width: 98%;" /></td>
          <td><a onclick="$('#payment_image_row<?php echo $payment_image_row; ?>').remove();" class="s_button_close"><?php echo $text_remove; ?></a></td>
        </tr>
        <?php $payment_image_row++; ?>
        <?php endforeach; ?>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="4"><a onclick="addImagePayment();" class="s_button s_button_2 s_button_green right s_mr_0"><?php echo $text_button_add_image; ?></a></td>
        </tr>
      </tfoot>
    </table>

  </div>

</div>

<div class="s_submit clearfix">
  <a class="s_button" onclick="$('#form').submit();"><span class="s_icon_16"><span class="s_icon s_tick_16"></span><?php echo $text_button_save_settings; ?></span></a>
</div>


<script type="text/javascript">

$(document).ready(function(){

  $('#footer_info_tabs').tbTabs({
    cookie: {
      expires: 2000,
      name: "tbfootertabs"
    }
  });

  $("#facebook_widget_type").bind("change", function() {
    if ($(this).val() == 'fan_box') {
      $("#footer_facebook_settings div.opt_like_box").hide();
      $("#footer_facebook_settings div.opt_fan_box").show();
    } else {
      $("#footer_facebook_settings div.opt_fan_box").hide();
      $("#footer_facebook_settings div.opt_like_box").show();
    }
  }).trigger("change");

  $("#twitter_integration").bind("change", function() {
    $("#footer_twitter_settings div.opt_default").toggle($(this).val() == "default");
    $("#footer_twitter_settings div.opt_custom").toggle($(this).val() == "custom");
  }).trigger("change");

});

$("#footer_info_language_tabs a").tabs();
$("#footer_contacts_language_tabs a").tabs();
$("#footer_twitter_language_tabs a").tabs();
$("#footer_facebook_language_tabs a").tabs();

var payment_image_row = <?php echo $payment_image_row; ?>;
function addImagePayment() {
  html = '<tr id="payment_image_row' + payment_image_row + '">';
  html += '<td><input type="hidden" name="payment[images][' + payment_image_row + '][image]" value="" id="payment_image' + payment_image_row + '" /><img width="51" src="<?php echo $no_image; ?>" alt="" id="payment_preview' + payment_image_row + '" class="image" onclick="image_upload(\'payment_image' + payment_image_row + '\', \'payment_preview' + payment_image_row + '\');" /></td>';
  html += '<td><input type="text" name="payment[images][' + payment_image_row + '][order]" value="' + (payment_image_row + 1) + '" style="width: 15px;" size="1" /></td>';
  html += '<td><input type="text" name="payment[images][' + payment_image_row + '][url]" value="" style="width: 98%;" /></td>';
  html += '<td><a onclick="$(\'#payment_image_row' + payment_image_row  + '\').remove();" class="s_button_close">Remove</a></td>';
  html += '</tr>';

  $("#payment_images_table tbody").append(html);
  payment_image_row++;
}

</script>