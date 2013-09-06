<div id="design_settings_tabs" class="tb_tabs tb_htabs tb_top_tabs">

  <ul class="tb_tabs_nav clearfix">
    <li><a href="#design_common_settings_tab"><span class="s_icon_16"><span class="s_icon s_layout_16"></span><?php echo $text_menu_design_common; ?></span></a></li>
    <li><a href="#color_settings_tab"><span class="s_icon_16"><span class="s_icon s_color_wheel_16"></span><?php echo $text_menu_design_colors; ?></span></a></li>
    <li><a href="<?php echo $tbUrl->generate('fonts/index'); ?>" title="#typography_settings_tab"><span class="s_icon_16"><span class="s_icon s_style_16"></span><?php echo $text_menu_design_typography ?></span></a></li>
    <li><a href="#product_settings_tab"><span class="s_icon_16"><span class="s_icon s_box_16"></span><?php echo $text_menu_design_product; ?></span></a></li>
    <li><a href="#background_settings_tab"><span class="s_icon_16"><span class="s_icon s_picture_16"></span><?php echo $text_menu_design_background; ?></span></a></li>
    <li><a href="#custom_css_tab"><span class="s_icon_16"><span class="s_icon s_css_16"></span><?php echo $text_menu_design_custom_css; ?></span></a></li>
  </ul>

  <div id="design_common_settings_tab">
    <h2><span><?php echo $text_title_design_common; ?></span></h2>
    <div class="s_row_2 first clearfix">
      <label><?php echo $text_label_search_bar; ?></label>
      <select name="common[show_search_bar]">
        <option value="1"<?php if($common['show_search_bar'] == '1') echo ' selected="selected"';?>><?php echo $text_opt_search_bar_1; ?></option>
        <option value="0"<?php if($common['show_search_bar'] == '0') echo ' selected="selected"';?>><?php echo $text_opt_search_bar_2; ?></option>
      </select>
    </div>

    <div class="s_row_2 clearfix">
      <label><?php echo $text_label_cart_position; ?></label>
      <select name="common[cart_menu_position]">
        <option value="right"<?php if($common['cart_menu_position'] == 'right') echo ' selected="selected"';?>><?php echo $text_opt_cart_position_1; ?></option>
        <option value="above"<?php if($common['cart_menu_position'] == 'above') echo ' selected="selected"';?>><?php echo $text_opt_cart_position_2; ?></option>
      </select>
    </div>

    <div class="s_row_2 clearfix">
      <label for="show_cart_label_yes"><?php echo $text_label_cart_label; ?></label>
      <input type="hidden" name="common[show_cart_label]" value="0" />
      <input id="show_cart_label_yes" class="tb_toggle" type="checkbox" name="common[show_cart_label]" value="1"<?php if($common['show_cart_label'] == '1') echo ' checked="checked"';?> />
    </div>

    <div class="s_row_2 clearfix">
      <label><?php echo $text_label_border_type; ?></label>
      <select name="common[border_type]">
        <option value="0"<?php if($common['border_type'] == '0') echo ' selected="selected"';?>><?php echo $text_opt_border_type_0; ?></option>
        <option value="1"<?php if($common['border_type'] == '1') echo ' selected="selected"';?>><?php echo $text_opt_border_type_1; ?></option>
        <option value="2"<?php if($common['border_type'] == '2') echo ' selected="selected"';?>><?php echo $text_opt_border_type_2; ?></option>
        <option value="3"<?php if($common['border_type'] == '3') echo ' selected="selected"';?>><?php echo $text_opt_border_type_3; ?></option>
        <option value="4"<?php if($common['border_type'] == '4') echo ' selected="selected"';?>><?php echo $text_opt_border_type_4; ?></option>
        <option value="5"<?php if($common['border_type'] == '5') echo ' selected="selected"';?>><?php echo $text_opt_border_type_5; ?></option>
        <option value="6"<?php if($common['border_type'] == '6') echo ' selected="selected"';?>><?php echo $text_opt_border_type_6; ?></option>
        <option value="7"<?php if($common['border_type'] == '7') echo ' selected="selected"';?>><?php echo $text_opt_border_type_7; ?></option>
        <option value="8"<?php if($common['border_type'] == '8') echo ' selected="selected"';?>><?php echo $text_opt_border_type_8; ?></option>
        <option value="9"<?php if($common['border_type'] == '9') echo ' selected="selected"';?>><?php echo $text_opt_border_type_9; ?></option>
      </select>
    </div>
      </div>

  <div id="color_settings_tab">
    <h2><span><?php echo $text_title_design_colors; ?></span></h2>
    <div id="schemer_form_rows">
      <?php require 'theme_design_schemer.tpl'; ?>
    </div>
    <a id="launch_color_schemer_button" class="s_button s_button_2 s_button_green s_ml_10 s_mt_5 left" href="<?php echo $tbUrl->generate('schemer/showCatalogSchemer'); ?>" target="_blank"><?php echo $text_button_launch_color_schemer; ?></a>
  </div>

  <div id="typography_settings_tab">
  </div>

  <div id="product_settings_tab">

    <h2><?php echo $text_title_design_product; ?></h2>

    <div class="s_row_2 first clearfix">
      <label><?php echo $text_label_listing_type; ?></label>
      <select name="common[product_listing_type]">
        <option value="grid"<?php if($common['product_listing_type'] == 'grid') echo ' selected="selected"';?>><?php echo $text_opt_listing_type_1; ?></option>
        <option value="list"<?php if($common['product_listing_type'] == 'list') echo ' selected="selected"';?>><?php echo $text_opt_listing_type_2; ?></option>
      </select>
    </div>

    <div class="s_row_2 clearfix">
      <label><?php echo $text_label_products_cols; ?></label>
      <select name="common[products_per_row]">
        <option value="size_1"<?php if($common['products_per_row'] == 'size_1') echo ' selected="selected"';?>><?php echo $text_opt_products_cols_1; ?></option>
        <option value="size_2"<?php if($common['products_per_row'] == 'size_2') echo ' selected="selected"';?>><?php echo $text_opt_products_cols_2; ?></option>
      </select>
    </div>

    <div class="s_row_2 clearfix">
      <label><?php echo $text_label_show_subcategory; ?></label>
      <input type="hidden" name="common[subcategories_enabled]" value="0" />
      <input id="input_common_subcategories_enabled" type="checkbox" name="common[subcategories_enabled]" value="1"<?php if($common['subcategories_enabled'] == '1') echo ' checked="checked"';?> />
    </div>

    <div class="s_row_2 clearfix" id="common_subcategories_style">
      <label><?php echo $text_label_subcategory; ?></label>
      <select name="common[subcategories_style]">
        <option value="thumbs"<?php if($common['subcategories_style'] == 'thumbs') echo ' selected="selected"';?>><?php echo $text_opt_subcategory_1; ?></option>
        <option value="list"<?php if($common['subcategories_style'] == 'list') echo ' selected="selected"';?>><?php echo $text_opt_subcategory_2; ?></option>
      </select>
    </div>

    <div class="s_row_2 clearfix" id="subcategories_count_enabled">
      <label><?php echo $text_label_subcategory_count; ?></label>
      <input type="hidden" name="common[subcategories_count_enabled]" value="0" />
      <input class="tb_toggle" type="checkbox" name="common[subcategories_count_enabled]" value="1"<?php if($common['subcategories_count_enabled'] == '1') echo ' checked="checked"';?> />
    </div>

    <div class="s_row_2 clearfix">
      <label><?php echo $text_label_product_gallery_position; ?></label>
      <select name="common[product_gallery_position]" id="common_product_gallery_position">
        <option value="tab"<?php if($common['product_gallery_position'] == 'tab') echo ' selected="selected"';?>><?php echo $text_opt_product_gallery_position_1; ?></option>
        <option value="under_preview"<?php if($common['product_gallery_position'] == 'under_preview') echo ' selected="selected"';?>><?php echo $text_opt_product_gallery_position_2; ?></option>
      </select>
    </div>

    <div class="s_row_2 clearfix common_product_gallery_type">
      <label><?php echo $text_label_product_gallery_type; ?></label>
      <select name="common[product_gallery_type]" id="common_product_gallery_type">
        <option value="prettyphoto"<?php if($common['product_gallery_type'] == 'prettyphoto') echo ' selected="selected"';?>><?php echo $text_opt_product_gallery_type_1; ?></option>
        <option value="cloudzoom"<?php if($common['product_gallery_type'] == 'cloudzoom') echo ' selected="selected"';?>><?php echo $text_opt_product_gallery_type_2; ?></option>
      </select>
    </div>

    <div class="s_row_2 clearfix common_zoom_position"<?php if($common['product_gallery_type'] == 'prettyphoto'): ?> style="display: none;"<?php endif; ?>>
      <label><?php echo $text_label_product_zoom_position; ?></label>
      <select name="common[product_zoom_position]" id="common_zoom_position">
        <option value="right"<?php if($common['product_zoom_position'] == 'right') echo ' selected="selected"';?>><?php echo $text_opt_product_zoom_position_1; ?></option>
        <option value="inside"<?php if($common['product_zoom_position'] == 'inside') echo ' selected="selected"';?>><?php echo $text_opt_product_zoom_position_2; ?></option>
      </select>
    </div>

    <script type="text/javascript">
      $("#common_product_gallery_type").bind("change", function() {
        if ($(this).val() == 'cloudzoom') {
          $("#common_zoom_position").parents("div.common_zoom_position:first").show();
        } else {
          $("#common_zoom_position").parents("div.common_zoom_position:first").hide();
        }
      });
    </script>

    <div class="s_row_2 clearfix">
      <label><?php echo $text_price; ?></label>
      <div class="s_full tb_2col_wrap clearfix">
        <div class="s_row_1 tb_col tb_5_12 clearfix">
          <label><?php echo $text_label_design; ?></label>
          <div class="s_full clearfix">
            <select name="common[price_design]">
              <option value="plain"<?php if($common['price_design'] == 'plain') echo ' selected="selected"';?>><?php echo $text_opt_price_design_1; ?></option>
              <option value="label"<?php if($common['price_design'] == 'label') echo ' selected="selected"';?>><?php echo $text_opt_price_design_2; ?></option>
            </select>
          </div>
        </div>
        <div class="s_row_1 tb_col tb_5_12 clearfix">
          <label><?php echo $text_size; ?></label>
          <div class="s_full clearfix">
            <select name="common[price_size]">
              <option value="3"<?php if($common['price_size'] == '3') echo ' selected="selected"';?>><?php echo $text_large; ?></option>
              <option value="2"<?php if($common['price_size'] == '2') echo ' selected="selected"';?>><?php echo $text_middle; ?></option>
              <option value="1"<?php if($common['price_size'] == '1') echo ' selected="selected"';?>><?php echo $text_small; ?></option>
            </select>
          </div>
        </div>
      </div>
    </div>

  </div>

  <div id="background_settings_tab">
    <h2><span><?php echo $text_title_design_background; ?></span></h2>

    <table id="background_settings_table" class="s_table" width="100%" cellpadding="0" cellspacing="0" border="0">
      <thead>
        <tr>
          <td width="100"><?php echo $text_image; ?></td>
          <td><?php echo $text_tr_background_settings; ?></td>
          <td width="30"></td>
        </tr>
      </thead>
      <tbody>
        <?php $background_row = 0; ?>
        <?php foreach ($background_images as $background): ?>
        <tr id="background_row<?php echo $background_row; ?>">
          <td>
            <input type="hidden" name="background[images][<?php echo $background_row; ?>][id]" value="<?php echo $background['id']; ?>" />
            <input type="hidden" name="background[images][<?php echo $background_row; ?>][image]" value="<?php echo $background['image']; ?>" id="background_image<?php echo $background_row; ?>"  />
            <img src="<?php echo $background['preview']; ?>" alt="" id="background_preview<?php echo $background_row; ?>" class="image" onclick="image_upload('background_image<?php echo $background_row; ?>', 'background_preview<?php echo $background_row; ?>');" />
          </td>
          <td>
            <input type="text" name="background[images][<?php echo $background_row; ?>][name]" value="<?php echo $background['name']; ?>" style="width: 98%;" />
            <span class="s_mb_10 clear"></span>
            <div class="left first">
              <label for="background_row<?php echo $background_row; ?>_position"><?php echo $text_position; ?></label>
              <select id="background_row<?php echo $background_row; ?>_position" name="background[images][<?php echo $background_row; ?>][position]">
                <option value="top left"<?php if ($background['position'] == 'top left') echo ' selected="selected"'; ?>><?php echo $text_opt_position_1; ?></option>
                <option value="top center"<?php if ($background['position'] == 'top center') echo ' selected="selected"'; ?>><?php echo $text_opt_position_2; ?></option>
                <option value="top right"<?php if ($background['position'] == 'top right') echo ' selected="selected"'; ?>><?php echo $text_opt_position_3; ?></option>
                <option value="right"<?php  if ($background['position'] == 'right') echo ' selected="selected"'; ?>><?php echo $text_opt_position_4; ?></option>
                <option value="bottom right"<?php if ($background['position'] == 'bottom right') echo ' selected="selected"'; ?>><?php echo $text_opt_position_5; ?></option>
                <option value="bottom center"<?php if ($background['position'] == 'bottom center') echo ' selected="selected"'; ?>><?php echo $text_opt_position_6; ?></option>
                <option value="bottom left"<?php if ($background['position'] == 'bottom left') echo ' selected="selected"'; ?>><?php echo $text_opt_position_7; ?></option>
                <option value="left"<?php  if ($background['position'] == 'left') echo ' selected="selected"'; ?>><?php echo $text_opt_position_8; ?></option>
                <option value="center"<?php  if ($background['position'] == 'center') echo ' selected="selected"'; ?>><?php echo $text_opt_position_9; ?></option>
              </select>
            </div>
            <div class="left">
              <label for="background_row<?php echo $background_row; ?>_repeat"><?php echo $text_repeat; ?></label>
              <select id="background_row<?php echo $background_row; ?>_repeat" name="background[images][<?php echo $background_row; ?>][repeat]">
                <option value="no-repeat"<?php if ($background['repeat'] == 'no-repeat') echo ' selected="selected"'; ?>><?php echo $text_opt_repeat_1; ?></option>
                <option value="repeat-x"<?php if ($background['repeat'] == 'repeat-x') echo ' selected="selected"'; ?>><?php echo $text_opt_repeat_3; ?></option>
                <option value="repeat-y"<?php if ($background['repeat'] == 'repeat-y') echo ' selected="selected"'; ?>><?php echo $text_opt_repeat_4; ?></option>
                <option value="repeat"<?php if ($background['repeat'] == 'repeat') echo ' selected="selected"'; ?>><?php echo $text_opt_repeat_2; ?></option>
              </select>
            </div>
            <div class="left">
              <label for="background_row<?php echo $background_row; ?>_attachment"><?php echo $text_attachment; ?></label>
              <select id="background_row<?php echo $background_row; ?>_attachment" name="background[images][<?php echo $background_row; ?>][attachment]">
                <option value="scroll"<?php if ($background['attachment'] == 'scroll') echo ' selected="selected"'; ?>><?php echo $text_opt_attachment_1; ?></option>
                <option value="fixed"<?php if ($background['attachment'] == 'fixed') echo ' selected="selected"'; ?>><?php echo $text_opt_attachment_2; ?></option>
              </select>
            </div>
          </td>
          <td><a onclick="$('#background_row<?php echo $background_row; ?>').remove();" class="s_button_close"><?php echo $text_remove; ?></a></td>
        </tr>
        <?php $background_row++; ?>
        <?php endforeach; ?>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="3"><a onclick="addBackground();" class="s_button s_button_2 s_button_green right s_mr_0"><?php echo $text_button_add_image; ?></a></td>
        </tr>
      </tfoot>
    </table>

  </div>

  <div id="custom_css_tab">
    <h2><?php echo $text_title_design_custom_css; ?></h2>

    <div class="s_row_3 first clearfix">
        <div class="s_full">
        <textarea name="custom_stylesheet" rows="19"><?php echo $custom_stylesheet; ?></textarea>
      </div>
    </div>

  </div>

</div>

<div class="s_submit clearfix">
  <a class="s_button" onclick="$('#form').submit();"><span class="s_icon_16"><span class="s_icon s_tick_16"></span><?php echo $text_button_save_settings; ?></span></a>
</div>


<script type="text/javascript" src="<?php echo $theme_admin_javascript_url; ?>/colorpicker/js/colorpicker.js"></script>
<link rel="stylesheet" type="text/css" href="<?php echo $theme_admin_javascript_url; ?>/colorpicker/css/colorpicker.css" media="all" />
<script type="text/javascript">

$("#input_common_subcategories_enabled").iButton({
    change: function ($input){
      if ($input.is(":checked")) {
        $("#common_subcategories_style").show("slow");
        $("#subcategories_count_enabled").show("slow");
      } else {
        $("#common_subcategories_style").hide("slow");
        $("#subcategories_count_enabled").hide("slow");
      }
    }
  })
  .trigger("change");

function bindColorPickers() {
  $('#color_settings_tab .colorSelector').each(function() {

    var $el = $(this);

    $el.ColorPicker({
      color: '#0000ff',
      onShow: function (colpkr) {

        if ($("#schemer_predefined_scheme").val() != "custom") {
          $("#schemer_predefined_scheme").val("custom");
          $.uniform.update("#schemer_predefined_scheme");
        }

        $(colpkr).fadeIn(500);
        $(this).ColorPickerSetColor($el.next("input").val());

        return false;
      },
      onHide: function (colpkr) {

        if ($("#schemer_predefined_scheme").val() != "custom") {
          $("#schemer_predefined_scheme").val("custom");
          $.uniform.update("#schemer_predefined_scheme");
        }

        $(colpkr).fadeOut(500);
        $el.next("input").val($(colpkr).data('colorpicker').fields.eq(0).val());

        return false;
      },
      onChange: function (hsb, hex, rgb) {
        $el.find('div').css('backgroundColor', '#' + hex);
      }
    });
  });
}

function unBindColorPickers() {
  $('#color_settings_tab .colorSelector').each(function() {
    var colorpicker_id = $(this).data('colorpickerId');
    $("#" + colorpicker_id).remove();
  });
}


$(document).ready(function(){

  $('#design_settings_tabs').tbTabs({
    cookie: {
      expires: 2000,
      name: "tbmenudesigntabs"
    },
    cache: true
  });

  bindColorPickers();
  var colorsData = jQuery.parseJSON($("#colors_data").val());

  $("#tb_cp_content_wrap").delegate("#schemer_predefined_scheme", "change", function() {
    themeData = colorsData[$(this).val()];

    $('#color_settings_tab .colorSelector').each(function() {
      var data_name = $(this).attr("name");
      var colorpickerId = $(this).data("colorpickerId");

      $(this).ColorPickerSetColor(themeData[data_name]);
      $("#" + colorpickerId).find("input").trigger("change");
      $(this).next("input").val($("#" + colorpickerId).find("div.colorpicker_hex input").val());
    });
  });

  $("#tb_cp_content_wrap").delegate("#schemer_categories", "change", function() {
    $("#schemer_form_rows").block({ message: "<h1>Loading...</h1>" });
    unBindColorPickers();
    $("#schemer_form_rows").load($(this).val(), function() {
      $("#schemer_form_rows select").uniform();
      bindColorPickers();
      $("#schemer_form_rows").unblock();
    });
    return false;
  });

});

var background_row = <?php echo $background_row; ?>;
function addBackground() {
  var html = '<tr id="background_row' + background_row + '">';
  html += '<td><input type="hidden" name="background[images][' + background_row + '][id]" value="' + guidGenerator() + '" /><input type="hidden" name="background[images][' + background_row + '][image]" value="" id="background_image' + background_row + '" /><img src="<?php echo $no_image; ?>" alt="" id="background_preview' + background_row + '" class="image" onclick="image_upload(\'background_image' + background_row + '\', \'background_preview' + background_row + '\');" /></td>';
  html += '<td><input type="text" name="background[images][' + background_row + '][name]" value="' + 'background_' + background_row + '" style="width: 98%;" />';
  html += '<span class="s_mb_10 clear"></span>';
  html += '<div class="left first"><label for="background_row' + background_row + '_position"><?php echo $text_position; ?></label><select id="background_row' + background_row + '_position" name="background[images][' + background_row + '][position]"><option value="top left"><?php echo $text_opt_position_1; ?></option><option value="top center"><?php echo $text_opt_position_2; ?></option><option value="top right"><?php echo $text_opt_position_3; ?></option><option value="right center"><?php echo $text_opt_position_4; ?></option><option value="bottom right"><?php echo $text_opt_position_5; ?></option><option value="bottom"><?php echo $text_opt_position_6; ?></option><option value="bottom left"><?php echo $text_opt_position_7; ?></option><option value="left center"><?php echo $text_opt_position_8; ?></option><option value="center"><?php echo $text_opt_position_9; ?></option></select></div>';
  html += '<div class="left"><label for="background_row' + background_row + '_repeat"><?php echo $text_repeat; ?></label><select id="background_row' + background_row + '_repeat" name="background[images][' + background_row + '][repeat]"><option value="no-repeat"><?php echo $text_opt_repeat_1; ?></option><option value="repeat-x"><?php echo $text_opt_repeat_3; ?></option><option value="repeat-y"><?php echo $text_opt_repeat_4; ?></option><option value="repeat"><?php echo $text_opt_repeat_2; ?></option></select></div>';
  html += '<div class="left"><label for="background_row' + background_row + '_attachment"><?php echo $text_attachment; ?></label><select id="background_row' + background_row + '_attachment" name="background[images][' + background_row + '][attachment]"><option value="scroll"><?php echo $text_opt_attachment_1; ?></option><option value="fixed"><?php echo $text_opt_attachment_2; ?></option></select></div>';
  html += '</td>';
  html += '<td><a onclick="$(\'#background_row' + background_row  + '\').remove();" class="s_button_close"><?php echo $text_remove; ?></a></td>';
  html += '</tr>';

  $("#background_settings_table > tbody").append(html);
  var row_selector = '#background_row' + background_row + ' select';
  $(row_selector).uniform();
  background_row++;
}

</script>
