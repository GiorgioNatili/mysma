<script type="text/javascript" src="<?php echo $tbData->theme_javascript_url; ?>colorpicker/js/colorpicker.js"></script>
<link rel="stylesheet" type="text/css" href="<?php echo $tbData->theme_javascript_url; ?>colorpicker/css/colorpicker.css" media="all" />
<link rel="stylesheet" href="<?php echo $tbData->theme_stylesheet_url; ?>cp.css" type="text/css" />

<div id="tb_cp_open">
  <a href="javascript:;"></a>
</div>
<div id="tb_cp" style="display: none;">
  <a id="tb_cp_close" href="javascript:;"></a>
  <span id="tb_cp_title">Control Panel</span>
  <div id="tb_cp_wrapper">
    <form name="tb" action="<?php echo $this->url->link('tb/saveSchemer'); ?>" method="post">
      <input type="hidden" id="colors_data" value='<?php echo $schemer_json; ?>' />
      <input type="hidden" id="fonts_data" value='<?php echo json_encode($google_font_list); ?>' />
      <input type="hidden" name="schemer[colors][plain_price_text]" value="<?php echo isset($schemer['colors']['plain_price_text']) ?  $schemer['colors']['plain_price_text'] : '000000' ?>" />
      <input type="hidden" name="schemer[colors][plain_promo_price_text]" value="<?php echo isset($schemer['colors']['plain_promo_price_text']) ? $schemer['colors']['plain_promo_price_text'] : 'ff3000' ?>" />
      <div class="s_accordion">
        <h3>Theme colors</h3>
        <div id="tb_cp_theme_colors" class="s_panel_section">
          <div class="s_cp_row clearfix">
            <label><strong>Category:</strong></label>
            <span class="clear"></span>
            <select id="modify_theme_categories" name="schemer[path]">
              <option value="<?php echo $category_id != 0 ? HTTP_SERVER . 'index.php?route=common/home' : 0; ?>">*Global*</option>
              <?php foreach ($categories as $category): ?>
              <?php if ($category['category_id'] == $category_id): ?>
              <option value="<?php echo $category['path']; ?>" selected="selected"><?php echo str_repeat('--', $category['level']) . ' ' . $category['name']; ?></option>
              <?php else: ?>
              <option value="<?php echo $this->url->link('product/category', 'path=' . $category['path']); ?>"><?php echo str_repeat('--', $category['level']) . ' ' . $category['name']; ?></option>
              <?php endif; ?>
              <?php endforeach; ?>
            </select>
          </div>
          <div class="s_cp_row clearfix">
            <label><strong>Color scheme:</strong></label>
            <span class="clear"></span>
            <div id="prefedined_themes">
              <?php $already_selected = false; ?>
              <select id="schemer_predefined_scheme" name="schemer[predefined_scheme]">
                  <?php if ($category_id != 0): ?>
                  <option value="parent"<?php if($schemer['is_parent'] == 1) { echo ' selected="selected"'; $already_selected = true; } ?>><?php echo "Inherit `{$schemer['parent_name']}` ("; if ($schemer['parent_scheme'] != 'custom') echo $schemer['parent_scheme']; else echo 'custom';?>)</option>
                  <?php endif; ?>
                  <option value="custom"<?php if($schemer['predefined_scheme'] == "custom" && $schemer['is_parent'] == 0) { echo ' selected="selected"'; $already_selected = true; } ?>>custom</option>
                <?php foreach ($predefined_schemes as $name => $settings): ?>
                  <?php if (($name == $schemer['predefined_scheme']) && !$already_selected): ?>
                  <option value="<?php echo $name; ?>" selected="selected"><?php echo $name; ?></option>
                  <?php else: ?>
                  <option value="<?php echo $name; ?>"><?php echo $name; ?></option>
                  <?php endif; ?>
                <?php endforeach; ?>
              </select>
            </div>
          </div>
          <div class="s_cp_row clearfix">
            <label>Main color:</label>
            <div id="mainColorSelector" class="colorSelector" name="main">
              <div style="background-color: #<?php echo $schemer['colors']['main'] ?>"></div>
            </div>
            <input class="s_color" type="hidden" name="schemer[colors][main]" value="<?php echo $schemer['colors']['main'] ?>" />
          </div>
          <div class="s_cp_row clearfix">
            <label>Secondary color:</label>
            <div id="secondaryColorSelector" class="colorSelector" name="secondary">
              <div style="background-color: #<?php echo $schemer['colors']['secondary'] ?>"></div>
            </div>
            <input class="s_color" type="hidden" name="schemer[colors][secondary]" value="<?php echo $schemer['colors']['secondary'] ?>" />
          </div>
          <div class="s_cp_row clearfix">
            <label>Intro:</label>
            <div id="introColorSelector" class="colorSelector" name="intro">
              <div style="background-color: #<?php echo $schemer['colors']['intro'] ?>"></div>
            </div>
            <input class="s_color" type="hidden" name="schemer[colors][intro]" value="<?php echo $schemer['colors']['intro'] ?>" />
          </div>
          <div class="s_cp_row clearfix">
            <label>Intro text:</label>
            <div id="introTextColorSelector" class="colorSelector" name="intro_text">
              <div style="background-color: #<?php echo $schemer['colors']['intro_text'] ?>"></div>
            </div>
            <input class="s_color" type="hidden" name="schemer[colors][intro_text]" value="<?php echo $schemer['colors']['intro_text'] ?>" />
          </div>
          <div class="s_cp_row clearfix">
            <label>Intro title:</label>
            <div id="introTitleColorSelector" class="colorSelector" name="intro_title">
              <div style="background-color: #<?php echo $schemer['colors']['intro_title'] ?>"></div>
            </div>
            <input class="s_color" type="hidden" name="schemer[colors][intro_title]" value="<?php echo $schemer['colors']['intro_title'] ?>" />
          </div>
          <div class="s_cp_row clearfix">
            <label>Price:</label>
            <div id="priceColorSelector" class="colorSelector" name="price">
              <div style="background-color: #<?php echo $schemer['colors']['price'] ?>"></div>
            </div>
            <input class="s_color" type="hidden" name="schemer[colors][price]" value="<?php echo $schemer['colors']['price'] ?>" />
          </div>
          <div class="s_cp_row clearfix">
            <label>Price text:</label>
            <div id="priceTextColorSelector" class="colorSelector" name="price_text">
              <div style="background-color: #<?php echo $schemer['colors']['price_text'] ?>"></div>
            </div>
            <input class="s_color" type="hidden" name="schemer[colors][price_text]" value="<?php echo $schemer['colors']['price_text'] ?>" />
          </div>
          <div class="s_cp_row clearfix">
            <label>Promo price:</label>
            <div id="promoPriceColorSelector" class="colorSelector" name="promo_price">
              <div style="background-color: #<?php echo $schemer['colors']['promo_price'] ?>"></div>
            </div>
            <input class="s_color" type="hidden" name="schemer[colors][promo_price]" value="<?php echo $schemer['colors']['promo_price'] ?>" />
          </div>
          <div class="s_cp_row clearfix">
            <label>Promo price text:</label>
            <div id="promoPriceTextColorSelector" class="colorSelector" name="promo_price_text">
              <div style="background-color: #<?php echo $schemer['colors']['promo_price_text'] ?>"></div>
            </div>
            <input class="s_color" type="hidden" name="schemer[colors][promo_price_text]" value="<?php echo $schemer['colors']['promo_price_text'] ?>" />
          </div>
          <div class="s_cp_row clearfix"<?php if($tbData->common['layout_type'] != 'fixed') echo ' style="display:none"';?>>
            <label>Body background:</label>
            <div id="backgroundColorSelector" class="colorSelector" name="background">
              <div style="background-color: #<?php echo $schemer['colors']['background'] ?>"></div>
            </div>
            <input class="s_color" type="hidden" name="schemer[colors][background]" value="<?php echo $schemer['colors']['background'] ?>" />
          </div>

          <div class="s_cp_row clearfix">
            <label>Texture:</label>
            <select id="textureSelector" class="right" style="width: 90px; margin-right: 0;" name="schemer[colors][texture]">
              <optgroup label="Default">
                <option value="texture_1"<?php if($schemer['colors']['texture'] == 'texture_1') echo ' selected="selected"';?>>Squares</option>
                <option value="texture_2"<?php if($schemer['colors']['texture'] == 'texture_2') echo ' selected="selected"';?>>Noise</option>
                <option value="texture_3"<?php if($schemer['colors']['texture'] == 'texture_3') echo ' selected="selected"';?>>Rough</option>
                <option value="no_texture"<?php if($schemer['colors']['texture'] == 'no_texture') echo ' selected="selected"';?>>No texture</option>
              </optgroup>
              <?php if ($backgrounds): ?>
              <optgroup label="Custom">
                <?php foreach ($backgrounds as $background): ?>
                <option value="<?php echo $background['id']; ?>"<?php if($schemer['colors']['texture'] == $background['id']) echo ' selected="selected"';?>><?php echo $background['name']; ?></option>
                <?php endforeach; ?>
              </optgroup>
              <?php endif; ?>
            </select>
          </div>
        </div>

        <h3>Theme fonts</h3>
        <div id="tb_cp_theme_fonts" class="s_panel_section">
          <div class="s_cp_row clearfix">
            <label><strong>Body font</strong></label>
            <select name="font[body_family]" class="fontname" changing_element="body">
              <option value="default"<?php if ($font['body_family'] == 'default') echo ' selected="selected"'; ?>>Theme Default</option>
              <optgroup label="Built-in Fonts" type="built">
                <?php foreach ($built_font_families as $name): ?>
                <option value="<?php echo $name; ?>"<?php if ($font['body_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
                <?php endforeach; ?>
              </optgroup>
              <optgroup label="Google Fonts" type="google">
                <?php foreach ($google_font_families as $name): ?>
                <option value="<?php echo $name; ?>"<?php if ($font['body_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
                <?php endforeach; ?>
              </optgroup>
            </select>
            <input type="hidden" name="font[body_type]" value="<?php echo $font['body_type']; ?>" />
            <input type="hidden" name="font[body_variant]" value="<?php echo $font['body_variant']; ?>" />
            <input type="hidden" name="font[body_subsets]" value="<?php echo $font['body_subsets']; ?>" />
          </div>
          <div class="s_cp_row clearfix">
            <label><strong>Navigation font</strong></label>
            <select name="font[navigation_family]" class="fontname inline" style="width: 66%;" changing_element="navigation">
              <option value="default"<?php if ($font['navigation_family'] == 'default') echo ' selected="selected"'; ?>>Theme Default</option>
              <optgroup label="Built-in Fonts" type="built">
                <?php foreach ($built_font_families as $name): ?>
                <option value="<?php echo $name; ?>"<?php if ($font['navigation_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
                <?php endforeach; ?>
              </optgroup>
              <optgroup label="Google Fonts" type="google">
                <?php foreach ($google_font_families as $name): ?>
                <option value="<?php echo $name; ?>"<?php if ($font['navigation_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
                <?php endforeach; ?>
              </optgroup>
            </select>
            <select class="inline" name="font[navigation_size]" style="width: 30%;" changing_element="navigation">
              <?php foreach (range(12, 24) as $size): ?>
              <option value="<?php echo $size; ?>"<?php if ($font['navigation_size'] == $size) echo ' selected="selected"'; ?>><?php echo $size; ?>px</option>
              <?php endforeach; ?>
            </select>
            <input type="hidden" name="font[navigation_type]" value="<?php echo $font['navigation_type']; ?>" />
            <input type="hidden" name="font[navigation_variant]" value="<?php echo $font['navigation_variant']; ?>" />
            <input type="hidden" name="font[navigation_subsets]" value="<?php echo $font['navigation_subsets']; ?>" />
          </div>
          <div class="s_cp_row clearfix">
            <label><strong>Intro font</strong></label>
            <select name="font[intro_family]" class="fontname inline" style="width: 66%;" changing_element="intro">
              <option value="default"<?php if ($font['intro_family'] == 'default') echo ' selected="selected"'; ?>>Theme Default</option>
              <optgroup label="Built-in Fonts" type="built">
                <?php foreach ($built_font_families as $name): ?>
                <option value="<?php echo $name; ?>"<?php if ($font['intro_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
                <?php endforeach; ?>
              </optgroup>
              <optgroup label="Google Fonts" type="google">
                <?php foreach ($google_font_families as $name): ?>
                <option value="<?php echo $name; ?>"<?php if ($font['intro_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
                <?php endforeach; ?>
              </optgroup>
            </select>
            <select class="inline" name="font[intro_size]" style="width: 30%;" changing_element="intro">
              <?php foreach (range(24, 38) as $size): ?>
              <option value="<?php echo $size; ?>"<?php if ($font['intro_size'] == $size) echo ' selected="selected"'; ?>><?php echo $size; ?>px</option>
              <?php endforeach; ?>
            </select>
            <input type="hidden" name="font[intro_type]" value="<?php echo $font['intro_type']; ?>" />
            <input type="hidden" name="font[intro_variant]" value="<?php echo $font['intro_variant']; ?>" />
            <input type="hidden" name="font[intro_subsets]" value="<?php echo $font['intro_subsets']; ?>" />
          </div>
          <div class="s_cp_row clearfix">
            <label><strong>Title font</strong></label>
            <select name="font[title_family]" class="fontname" changing_element="title">
              <option value="default"<?php if ($font['title_family'] == 'default') echo ' selected="selected"'; ?>>Theme Default</option>
              <optgroup label="Built-in Fonts" type="built">
                <?php foreach ($built_font_families as $name): ?>
                <option value="<?php echo $name; ?>"<?php if ($font['title_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
                <?php endforeach; ?>
              </optgroup>
              <optgroup label="Google Fonts" type="google">
                <?php foreach ($google_font_families as $name): ?>
                <option value="<?php echo $name; ?>"<?php if ($font['title_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
                <?php endforeach; ?>
              </optgroup>
            </select>
            <input type="hidden" name="font[title_type]" value="<?php echo $font['title_type']; ?>" />
            <input type="hidden" name="font[title_variant]" value="<?php echo $font['title_variant']; ?>" />
            <input type="hidden" name="font[title_subsets]" value="<?php echo $font['title_subsets']; ?>" />
          </div>
          <div class="s_cp_row clearfix">
            <label><strong>Price font</strong></label>
            <select name="font[price_family]" class="fontname" changing_element="price">
              <option value="default"<?php if ($font['price_family'] == 'default') echo ' selected="selected"'; ?>>Theme Default</option>
              <optgroup label="Built-in Fonts" type="built">
                <?php foreach ($built_font_families as $name): ?>
                <option value="<?php echo $name; ?>"<?php if ($font['price_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
                <?php endforeach; ?>
              </optgroup>
              <optgroup label="Google Fonts" type="google">
                <?php foreach ($google_font_families as $name): ?>
                <option value="<?php echo $name; ?>"<?php if ($font['price_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
                <?php endforeach; ?>
              </optgroup>
            </select>
            <input type="hidden" name="font[price_type]" value="<?php echo $font['price_type']; ?>" />
            <input type="hidden" name="font[price_variant]" value="<?php echo $font['price_variant']; ?>" />
            <input type="hidden" name="font[price_subsets]" value="<?php echo $font['price_subsets']; ?>" />
          </div>
          <div class="s_cp_row clearfix">
            <label><strong>Button font</strong></label>
            <select name="font[button_family]" class="fontname inline" style="width: 66%;" changing_element="button">
              <option value="default"<?php if ($font['button_family'] == 'default') echo ' selected="selected"'; ?>>Theme Default</option>
              <optgroup label="Built-in Fonts" type="built">
                <?php foreach ($built_font_families as $name): ?>
                <option value="<?php echo $name; ?>"<?php if ($font['button_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
                <?php endforeach; ?>
              </optgroup>
              <optgroup label="Google Fonts" type="google">
                <?php foreach ($google_font_families as $name): ?>
                <option value="<?php echo $name; ?>"<?php if ($font['button_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
                <?php endforeach; ?>
              </optgroup>
            </select>
            <select class="inline" name="font[button_size]" style="width: 30%;" changing_element="button">
              <?php foreach (range(12, 24) as $size): ?>
              <option value="<?php echo $size; ?>"<?php if ($font['button_size'] == $size) echo ' selected="selected"'; ?>><?php echo $size; ?>px</option>
              <?php endforeach; ?>
            </select>
            <input type="hidden" name="font[button_type]" value="<?php echo $font['button_type']; ?>" />
            <input type="hidden" name="font[button_variant]" value="<?php echo $font['button_variant']; ?>" />
            <input type="hidden" name="font[button_subsets]" value="<?php echo $font['button_subsets']; ?>" />
          </div>
        </div>
      </div>

      <div class="s_submit">
        <button class="right" type="submit"><span class="s_icon_10"><span class="s_icon s_save_10"></span>Save</span></button>
        <a id="button_remove_color_schemer" href="<?php echo $this->url->link('tb/removeSchemer'); ?>">Remove schemer</a>
      </div>

    </form>
  </div>
</div>

<script src="http<?php if($tbData->isHTTPS) echo 's'?>://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js"></script>
<script type="text/javascript">

  jQuery.loadCSS = function(url) {
    var fileref = document.createElement("link");
    fileref.setAttribute("rel", "stylesheet");
    fileref.setAttribute("type", "text/css");
    fileref.setAttribute("media", "screen");
    fileref.setAttribute("href", url);

    document.getElementsByTagName("head")[0].appendChild(fileref);
  };

  var fontsData = jQuery.parseJSON($("#fonts_data").val());

  function reloadFontsCss(changing_element) {
    var css_body   				= $('#tb_cp_theme_fonts select[name*="body_family"]').val();
    var css_nav    				= $('#tb_cp_theme_fonts select[name*="navigation_family"]').val();
    var css_nav_size    	= $('#tb_cp_theme_fonts select[name*="navigation_size"]').val();
    var css_intro  				= $('#tb_cp_theme_fonts select[name*="intro_family"]').val();
    var css_intro_size  	= $('#tb_cp_theme_fonts select[name*="intro_size"]').val();
    var css_title  				= $('#tb_cp_theme_fonts select[name*="title_family"]').val();
    var css_price  				= $('#tb_cp_theme_fonts select[name*="price_family"]').val();
    var css_button 				= $('#tb_cp_theme_fonts select[name*="button_family"]').val();
    var css_button_size 	= $('#tb_cp_theme_fonts select[name*="button_size"]').val();

    var css_url = $sReg.get('/tb/theme_stylesheet_url') + 'schemer_fonts.css.php?body=' + css_body + '&nav=' + css_nav + '&nav_size=' + css_nav_size + '&intro=' + css_intro + '&intro_size=' + css_intro_size + '&title=' + css_title + '&price=' + css_price + '&button=' + css_button + '&button_size=' + css_button_size + '&changing=' + changing_element;
    $.loadCSS(css_url);
  }

  $("#tb_cp_theme_fonts select.fontname").bind("change", function() {
    var el = $(this);
    var div_parent = el.parents("div:first");
    var font_type = el.find(":selected").parent("optgroup").attr("type");

    reloadFontsCss(el.attr("changing_element"));

    if (typeof font_type == "undefined") {
      div_parent.find('input[name*="_type"]:hidden').val("default");
      div_parent.find('input[name*="_variant"]:hidden').val("");
      div_parent.find('input[name*="_subsets"]:hidden').val("");

      return false;
    }

    div_parent.find('input[name*="_type"]:hidden').val(font_type);

    if (font_type == "google") {
      var font_family = el.find(":selected").val();
      var font_object = fontsData[font_family];
      var subsets = font_object.subsets.join(",");
      if (el.is('[name*="body_family"]')) {
        var variants = $.map(font_object.variants, function(value, key) {
          return key;
        }).join(",");
      } else {
        var variants = $.map(font_object.variants, function(value, key) {
          if (key == "regular") {
            return key;
          }
        }).join();
        if (variants != "regular") {
          for (variants in font_object.variants) {
            break;
          }
        }
      }

      div_parent.find('input[name*="_variant"]:hidden').val(variants);
      div_parent.find('input[name*="_subsets"]:hidden').val(subsets);

      WebFont.load({
        google: {
          families: [font_family + ":" + variants + ":" + subsets]
        }
      });

      return false;
    }

    if (font_type == "built") {
      if (el.is('select[name*="body_family"]')) {
        div_parent.find('input[name*="_variant"]:hidden').val("");
      } else {
        div_parent.find('input[name*="_variant"]:hidden').val("regular");
      }
      div_parent.find('input[name*="_subsets"]:hidden').val("");

      return false;
    }

    return false;
  });

  $('#tb_cp_theme_fonts select[name*="_size"]').bind("change", function() {
    reloadFontsCss($(this).attr("changing_element"));

    return false;
  });

  $(document).ready(function() {
    if($.cookie('tb_cp_closed') == 1) {
      $("#tb_cp").hide();
      $("#tb_cp_open").show();
    } else {
      $("#tb_cp").show();
    }
  });

	$("#tb_cp_wrapper > form > .s_accordion").accordion({
		fillSpace: true
	});

  $("#tb_cp_close").bind("click", function() {
    $("#tb_cp").hide("slide", { direction: "left" }, 1000, function() {
      $("#tb_cp_open").show("slide", { direction: "left" }, 500);
      $.cookie('tb_cp_closed', 1);
    });
  });

  $("#tb_cp_open a").bind("click", function() {
    $("#tb_cp_open").hide("slide", { direction: "left" }, 500, function() {
      $("#tb_cp").show("slide", { direction: "left" }, 1000);
      $.cookie('tb_cp_closed', null);
    });
  });

  $("#modify_theme_categories").bind("change", function() {
    window.location = $(this).val();
  });

  function bindColorPickers() {
    $('#tb_cp_wrapper .colorSelector').each(function() {

      var $el = $(this);

      $el.ColorPicker({
        color: '#0000ff',
        onShow: function (colpkr) {

          if ($("#schemer_predefined_scheme").val() != "custom") {
            $("#schemer_predefined_scheme").val("custom");
          }

          $(colpkr).fadeIn(500);
          $(this).ColorPickerSetColor($el.next("input").val());

          return false;
        },
        onHide: function (colpkr) {

          if ($("#schemer_predefined_scheme").val() != "custom") {
            $("#schemer_predefined_scheme").val("custom");
          }

          $(colpkr).fadeOut(500);
          $el.next("input").val($(colpkr).data('colorpicker').fields.eq(0).val());

          return false;
        },
        onChange: function (hsb, hex, rgb) {
          $el.find('div').css('backgroundColor', '#' + hex);
          switch ($el.attr("id")) {

            case 'mainColorSelector' :
              $(".s_main_color, #twitter li span a, .s_box h2, .box .top").css('color', '#' + hex);
              $(".s_main_color_bgr, #cart .s_icon, #shop_contacts .s_icon, .s_list_1 li:before, .s_item .s_button_add_to_cart .s_icon, #cart_menu .s_icon, #intro .s_button_prev, #intro .s_button_next, .s_product_row .s_row_number").css('backgroundColor', '#' + hex);
              $("#main_color").val('#' + hex);
              break;

            case 'secondaryColorSelector' :
              $("#categories > ul > li > a, #footer_categories h2, .pagination a, #view_mode .s_selected a, .s_secondary_color").css('color', '#' + hex);
              $(".s_secondary_color_bgr, #site_search .s_search_button, #view_mode .s_selected .s_icon").css('backgroundColor', '#' + hex);
              $("#secondary_color").val('#' + hex);
              break;

            case 'introColorSelector' :
              $("#intro").css('backgroundColor', '#' + hex);
              break;

            case 'introTextColorSelector' :
              $("#intro, #breadcrumbs a").css('color', '#' + hex);
              break;

            case 'introTitleColorSelector' :
              $("#intro h1, #intro h1 *, #intro h2, #intro h2 *").css('color', '#' + hex);
              break;

            case 'priceColorSelector' :
              $(".s_price").not(".s_promo_price").css('backgroundColor', '#' + hex);
              break;

            case 'priceTextColorSelector' :
              $(".s_price, .s_price .s_currency").not(".s_promo_price, .s_old_price, .s_promo_price .s_currency").css('color', '#' + hex);
              break;

            case 'promoPriceColorSelector' :
              $(".s_promo_price").css('backgroundColor', '#' + hex);
              break;

            case 'promoPriceTextColorSelector' :
              $(".s_promo_price, .s_old_price, .s_promo_price .s_currency").css('color', '#' + hex);
              break;

            case 'backgroundColorSelector' :
              $("body.s_layout_fixed").css('backgroundColor', '#' + hex);
              break;
          }
        }
      });
    });
  }

  $("#textureSelector").bind("change", function(event, type) {
      if ($("#schemer_predefined_scheme").val() != "custom" && type != 'apply-only') {
        $("#schemer_predefined_scheme").val("custom");
      }

      var texture_type = $(this).find("option:selected").parent().attr("label");

      if (texture_type == "Default") {
        if ($(this).val() != 'no_texture') {
          $("body.s_layout_fixed").css('background-image', "url(catalog/view/theme/" + $sReg.get('/tb/basename') + "/images/" + $(this).val() + ".png)");
          $("body.s_layout_fixed").css('background-repeat', "repeat");
          $("body.s_layout_fixed").css('background-position', "top left");
          $("body.s_layout_fixed").css('background-attachment', "scroll");
        } else {
          $("body.s_layout_fixed").css('background-image', 'none');
        }
      } else {
        <?php if ($backgrounds): ?>
        var background_settings = jQuery.parseJSON('<?php echo json_encode($backgrounds); ?>');
        var item_id = $(this).find("option:selected").val();

        $("body.s_layout_fixed").css('background-image', "url('" + $sReg.get('/tb/image_url') + background_settings[item_id].image + "')");
        $("body.s_layout_fixed").css('background-repeat', background_settings[item_id].repeat);
        $("body.s_layout_fixed").css('background-position', background_settings[item_id].position);
        $("body.s_layout_fixed").css('background-attachment', background_settings[item_id].attachment);

        <?php endif; ?>
      }

  });

  bindColorPickers();
  var colorsData = jQuery.parseJSON($("#colors_data").val());

  $("#tb_cp_wrapper").delegate("#schemer_predefined_scheme", "change", function() {
    themeData = colorsData[$(this).val()];
    $("#textureSelector").val(themeData.texture).trigger("change", ['apply-only']);

    $('#tb_cp_wrapper .colorSelector').each(function() {
      var data_name = $(this).attr("name");
      var colorpickerId = $(this).data("colorpickerId");

      $(this).ColorPickerSetColor(themeData[data_name]);
      $("#" + colorpickerId).find("input").trigger("change");
      $(this).next("input").val($("#" + colorpickerId).find("div.colorpicker_hex input").val());
    });
  });

</script>