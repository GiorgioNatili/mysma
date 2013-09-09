<?php if (!isset($tbData)) require dirname(__FILE__) . '/../tb/install_error.tpl'; ?>

<?php if ($tbData->footerInfo['columns_cnt'] > 0): $footerInfo = $tbData->footerInfo; ?>
<!-- ---------------------- -->
<!--   S H O P   I N F O    -->
<!-- ---------------------- -->
<div id="shop_info" class="s_row">
  <div id="shop_info_wrap" class="s_row">
    <div class="s_wrap">
      <?php if($footerInfo['info_enabled'] == '1'): ?>
      <div id="shop_description" class="s_col_<?php echo 12 / $footerInfo['columns_cnt']; ?>">
        <h2><?php echo $footerInfo['info_title']?></h2>
        <p><?php echo $footerInfo['info_text']?></p>
      </div>
      <?php endif; ?>
      <?php if($footerInfo['contacts_enabled'] == '1'): ?>
      <div id="shop_contacts" class="s_col_<?php echo 12 / $footerInfo['columns_cnt']; ?>">
        <h2><?php echo $tbData->text_contact_us; ?></h2>
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
          <?php if ($footerInfo['phone_show'] == "1"): ?>
          <tr<?php if ($tbData->browser_info['name'] == "safari"): ?> class="s_webkit"<?php endif; ?>>
            <td valign="middle">
              <span class="s_icon_32">
                <span class="s_icon s_phone_32"></span>
                <?php echo $footerInfo['phone1']; ?> <?php echo '<br />' . $footerInfo['phone2']; ?>
              </span>
            </td>
          </tr>
          <?php endif; ?>
          <?php if ($footerInfo['mobile_show']  == "1"): ?>
          <tr<?php if ($tbData->browser_info['name'] == "safari"): ?> class="s_webkit"<?php endif; ?>>
            <td valign="middle">
              <span class="s_icon_32">
                <span class="s_icon s_mobile_32"></span>
                <?php echo $footerInfo['mobile1']; ?> <?php echo '<br />' . $footerInfo['mobile2']; ?>
              </span>
            </td>
          </tr>
          <?php endif; ?>
          <?php if ($footerInfo['fax_show'] == "1"): ?>
          <tr<?php if ($tbData->browser_info['name'] == "safari"): ?> class="s_webkit"<?php endif; ?>>
            <td valign="middle">
              <span class="s_icon_32">
                <span class="s_icon s_fax_32"></span>
                <?php echo $footerInfo['fax1']; ?> <?php echo '<br />' . $footerInfo['fax2']; ?>
              </span>
            </td>
          </tr>
          <?php endif; ?>
          <?php if ($footerInfo['email_show'] == "1"): ?>
          <tr<?php if ($tbData->browser_info['name'] == "safari"): ?> class="s_webkit"<?php endif; ?>>
            <td valign="middle">
              <span class="s_icon_32">
                <span class="s_icon s_mail_32"></span>
                <?php echo $footerInfo['email1']; ?> <?php echo '<br />' . $footerInfo['email2']; ?>
              </span>
            </td>
          </tr>
          <?php endif; ?>
          <?php if ($footerInfo['skypename_show'] == "1"): ?>
          <tr<?php if ($tbData->browser_info['name'] == "safari"): ?> class="s_webkit"<?php endif; ?>>
            <td valign="middle">
              <span class="s_icon_32">
                <span class="s_icon s_skype_32"></span>
                <?php echo $footerInfo['skypename1']; ?> <?php echo '<br />' . $footerInfo['skypename2']; ?>
              </span>
            </td>
          </tr>
          <?php endif; ?>
        </table>
      </div>
      <?php endif; ?>
      <?php if ($footerInfo['twitter_enabled'] == '1'): ?>
      <div id="twitter" class="s_col_<?php echo 12 / $footerInfo['columns_cnt']; ?>">
        <?php if($footerInfo['twitter_button'] == '1' && $footerInfo['twitter_integration'] == 'custom'): ?>
        <a href="https://twitter.com/<?php echo $footerInfo['twitter_username']; ?>" class="twitter-follow-button right" data-show-count="false" data-lang="<?php echo $footerInfo['twitter_button_text']; ?>" data-show-screen-name="false">Follow @<?php echo $footerInfo['twitter_username']; ?></a>
        <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
        <?php endif; ?>
        <?php if($footerInfo['twitter_column_title']): ?>
        <h2><?php echo $footerInfo['twitter_column_title']; ?></h2>
        <?php endif; ?>
        <?php if ($footerInfo['twitter_integration'] == 'custom'): ?>
        <ul id="twitter_update_list">
          <?php foreach ($footerInfo['twitter_tweets'] as $tweet): ?>
          <li>
            <?php if (isset($tweet['time_ago'])): ?>
            <span><?php echo $tweet['text']; ?></span>
            <a href="https://twitter.com/<?php echo $footerInfo['twitter_username']; ?>/status/<?php echo $tweet['id_str']; ?>"><?php echo $tweet['time_ago']; ?></a>
            <?php else: ?>
            <span style="background-color: #EB6E6E"><strong><?php echo $tweet['text']; ?></strong></span>
            <?php endif; ?>
          </li>
          <?php endforeach; ?>
        </ul>
        <?php else: ?>
        <div class="s_widget_holder">
          <?php echo html_entity_decode($footerInfo['twitter_widget_code']) ?>
        </div>
        <?php endif; ?>
      </div>
      <?php endif; ?>
      <?php if($footerInfo['facebook_enabled'] == '1'): ?>
      <div id="facebook" class="s_col_<?php echo 12 / $footerInfo['columns_cnt']; ?>">
        <?php if ($footerInfo['facebook_column_title']): ?><h2><?php echo $footerInfo['facebook_column_title']; ?></h2><?php endif; ?>
        <?php if ($footerInfo['facebook_widget_type'] == 'fan_box'): ?>
        <div class="s_widget_holder s_fan_box">
          <div class="s_button_holder s_<?php echo $tbData->footerInfo['facebook_locale']; ?>">
            <fb:like-box href="<?php echo $footerInfo['facebook_url']; ?>" width="600" height="100" show_faces="false" stream="false" colorscheme="light" header="false"></fb:like-box>
          </div>
          <?php if ($tbData->browser_info['name'] == "msie"): ?>
          <fb:fan profileid="<?php echo $footerInfo['facebook_id']; ?>" stream="0" connections="<?php echo $footerInfo['facebook_connections']; ?>" logobar="0" width="<?php echo ((12 / $footerInfo['columns_cnt'])*80) - 20; ?>" height="<?php echo ($footerInfo['facebook_height'] + 13); ?>" css="<?php echo $tbData->context->getThemeCatalogStylesheetUrlHttp(); ?>facebook_ie.css.php?<?php echo $tbData->theme_version; ?>&amp;language=<?php echo $tbData->common['language_direction']; ?>"></fb:fan>
          <?php else: ?>
          <fb:fan profileid="<?php echo $footerInfo['facebook_id']; ?>" stream="0" connections="<?php echo $footerInfo['facebook_connections']; ?>" logobar="0" width="<?php echo ((12 / $footerInfo['columns_cnt'])*80) - 20; ?>" height="<?php echo $footerInfo['facebook_height']; ?>" css="<?php echo $tbData->context->getThemeCatalogStylesheetUrlHttp(); ?>facebook.css.php?<?php echo $tbData->theme_version; ?>&amp;language=<?php echo $tbData->common['language_direction']; ?>"></fb:fan>
          <?php endif; ?>
        </div>
        <?php else: ?>
        <div class="s_widget_holder s_like_box" style="height: <?php echo $footerInfo['facebook_height'] - 2; ?>px; background: <?php echo $footerInfo['facebook_bg_color']; ?>; border-color: <?php echo $footerInfo['facebook_border_color']; ?>">
          <fb:like-box href="<?php echo $footerInfo['facebook_url']; ?>" width="<?php echo $footerInfo['facebook_width']; ?>" height="<?php echo $footerInfo['facebook_height']; ?>" show_faces="true" colorscheme="light" stream="false" <?php if($footerInfo['facebook_show_header']) { echo ' header="true"'; } else { echo 'header="false"'; } ?>></fb:like-box>
        </div>
        <?php endif; ?>
      </div>
      <?php endif; ?>
    </div>
  </div>
</div>
<!-- end of shop info -->
<?php endif; ?>


<?php if ($tbData->common['footer_navigation_enabled']): ?>
<!-- ---------------------- -->
<!--  F O O T E R   N A V   -->
<!-- ---------------------- -->
<div id="footer_nav" class="s_row">
  <div class="s_wrap">
    <div class="s_col_3">
      <h2 class="s_main_color"><?php echo $text_information; ?></h2>
      <ul class="s_list_1">
        <?php foreach ($informations as $information): ?>
        <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php endforeach; ?>
      </ul>
    </div>
    <div class="s_col_3">
      <h2 class="s_main_color"><?php echo $text_extra; ?></h2>
      <ul class="s_list_1">
        <?php if ($tbData->common['manufacturers_enabled']): ?>
        <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
        <?php endif; ?>
        <?php if ($tbData->common['voucher_enabled']): ?>
        <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
        <?php endif; ?>
        <?php if ($tbData->common['affiliate_enabled']): ?>
        <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
        <?php endif; ?>
        <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
      </ul>
    </div>
    <div class="s_col_3">
      <h2 class="s_main_color"><?php echo $text_account; ?></h2>
      <ul class="s_list_1">
        <?php if ($tbData->common['checkout_enabled']): ?>
        <?php if($this->customer->isLogged()): ?>
        <li><a href="<?php echo $this->url->link('account/account', '', 'SSL'); ?>"><?php echo $text_account; ?></a></li>
        <?php else: ?>
        <li><a href="<?php echo $this->url->link('account/login', '', 'SSL'); ?>"><?php echo $tbData->text_login; ?></a></li>
        <?php endif; ?>
        <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
        <?php endif; ?>
        <?php if ($tbData->common['wishlist_enabled']): ?>
        <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
        <?php endif; ?>
        <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
      </ul>
    </div>
    <div class="s_col_3">
      <h2 class="s_main_color"><?php echo $text_service; ?></h2>
      <ul class="s_list_1">
        <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
        <?php if ($tbData->common['returns_enabled']): ?>
        <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
        <?php endif; ?>
        <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
      </ul>
    </div>
    <div class="s_col_12 border_eee"></div>
  </div>
</div>
<?php endif; ?>


<!-- ---------------------- -->
<!--      F O O T E R       -->
<!-- ---------------------- -->
<div id="footer" class="s_wrap">
  <div id="payments_types" class="clearfix">
  <?php foreach($tbData->payment_images as $image): ?>
    <?php if ($image['url']): ?>
    <a href="<?php echo $image['url'];?>" target="_blank"><img src="<?php echo $image['http_file']; ?>" /></a>
    <?php else: ?>
    <img src="<?php echo $image['http_file']; ?>" />
    <?php endif; ?>
  <?php endforeach; ?>
  </div>

  <p id="copy">&copy; Copyright 2012. Powered by <a class="blue" href="http://www.opencart.com">Open Cart</a>.<br /><a class="s_main_color" href="http://www.shoppica2.com">Shoppica theme</a> made by <a href="http://www.themeburn.com">ThemeBurn.com</a></p>

  <div class="clear"></div>
</div>
<!-- end of FOOTER -->

</div>

<script type="text/javascript" src="<?php echo $tbData->theme_javascript_url; ?>common.js.php?v=2.0&amp;is_mobile=<?php echo $tbData->is_mobile; ?>&amp;is_touch=<?php echo $tbData->is_touch; ?>&amp;language_direction=<?php echo $tbData->common['language_direction']; ?>"></script>
<link rel="stylesheet" type="text/css" href="<?php echo $tbData->theme_javascript_url; ?>noty/css/jquery.noty.css" media="screen" />

</body>
</html>