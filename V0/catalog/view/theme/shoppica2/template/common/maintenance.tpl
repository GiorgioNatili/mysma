<?php echo '<?xml version="1.0" encoding="UTF-8"?>'. "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" xml:lang="<?php echo $lang; ?>" xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
<title><?php echo $heading_title; ?></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<?php echo $tbData->theme_stylesheet_url; ?>screen.css.php?v=2.0&amp;<?php echo http_build_query($tbData->css_fontvars, '', '&amp;'); ?>" media="screen" />
<!--[if lt IE 9]>
<link rel="stylesheet" type="text/css" href="<?php echo $tbData->theme_stylesheet_url; ?>ie.css.php?v=2.0&amp;theme=<?php echo $tbData->basename; ?>" media="screen" />
<![endif]-->
<?php foreach ($tbData->webfonts as $font): ?>
<link href='http<?php if($tbData->isHTTPS) echo 's'?>://fonts.googleapis.com/css?family=<?php echo $font['family']; ?>&amp;subset=<?php echo $font['subset']; ?>' rel='stylesheet' type='text/css'>
<?php endforeach; ?>
<style type="text/css"><?php echo $tbData->schemer_css; ?></style>
<?php echo $google_analytics; ?>
<script type="text/javascript" src="http<?php if($tbData->isHTTPS) echo 's'?>://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
<style type="text/css">
  h1 {
    margin-bottom: 100px;
    line-height: 32px;
  }
</style>
</head>
<body class="<?php echo 's_layout_' . $tbData->common['layout_type']; ?><?php if (!$tbData->right_column_empty) { echo ' s_2_cols'; } else { echo ' s_single_col'; } ?>">

<div id="fb-root"></div>
<script type="text/javascript">
  window.fbAsyncInit = function() {
    FB.init({
            <?php if($tbData->footerInfo['facebook_appid']): ?>appId: '<?php echo $tbData->footerInfo['facebook_appid']; ?>',<?php endif; ?>
    <?php if($tbData->footerInfo['facebook_channel']): ?>channelUrl : '<?php echo $tbData->footerInfo['facebook_channel']; ?>',<?php endif; ?>
    status: true,
            cookie: true,
            xfbml: true,
            oauth : true
  });
  };
  (function(d){
    var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
      js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "//connect.facebook.net/<?php if($tbData->footerInfo['facebook_locale']): echo $tbData->footerInfo['facebook_locale']; else: echo 'en_US'; endif; ?>/all.js";
    d.getElementsByTagName('head')[0].appendChild(js);
  }(document));
</script>

<div id="wrapper">

  <div id="header" class="s_row clearfix">
    <div class="s_wrap">
      <div class="s_col_12">

        <?php if ($logo): ?>
        <a id="site_logo" href="<?php echo $tbData->base_http; ?>">
          <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
        </a>
        <?php endif; ?>

        <div id="top_navigation">

          <?php echo $language; ?>

        </div>

      </div>

    </div>
  </div>

  <?php echo $message; ?>

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
        <?php if($footerInfo['twitter_enabled'] == '1'): ?>
        <div id="twitter" class="s_col_<?php echo 12 / $footerInfo['columns_cnt']; ?>">
          <?php if($footerInfo['twitter_button'] == '1'): ?>
          <a href="https://twitter.com/<?php echo $footerInfo['twitter_username']; ?>" class="twitter-follow-button right" data-show-count="false" data-lang="<?php echo $footerInfo['twitter_button_text']; ?>" data-show-screen-name="false">Follow @<?php echo $footerInfo['twitter_username']; ?></a>
          <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
          <?php endif; ?>
          <h2>Twitter</h2>
          <ul id="twitter_update_list"></ul>
          <script type="text/javascript" src="<?php echo $tbData->theme_javascript_url; ?>twitter.js"></script>
          <script type="text/javascript">
            jQuery(document).ready(function($) {
              $.getJSON('https://api.twitter.com/1/statuses/user_timeline.json?screen_name=<?php echo $footerInfo['twitter_username']; ?>&count=<?php echo $footerInfo['twitter_tweets']; ?>&callback=?', function(tweets) {
                $("#twitter_update_list").html(get_tweets(tweets));
              });
            });
          </script>
        </div>
        <?php endif; ?>
        <?php if($footerInfo['facebook_enabled'] == '1'): ?>
        <div id="facebook" class="s_col_<?php echo 12 / $footerInfo['columns_cnt']; ?>">
          <?php if ($footerInfo['facebook_column_title']): ?><h2><?php echo $footerInfo['facebook_column_title']; ?></h2><?php endif; ?>
          <?php if ($footerInfo['facebook_widget_type'] == 'fan_box'): ?>
          <div class="s_widget_holder s_fan_box">
            <?php if ($tbData->browser_info['name'] == "msie"): ?>
            <fb:fan profileid="<?php echo $footerInfo['facebook_id']; ?>" stream="0" connections="<?php echo $footerInfo['facebook_connections']; ?>" logobar="0" width="<?php echo ((12 / $footerInfo['columns_cnt'])*80) - 20; ?>" height="<?php echo ($footerInfo['facebook_height'] + 13); ?>" css="<?php echo $tbData->context->getThemeCatalogStylesheetUrlHttp(); ?>facebook_ie.css.php?<?php echo $tbData->theme_version; ?>&amp;language=<?php echo $tbData->common['language_direction']; ?>"></fb:fan>
            <?php else: ?>
            <fb:fan profileid="<?php echo $footerInfo['facebook_id']; ?>" stream="0" connections="<?php echo $footerInfo['facebook_connections']; ?>" logobar="0" width="<?php echo ((12 / $footerInfo['columns_cnt'])*80) - 20; ?>" height="<?php echo $footerInfo['facebook_height']; ?>" css="<?php echo $tbData->context->getThemeCatalogStylesheetUrlHttp(); ?>facebook.css.php?<?php echo $tbData->theme_version; ?>&amp;language=<?php echo $tbData->common['language_direction']; ?>"></fb:fan>
            <?php endif; ?>
          </div>
          <?php else: ?>
          <div class="s_widget_holder s_like_box" style="background: <?php echo $footerInfo['facebook_bg_color']; ?>; border-color: <?php echo $footerInfo['facebook_border_color']; ?>">
            <fb:like-box href="<?php echo $footerInfo['facebook_url']; ?>" width="<?php echo $footerInfo['facebook_width']; ?>" height="<?php echo $footerInfo['facebook_height']; ?>" show_faces="true" colorscheme="light" stream="false" <?php if($footerInfo['facebook_show_header']) { echo ' header="true"'; } else { echo 'header="false"'; } ?>></fb:like-box>
          </div>
          <?php endif; ?>
        </div>
        <?php endif; ?>
      </div>
    </div>
  </div>
  <!-- end of content -->
  <?php endif; ?>

  <!-- ---------------------- -->
  <!--      F O O T E R       -->
  <!-- ---------------------- -->
  <div id="footer" class="s_wrap">
    <div id="payments_types" class="clearfix">
      <?php foreach($tbData->payment_images as $image): ?>
      <?php if ($image['url']): ?>
      <a href="<?php echo $image['url'];?>" target="_blank"><img src="<?php echo 'image/' . $image['file'];?>" /></a>
      <?php else: ?>
      <img src="<?php echo 'image/' . $image['file'];?>" />
      <?php endif; ?>
      <?php endforeach; ?>
    </div>

    <p id="copy">&copy; Copyright 2011. Powered by <a class="blue" href="http://www.opencart.com">Open Cart</a>.<br /><a class="s_main_color" href="http://www.shoppica.net">Shoppica theme</a> made by <a href="http://www.themeburn.com">ThemeBurn.com</a></p>

    <div class="clear"></div>
  </div>
  <!-- end of FOOTER -->

</div>

<script type="text/javascript" src="<?php echo $tbData->theme_javascript_url; ?>common.js.php?v=2.0&amp;is_mobile=<?php echo $tbData->is_mobile; ?>&amp;is_touch=<?php echo $tbData->is_touch; ?>&amp;language_direction=<?php echo $tbData->common['language_direction']; ?>"></script>

</body>
</html>