<div id="store_settings_tabs" class="tb_tabs tb_htabs tb_top_tabs">

  <ul class="tb_tabs_nav clearfix">
    <li><a href="#shop_settings_tab"><span class="s_icon_16"><span class="s_icon s_basket_16"></span>Features</span></a></li>
    <?php $tbSlot->flag('tb\theme_store.tabs.navigation'); ?>
  </ul>

  <div id="shop_settings_tab">
    <h2><span><?php echo $text_title_store_features; ?></span></h2>

    <div class="s_row_2 first clearfix">
      <label>Opencart</label>
      <div class="s_full tb_4col_wrap s_mb_15 clearfix">
        <div class="s_row_1 tb_col tb_5_24 clearfix">
          <label for="common_manufacturers_enabled"><?php echo $text_label_toggle_manufacturers; ?></label>
          <span class="clear"></span>
          <input type="hidden" name="common[manufacturers_enabled]" value="0" />
          <input id="common_manufacturers_enabled" class="tb_toggle" type="checkbox" name="common[manufacturers_enabled]" value="1"<?php if($common['manufacturers_enabled'] == '1') echo ' checked="checked"';?> />
        </div>

        <div class="s_row_1 tb_col tb_5_24 clearfix">
          <label for="common_compare_enabled"><?php echo $text_label_toggle_compare; ?></label>
          <span class="clear"></span>
          <input type="hidden" name="common[compare_enabled]" value="0" />
          <input id="common_compare_enabled" class="tb_toggle" type="checkbox" name="common[compare_enabled]" value="1"<?php if($common['compare_enabled'] == '1') echo ' checked="checked"';?> />
        </div>

        <div class="s_row_1 tb_col tb_5_24 clearfix">
          <label for="common_wishlist_enabled"><?php echo $text_label_toggle_wishlist; ?></label>
          <span class="clear"></span>
          <input type="hidden" name="common[wishlist_enabled]" value="0" />
          <input id="common_wishlist_enabled" class="tb_toggle" type="checkbox" name="common[wishlist_enabled]" value="1"<?php if($common['wishlist_enabled'] == '1') echo ' checked="checked"';?> />
        </div>

        <div class="s_row_1 tb_col tb_5_24 clearfix">
          <label for="common_checkout_enabled"><?php echo $text_label_toggle_checkout; ?></label>
          <span class="clear"></span>
          <input type="hidden" name="common[checkout_enabled]" value="0" />
          <input id="common_checkout_enabled" class="tb_toggle" type="checkbox" name="common[checkout_enabled]" value="1"<?php if($common['checkout_enabled'] == '1') echo ' checked="checked"';?> />
        </div>
      </div>

      <div class="s_full tb_4col_wrap clearfix">
        <div class="s_row_1 tb_col tb_5_24 clearfix">
          <label for="common_voucher_enabled"><?php echo $text_label_toggle_voucher; ?></label>
          <input type="hidden" name="common[voucher_enabled]" value="0" />
          <input id="common_voucher_enabled" class="tb_toggle" type="checkbox" name="common[voucher_enabled]" value="1"<?php if($common['voucher_enabled'] == '1') echo ' checked="checked"';?> />
        </div>

        <div class="s_row_1 tb_col tb_5_24 clearfix">
          <label for="common_affiliate_enabled"><?php echo $text_label_toggle_affiliate; ?></label>
          <input type="hidden" name="common[affiliate_enabled]" value="0" />
          <input id="common_affiliate_enabled" class="tb_toggle" type="checkbox" name="common[affiliate_enabled]" value="1"<?php if($common['affiliate_enabled'] == '1') echo ' checked="checked"';?> />
        </div>

        <div class="s_row_1 tb_col tb_5_24 clearfix">
          <label for="common_returns_enabled"><?php echo $text_label_toggle_returns; ?></label>
          <input type="hidden" name="common[returns_enabled]" value="0" />
          <input id="common_returns_enabled" class="tb_toggle" type="checkbox" name="common[returns_enabled]" value="1"<?php if($common['returns_enabled'] == '1') echo ' checked="checked"';?> />
        </div>

        <div class="s_row_1 tb_col tb_5_24 clearfix">
          <label for="common_product_social_share_enabled"><?php echo $text_label_toggle_produt_share; ?></label>
          <input type="hidden" name="common[product_social_share_enabled]" value="0" />
          <input id="common_product_social_share_enabled" class="tb_toggle" type="checkbox" name="common[product_social_share_enabled]" value="1"<?php if($common['product_social_share_enabled'] == '1') echo ' checked="checked"';?> />
        </div>
      </div>
    </div>

    <div class="s_row_2 clearfix">
      <label><?php echo $text_label_navigation; ?></label>
      <div class="s_full tb_4col_wrap s_mb_15 clearfix">
        <div class="s_row_1 tb_col tb_5_24 clearfix">
          <label for="common_footer_navigation_enabled"><?php echo $text_label_toggle_footer_nav; ?></label>
          <input type="hidden" name="common[footer_navigation_enabled]" value="0" />
          <input id="common_footer_navigation_enabled" class="tb_toggle" type="checkbox" name="common[footer_navigation_enabled]" value="1"<?php if($common['footer_navigation_enabled'] == '1') echo ' checked="checked"';?> />
        </div>

        <div class="s_row_1 tb_col tb_5_24 clearfix">
          <label for="common_menu_brands_enabled"><?php echo $text_label_toggle_brands_menu; ?></label>
          <input type="hidden" name="common[menu_brands_enabled]" value="0" />
          <input id="common_menu_brands_enabled" class="tb_toggle" type="checkbox" name="common[menu_brands_enabled]" value="1"<?php if($common['menu_brands_enabled'] == '1') echo ' checked="checked"';?> />
        </div>

        <div class="s_row_1 tb_col tb_5_24 clearfix">
          <label for="common_menu_infopages_enabled"><?php echo $text_label_toggle_info_menu; ?></label>
          <input type="hidden" name="common[menu_infopages_enabled]" value="0" />
          <input id="common_menu_infopages_enabled" class="tb_toggle" type="checkbox" name="common[menu_infopages_enabled]" value="1"<?php if($common['menu_infopages_enabled'] == '1') echo ' checked="checked"';?> />
        </div>
      </div>
    </div>

  </div>

  <?php $tbSlot->flag('tb\theme_store.tabs.content'); ?>

</div>

<div class="s_submit clearfix">
  <a class="s_button" onclick="$('#form').submit();"><span class="s_icon_16"><span class="s_icon s_tick_16"></span><?php echo $text_button_save_settings; ?></span></a>
</div>


<script type="text/javascript">

$(document).ready(function(){

    $('#store_settings_tabs').tbTabs({
      cookie: {
        expires: 2000,
        name: "tbstoretabs"
      }
    });

});

</script>

