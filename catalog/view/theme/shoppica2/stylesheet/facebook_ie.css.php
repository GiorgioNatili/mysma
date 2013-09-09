<?php
  header('Content-type: text/css; charset=utf-8');
  $language = $_GET['language'];
?>

a, a:hover {text-decoration: none !important;}
a:hover, a:hover * {color: #000 !important;}
img {display: block !important;}

html,
body,
.fan_box,
.full_widget,
.full_widget *
{
  margin: 0 !important;
  padding: 0 !important;
  background: none !important;
  border: none !important;
}
.profileimage,
.name_block,
.connect_widget_connected_text,
.connect_widget_not_connected_text,
.connect_widget_user_action,
.pls,
.pluginConnectButton button img,
.pluginButtonIcon
{
  display: none !important;
}
.full_widget {
  position: relative !important;
  padding-top: 52px !important;
}
.connect_top,
.connect_action,
.connect_widget,
.connect_button_slider,
.connect_button_container,
.connect_widget_like_button
{
  overflow: visible !important;
  display: block !important;
  height: 24px !important;
}
.connect_widget_interactive_area,
.connect_widget_interactive_area td
{
  height: 30px !important;
}
.connect_widget_interactive_area td {
  vertical-align: bottom !important;
}
.connect_top {
  position: absolute !important;
  top: 0 !important;
  left: 0 !important;
  width: 100% !important;
}
.connect_widget_interactive_area,
.pluginConnectButton,
.uiGrid
{
  <?php if ($language == 'ltr'): ?>
  float: right !important;
  margin-left: 10px !important;
  <?php else: ?>
  float: left !important;
  margin-right: 10px !important;
  <?php endif; ?>
  border-collapse: collapse important;
  border-spacing: 0 !important;
}
.connect_widget_like_button {
  position: relative !important;
  line-height: 24px !important;
}
.connect_widget_like_button .tombstone_cross {
  <?php if ($language == 'ltr'): ?>
  float: left !important;
  <?php else: ?>
  float: right !important;
  <?php endif; ?>
  display: block !important;
  width: 24px !important;
  height: 24px !important;
  background-image: url(<?php  echo 'http://' . str_replace('www.', '', $_SERVER['HTTP_HOST']) . rtrim(dirname($_SERVER['PHP_SELF']), '/.\\') . '/';?>fb_like.png?2.2.2) !important;
  background-repeat: no-repeat !important;
}
.like_button_no_like .tombstone_cross {
  background-position: 0 0 !important;
}
.like_button_like .tombstone_cross {
  background-position: 0 -24px !important;
}
.connect_widget_like_button .liketext {
  display: block !important;
  float: left;
  height: 24px !important;
  line-height: 23px !important;
  <?php if ($language == 'ltr'): ?>
  padding: 0 0 0 7px !important;
  <?php else: ?>
  padding: 0 7px 0 0 !important;
  <?php endif; ?>
  color: #999 !important;
}
.like_button_no_like:hover .tombstone_cross {
  background-position: 0 -48px !important;
}
.like_button_like .tombstone_cross:hover {
  background-position: 0 -72px !important;
}

.pluginConnectButton .pluginButton div,
.pluginConnectButton button
{
  height: 24px !important;
  <?php if ($language == 'ltr'): ?>
  padding: 0 0 0 31px !important;
  <?php else: ?>
  padding: 0 31px 0 0 !important;
  <?php endif; ?>
  line-height: 24px !important;
  color: #999 !important;
}
.pluginConnectButton button {
  <?php if ($language == 'ltr'): ?>
  margin: 0 0 0 -31px !important;
  <?php else: ?>
  margin: 0 -31px 0 0 !important;
  <?php endif; ?>
}
.pluginConnectButton .pluginConnectButtonDisconnected div {
  background-image: url(<?php  echo 'http://' . str_replace('www.', '', $_SERVER['HTTP_HOST']) . rtrim(dirname($_SERVER['PHP_SELF']), '/.\\') . '/';?>fb_like.png?4) !important;
  background-repeat: no-repeat !important;
  <?php if ($language == 'ltr'): ?>
  background-position: 0 0 !important;
  <?php else: ?>
  background-position: 100% 0 !important;
  <?php endif; ?>
}
.pluginConnectButton:hover .pluginConnectButtonDisconnected div {
  <?php if ($language == 'ltr'): ?>
  background-position: 0 -48px !important;
  <?php else: ?>
  background-position: 100% -48px !important;
  <?php endif; ?>
}

.total {
  display: block !important;
  margin-bottom: 10px !important;
  margin-right: 20px !important;
  line-height: 20px !important;
  color: #999 !important;
  font-size: 11px !important;
  font-family: "Lucida Sans Unicode", "Lucida Grande", Arial, Helvetica, sans-serif;
}
.fan_box .connections {
  margin-right: -20px !important;
}
.connections_grid {
  overflow: hidden;
  height: 175px !important;
}
.grid_item {
  width: 60px !important;
  margin: 0 20px 14px 0 !important;
}
.grid_item a {
  display: block !important;
  color: #333 !important;
}
.grid_item a:hover {
  color: #f12b63 !important;
}
.grid_item img {
  margin-bottom: 3px !important;
  padding: 5px !important;
  background: #fff !important;
  border-bottom: 1px solid #e5e5e5 !important;
  -moz-box-shadow: 0 0 3px rgba(0, 0, 0, 0.2);
  -webkit-box-shadow: 0 0 3px rgba(0, 0, 0, 0.2);
}
.grid_item a:hover img {
  border-bottom: 1px solid #c5c5c5 !important;
}