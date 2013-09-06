<h2><?php echo $text_title_design_typography; ?></h2>

<?php if (count($languages) > 1): ?>
<div id="typography_settings_language_tabs" class="htabs clearfix">
  <?php foreach ($languages as $language): ?>
  <a href="#typography_settings_language_<?php echo $language['language_id']; ?>">
    <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>images/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
  </a>
  <?php endforeach; ?>
</div>
<?php endif; ?>

<?php foreach ($languages as $language): ?>
<?php $lid = $language['language_id']; ?>
<div id="typography_settings_language_<?php echo $lid; ?>" class="divtab">

  <div class="s_row_2 first clearfix fonts_row">
    <label><?php echo $text_label_body_font; ?></label>
    <div class="s_full tb_2col_wrap clearfix">
      <div class="s_row_1 tb_col tb_1_3 clearfix fontfamily">
        <div class="s_full clearfix">
          <select name="font[<?php echo $lid; ?>][body_family]" class="fontname">
            <option value="default"<?php if ($font[$lid]['body_family'] == 'default') echo ' selected="selected"'; ?>>Theme Default</option>
            <optgroup label="Built-in Fonts" type="built">
              <?php foreach ($built_font_families as $name): ?>
              <option value="<?php echo $name; ?>"<?php if ($font[$lid]['body_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
              <?php endforeach; ?>
            </optgroup>
            <optgroup label="Google Fonts" type="google">
              <?php foreach ($google_font_families as $name): ?>
              <option value="<?php echo $name; ?>"<?php if ($font[$lid]['body_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
              <?php endforeach; ?>
            </optgroup>
          </select>
          <input type="hidden" name="font[<?php echo $lid; ?>][body_type]" value="<?php echo $font[$lid]['body_type']; ?>" />
        </div>
      </div>
      <div class="s_row_1 tb_col tb_1_3 clearfix fontstyle"<?php if ($font[$lid]['body_type'] != 'google'): ?> style="display: none"<?php endif; ?>>
        <div class="s_full clearfix">
          <select class="tb_multiselect body_style" multiple="multiple">
            <optgroup label="Style" class="font_variants">
              <?php if ($font[$lid]['body_type'] == 'google'): ?>
                <?php foreach ($google_font_list[$font[$lid]['body_family']]->variants as $variant): ?>
                <option value="<?php echo $variant['code']; ?>"<?php if (in_array($variant['code'], explode(',', $font[$lid]['body_variant']))) echo ' selected="selected"'; ?>><?php echo $variant['code']; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
            </optgroup>
            <optgroup label="Subset" class="font_subsets">
              <?php if ($font[$lid]['body_type'] == 'google'): ?>
                <?php foreach ($google_font_list[$font[$lid]['body_family']]->subsets as $subset): ?>
                <option value="<?php echo $subset; ?>"<?php if (in_array($subset, explode(',', $font[$lid]['body_subsets']))) echo ' selected="selected"'; ?>><?php echo $subset; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
            </optgroup>
          </select>
          <input type="hidden" name="font[<?php echo $lid; ?>][body_variant]" value="<?php echo $font[$lid]['body_variant']; ?>" />
          <input type="hidden" name="font[<?php echo $lid; ?>][body_subsets]" value="<?php echo $font[$lid]['body_subsets']; ?>" />
        </div>
      </div>
      <!-- <a class="tb_button_search right" href="javascript:;"><?php echo $text_view; ?></a> -->
    </div>
  </div>

  <div class="s_row_2 clearfix fonts_row">
    <label><?php echo $text_label_nav_font; ?></label>
    <div class="s_full tb_2col_wrap clearfix">
      <div class="s_row_1 tb_col tb_1_3 clearfix fontfamily">
        <div class="s_full clearfix">
          <select name="font[<?php echo $lid; ?>][navigation_family]" class="fontname">
            <option value="default"<?php if ($font[$lid]['navigation_type'] == 'default') echo ' selected="selected"'; ?>>Theme Default</option>
            <optgroup label="Built-in Fonts" type="built">
              <?php foreach ($built_font_families as $name): ?>
              <option value="<?php echo $name; ?>"<?php if ($font[$lid]['navigation_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
              <?php endforeach; ?>
            </optgroup>
            <optgroup label="Google Fonts" type="google">
              <?php foreach ($google_font_families as $name): ?>
              <option value="<?php echo $name; ?>"<?php if ($font[$lid]['navigation_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
              <?php endforeach; ?>
            </optgroup>
          </select>
          <input type="hidden" name="font[<?php echo $lid; ?>][navigation_type]" value="<?php echo $font[$lid]['navigation_type']; ?>" />
        </div>
      </div>
      <div class="s_row_1 tb_col tb_1_3 clearfix fontstyle"<?php if ($font[$lid]['navigation_family'] == 'default'): ?> style="display: none"<?php endif; ?>>
        <div class="s_full clearfix">
          <select class="tb_multiselect" multiple="multiple">
            <optgroup label="Style" class="font_variants">
              <?php if ($font[$lid]['navigation_type'] == 'google'): ?>
                <?php foreach ($google_font_list[$font[$lid]['navigation_family']]->variants as $variant): ?>
                <option value="<?php echo $variant['code']; ?>"<?php if (in_array($variant['code'], explode(',', $font[$lid]['navigation_variant']))) echo ' selected="selected"'; ?>><?php echo $variant['code']; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
              <?php if ($font[$lid]['navigation_type'] == 'built'): ?>
                <?php foreach ($built_font_variants as $variant): ?>
                <option value="<?php echo $variant; ?>"<?php if (in_array($variant, explode(',', $font[$lid]['navigation_variant']))) echo ' selected="selected"'; ?>><?php echo $variant; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
            </optgroup>
            <optgroup label="Subset" class="font_subsets">
              <?php if ($font[$lid]['navigation_type'] == 'google'): ?>
                <?php foreach ($google_font_list[$font[$lid]['navigation_family']]->subsets as $subset): ?>
                <option value="<?php echo $subset; ?>"<?php if (in_array($subset, explode(',', $font[$lid]['navigation_subsets']))) echo ' selected="selected"'; ?>><?php echo $subset; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
            </optgroup>
          </select>
          <input type="hidden" name="font[<?php echo $lid; ?>][navigation_variant]" value="<?php echo $font[$lid]['navigation_variant']; ?>" />
          <input type="hidden" name="font[<?php echo $lid; ?>][navigation_subsets]" value="<?php echo $font[$lid]['navigation_subsets']; ?>" />
        </div>
      </div>
      <div class="s_row_1 tb_col tb_1_6 clearfix">
        <div class="s_full clearfix">
          <select name="font[<?php echo $lid; ?>][navigation_size]">
            <?php foreach (range(12, 24) as $size): ?>
            <option value="<?php echo $size; ?>"<?php if ($font[$lid]['navigation_size'] == $size) echo ' selected="selected"'; ?>><?php echo $size; ?>px</option>
            <?php endforeach; ?>
          </select>
        </div>
      </div>
      <!-- <a class="tb_button_search right" href="javascript:;"><?php echo $text_view; ?></a> -->
    </div>
    <!--
    <div class="s_full s_font_preview">
      <a class="s_button_close_small" href="javascript:;">Close</a>
      <p><?php echo $text_font_preview; ?></p>
    </div>
    -->
  </div>

  <div class="s_row_2 clearfix fonts_row">
    <label><?php echo $text_label_intro_font; ?></label>
    <div class="s_full tb_2col_wrap clearfix">
      <div class="s_row_1 tb_col tb_1_3 clearfix fontfamily">
        <div class="s_full clearfix">
          <select name="font[<?php echo $lid; ?>][intro_family]" class="fontname">
            <option value="default"<?php if ($font[$lid]['intro_family'] == 'default') echo ' selected="selected"'; ?>>Theme Default</option>
            <optgroup label="Built-in Fonts" type="built">
              <?php foreach ($built_font_families as $name): ?>
              <option value="<?php echo $name; ?>"<?php if ($font[$lid]['intro_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
              <?php endforeach; ?>
            </optgroup>
            <optgroup label="Google Fonts" type="google">
              <?php foreach ($google_font_families as $name): ?>
              <option value="<?php echo $name; ?>"<?php if ($font[$lid]['intro_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
              <?php endforeach; ?>
            </optgroup>
          </select>
          <input type="hidden" name="font[<?php echo $lid; ?>][intro_type]" value="<?php echo $font[$lid]['intro_type']; ?>" />
        </div>
      </div>
      <div class="s_row_1 tb_col tb_1_3 clearfix fontstyle"<?php if ($font[$lid]['intro_type'] == 'default'): ?> style="display: none"<?php endif; ?>>
        <div class="s_full clearfix">
          <select class="tb_multiselect" multiple="multiple">
            <optgroup label="Style" class="font_variants">
              <?php if ($font[$lid]['intro_type'] == 'google'): ?>
                <?php foreach ($google_font_list[$font[$lid]['intro_family']]->variants as $variant): ?>
                <option value="<?php echo $variant['code']; ?>"<?php if (in_array($variant['code'], explode(',', $font[$lid]['intro_variant']))) echo ' selected="selected"'; ?>><?php echo $variant['code']; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
              <?php if ($font[$lid]['intro_type'] == 'built'): ?>
                <?php foreach ($built_font_variants as $variant): ?>
                <option value="<?php echo $variant; ?>"<?php if (in_array($variant, explode(',', $font[$lid]['intro_variant']))) echo ' selected="selected"'; ?>><?php echo $variant; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
            </optgroup>
            <optgroup label="Subset" class="font_subsets">
              <?php if ($font[$lid]['intro_type'] == 'google'): ?>
                <?php foreach ($google_font_list[$font[$lid]['intro_family']]->subsets as $subset): ?>
                <option value="<?php echo $subset; ?>"<?php if (in_array($subset, explode(',', $font[$lid]['intro_subsets']))) echo ' selected="selected"'; ?>><?php echo $subset; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
            </optgroup>
          </select>
          <input type="hidden" name="font[<?php echo $lid; ?>][intro_variant]" value="<?php echo $font[$lid]['intro_variant']; ?>" />
          <input type="hidden" name="font[<?php echo $lid; ?>][intro_subsets]" value="<?php echo $font[$lid]['intro_subsets']; ?>" />
        </div>
      </div>
      <div class="s_row_1 tb_col tb_1_6 clearfix">
        <div class="s_full clearfix">
          <select name="font[<?php echo $lid; ?>][intro_size]">
            <?php foreach (range(24, 38) as $size): ?>
            <option value="<?php echo $size; ?>"<?php if ($font[$lid]['intro_size'] == $size) echo ' selected="selected"'; ?>><?php echo $size; ?>px</option>
            <?php endforeach; ?>
          </select>
        </div>
      </div>
      <!-- <a class="tb_button_search right" href="javascript:;"><?php echo $text_view; ?></a> -->
    </div>
  </div>

  <div class="s_row_2 clearfix">
    <label><?php echo $text_label_title_font; ?></label>
    <div class="s_full tb_2col_wrap clearfix">
      <div class="s_row_1 tb_col tb_1_3 clearfix fontfamily">
        <div class="s_full clearfix">
          <select name="font[<?php echo $lid; ?>][title_family]" class="fontname">
            <option value="default"<?php if ($font[$lid]['title_family'] == 'default') echo ' selected="selected"'; ?>>Theme Default</option>
            <optgroup label="Built-in Fonts" type="built">
              <?php foreach ($built_font_families as $name): ?>
              <option value="<?php echo $name; ?>"<?php if ($font[$lid]['title_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
              <?php endforeach; ?>
            </optgroup>
            <optgroup label="Google Fonts" type="google">
              <?php foreach ($google_font_families as $name): ?>
              <option value="<?php echo $name; ?>"<?php if ($font[$lid]['title_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
              <?php endforeach; ?>
            </optgroup>
          </select>
          <input type="hidden" name="font[<?php echo $lid; ?>][title_type]" value="<?php echo $font[$lid]['title_type']; ?>" />
        </div>
      </div>
      <div class="s_row_1 tb_col tb_1_3 clearfix fontstyle"<?php if ($font[$lid]['title_type'] == 'default'): ?> style="display: none"<?php endif; ?>>
        <div class="s_full clearfix">
          <select class="tb_multiselect" multiple="multiple">
            <optgroup label="Style" class="font_variants">
              <?php if ($font[$lid]['title_type'] == 'google'): ?>
                <?php foreach ($google_font_list[$font[$lid]['title_family']]->variants as $variant): ?>
                <option value="<?php echo $variant['code']; ?>"<?php if (in_array($variant['code'], explode(',', $font[$lid]['title_variant']))) echo ' selected="selected"'; ?>><?php echo $variant['code']; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
              <?php if ($font[$lid]['title_type'] == 'built'): ?>
                <?php foreach ($built_font_variants as $variant): ?>
                <option value="<?php echo $variant; ?>"<?php if (in_array($variant, explode(',', $font[$lid]['title_variant']))) echo ' selected="selected"'; ?>><?php echo $variant; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
            </optgroup>
            <optgroup label="Subset" class="font_subsets">
              <?php if ($font[$lid]['title_type'] == 'google'): ?>
                <?php foreach ($google_font_list[$font[$lid]['title_family']]->subsets as $subset): ?>
                <option value="<?php echo $subset; ?>"<?php if (in_array($subset, explode(',', $font[$lid]['title_subsets']))) echo ' selected="selected"'; ?>><?php echo $subset; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
            </optgroup>
          </select>
          <input type="hidden" name="font[<?php echo $lid; ?>][title_variant]" value="<?php echo $font[$lid]['title_variant']; ?>" />
          <input type="hidden" name="font[<?php echo $lid; ?>][title_subsets]" value="<?php echo $font[$lid]['title_subsets']; ?>" />
        </div>
      </div>
      <!-- <a class="tb_button_search right" href="javascript:;"><?php echo $text_view; ?></a> -->
    </div>
  </div>

  <div class="s_row_2 clearfix">
    <label><?php echo $text_label_price_font; ?></label>
    <div class="s_full tb_2col_wrap clearfix">
      <div class="s_row_1 tb_col tb_1_3 clearfix fontfamily">
        <div class="s_full clearfix">
          <select name="font[<?php echo $lid; ?>][price_family]" class="fontname">
            <option value="default"<?php if ($font[$lid]['price_family'] == 'default') echo ' selected="selected"'; ?>>Theme Default</option>
            <optgroup label="Built-in Fonts" type="built">
              <?php foreach ($built_font_families as $name): ?>
              <option value="<?php echo $name; ?>"<?php if ($font[$lid]['price_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
              <?php endforeach; ?>
            </optgroup>
            <optgroup label="Google Fonts" type="google">
              <?php foreach ($google_font_families as $name): ?>
              <option value="<?php echo $name; ?>"<?php if ($font[$lid]['price_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
              <?php endforeach; ?>
            </optgroup>
          </select>
          <input type="hidden" name="font[<?php echo $lid; ?>][price_type]" value="<?php echo $font[$lid]['price_type']; ?>" />
        </div>
      </div>
      <div class="s_row_1 tb_col tb_1_3 clearfix fontstyle"<?php if ($font[$lid]['price_type'] == 'default'): ?> style="display: none"<?php endif; ?>>
        <div class="s_full clearfix">
          <select class="tb_multiselect" multiple="multiple">
            <optgroup label="Style" class="font_variants">
              <?php if ($font[$lid]['price_type'] == 'google'): ?>
                <?php foreach ($google_font_list[$font[$lid]['price_family']]->variants as $variant): ?>
                <option value="<?php echo $variant['code']; ?>"<?php if (in_array($variant['code'], explode(',', $font[$lid]['price_variant']))) echo ' selected="selected"'; ?>><?php echo $variant['code']; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
              <?php if ($font[$lid]['price_type'] == 'built'): ?>
                <?php foreach ($built_font_variants as $variant): ?>
                <option value="<?php echo $variant; ?>"<?php if (in_array($variant, explode(',', $font[$lid]['price_variant']))) echo ' selected="selected"'; ?>><?php echo $variant; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
            </optgroup>
            <optgroup label="Subset" class="font_subsets">
              <?php if ($font[$lid]['price_type'] == 'google'): ?>
                <?php foreach ($google_font_list[$font[$lid]['price_family']]->subsets as $subset): ?>
                <option value="<?php echo $subset; ?>"<?php if (in_array($subset, explode(',', $font[$lid]['price_subsets']))) echo ' selected="selected"'; ?>><?php echo $subset; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
            </optgroup>
          </select>
          <input type="hidden" name="font[<?php echo $lid; ?>][price_variant]" value="<?php echo $font[$lid]['price_variant']; ?>" />
          <input type="hidden" name="font[<?php echo $lid; ?>][price_subsets]" value="<?php echo $font[$lid]['price_subsets']; ?>" />
        </div>
      </div>
      <!-- <a class="tb_button_search right" href="javascript:;"><?php echo $text_view; ?></a> -->
    </div>
  </div>

  <div class="s_row_2 clearfix">
    <label><?php echo $text_label_button_font; ?></label>
    <div class="s_full tb_2col_wrap clearfix">
      <div class="s_row_1 tb_col tb_1_3 clearfix fontfamily">
        <div class="s_full clearfix">
          <select name="font[<?php echo $lid; ?>][button_family]" class="fontname">
            <option value="default"<?php if ($font[$lid]['button_family'] == 'default') echo ' selected="selected"'; ?>>Theme Default</option>
            <optgroup label="Built-in Fonts" type="built">
              <?php foreach ($built_font_families as $name): ?>
              <option value="<?php echo $name; ?>"<?php if ($font[$lid]['button_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
              <?php endforeach; ?>
            </optgroup>
            <optgroup label="Google Fonts" type="google">
              <?php foreach ($google_font_families as $name): ?>
              <option value="<?php echo $name; ?>"<?php if ($font[$lid]['button_family'] == $name) echo ' selected="selected"'; ?>><?php echo $name; ?></option>
              <?php endforeach; ?>
            </optgroup>
          </select>
          <input type="hidden" name="font[<?php echo $lid; ?>][button_type]" value="<?php echo $font[$lid]['button_type']; ?>" />
        </div>
      </div>
      <div class="s_row_1 tb_col tb_1_3 clearfix fontstyle"<?php if ($font[$lid]['button_type'] == 'default'): ?> style="display: none"<?php endif; ?>>
        <div class="s_full clearfix">
          <select class="tb_multiselect" multiple="multiple">
            <optgroup label="Style" class="font_variants">
              <?php if ($font[$lid]['button_type'] == 'google'): ?>
                <?php foreach ($google_font_list[$font[$lid]['button_family']]->variants as $variant): ?>
                <option value="<?php echo $variant['code']; ?>"<?php if (in_array($variant['code'], explode(',', $font[$lid]['button_variant']))) echo ' selected="selected"'; ?>><?php echo $variant['code']; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
              <?php if ($font[$lid]['button_type'] == 'built'): ?>
                <?php foreach ($built_font_variants as $variant): ?>
                <option value="<?php echo $variant; ?>"<?php if (in_array($variant, explode(',', $font[$lid]['button_variant']))) echo ' selected="selected"'; ?>><?php echo $variant; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
            </optgroup>
            <optgroup label="Subset" class="font_subsets">
              <?php if ($font[$lid]['button_type'] == 'google'): ?>
                <?php foreach ($google_font_list[$font[$lid]['button_family']]->subsets as $subset): ?>
                <option value="<?php echo $subset; ?>"<?php if (in_array($subset, explode(',', $font[$lid]['button_subsets']))) echo ' selected="selected"'; ?>><?php echo $subset; ?></option>
                <?php endforeach; ?>
              <?php endif; ?>
            </optgroup>
          </select>
          <input type="hidden" name="font[<?php echo $lid; ?>][button_variant]" value="<?php echo $font[$lid]['button_variant']; ?>" />
          <input type="hidden" name="font[<?php echo $lid; ?>][button_subsets]" value="<?php echo $font[$lid]['button_subsets']; ?>" />
        </div>
      </div>
      <div class="s_row_1 tb_col tb_1_6 clearfix">
        <div class="s_full clearfix">
          <select name="font[<?php echo $lid; ?>][button_size]">
            <?php foreach (range(12, 24) as $size): ?>
            <option value="<?php echo $size; ?>"<?php if ($font[$lid]['button_size'] == $size) echo ' selected="selected"'; ?>><?php echo $size; ?>px</option>
            <?php endforeach; ?>
          </select>
        </div>
      </div>
      <!-- <a class="tb_button_search right" href="javascript:;"><?php echo $text_view; ?></a> -->
    </div>
  </div>

</div>
<?php endforeach; ?>

<script type="text/javascript">

  $("#typography_settings_tab .tb_multiselect").multiselect({
  		header: false,
  		noneSelectedText: '<?php echo $text_label_font_options; ?>',
  		selectedList: 2
  });

  $("#typography_settings_tab").find("select, input:file, input:checkbox, input:radio").not(".tb_toggle, .tb_multiselect").uniform();

  $("#typography_settings_language_tabs a").tabs();

  $("#typography_settings_tab select.fontname").bind("change", function () {
    var el = $(this);
    var div_parent = el.parents("div.fontfamily:first");
    var div_style = div_parent.next("div.fontstyle");
    var font_type = el.find(":selected").parent("optgroup").attr("type");

    if (typeof font_type == "undefined") {
      div_style.hide();
      div_parent.find('input[name*="_type"]:hidden').val("default");
      div_style.find('input[name*="_variant"]:hidden').val("");
      div_style.find('input[name*="_subsets"]:hidden').val("");

      return false;
    }

    var adjacent_el = div_style.find("select").multiselect();
    var variants_el = adjacent_el.find("optgroup.font_variants");

    div_parent.find('input[name*="_type"]:hidden').val(font_type);
    if (font_type == "built" && el.is('select[name*="body_family"]')) {
      div_style.find('input[name*="_variant"]:hidden').val("");
      div_style.find('input[name*="_subsets"]:hidden').val("");
      div_style.hide();

      return false;
    }

    if (font_type == "built") {
      variants_el.empty();
      jQuery.each(['regular', 'bold', 'italic', 'bolditalic'], function(i, val) {
        var opt = $('<option />', {
          value: val,
          text: val
        });
        opt.appendTo(variants_el);
      });
      adjacent_el.find("option:first").attr("selected", "selected");
      adjacent_el.find("optgroup.font_subsets").remove();
      adjacent_el.multiselect('refresh');
      adjacent_el.multiselect("widget").find("li.ui-multiselect-optgroup-label").bind("click", function() {
        return false;
      });
      div_style.find('input[name*="_variant"]:hidden').val(adjacent_el.find(":selected").val());
      div_style.find('input[name*="_subsets"]:hidden').val("");
      div_style.show();

      return false;
    }

    var ajaxUrl = "<?php echo $tbUrl->generateJs('fonts/getFontData'); ?>";
    $.getJSON(ajaxUrl + "&font_name=" + el.find(":selected").val(), function(data) {
      variants_el.empty();
      jQuery.each(data.variants, function(i, val) {
        var opt = $('<option />', {
          value: val.code,
          text: val.code
        });
        opt.appendTo(variants_el);
      });

      if (variants_el.find("option[value*=regular]:first").is("option")) {
        variants_el.find("option[value*=regular]:first").attr("selected", "selected");
      } else {
        variants_el.find("option:first").attr("selected", "selected");
      }
      div_style.find('input[name*="_variant"]:hidden').val(variants_el.find("option:selected").val());

      var subsets_el = adjacent_el.find("optgroup.font_subsets");
      subsets_el.empty();
      jQuery.each(data.subsets, function(i, val) {
        var opt = $('<option />', {
          value: val,
          text: val
        });
        opt.appendTo(subsets_el);
      });

      if (subsets_el.find("option[value*=latin]:first").is("option")) {
        subsets_el.find("option[value*=latin]:first").attr("selected", "selected");
      } else {
        subsets_el.find("option:first").attr("selected", "selected");
      }
      div_style.find('input[name*="_subsets"]:hidden').val(subsets_el.find("option:selected").val());

      adjacent_el.multiselect('refresh');
      adjacent_el.multiselect("widget").find("li.ui-multiselect-optgroup-label").bind("click", function() {
        return false;
      });

      div_style.show();
    });


    return false;
  });

  $("#typography_settings_tab select.tb_multiselect").bind("multiselectclick", function(event, ui) {
    var el = $(this);
    var div_parent = el.parents("div.fontstyle:first");
    var selected_option = el.find('option[value="' + ui.value + '"]');

    if (false == ui.checked && selected_option.siblings(":selected").length == 0) {
        return false;
    }

    if (selected_option.parent("optgroup").is(".font_variants")) {
      var input_hidden = div_parent.find('input[name*="_variant"]:hidden');

      if (true == ui.checked && el.is(':not(.body_style)')) {
        el.find("optgroup.font_variants > option").not(selected_option).removeAttr("selected");
        selected_option.attr("selected", "selected");
        input_hidden.val(selected_option.val());
        el.multiselect('refresh');
        el.multiselect("widget").find("li.ui-multiselect-optgroup-label").bind("click", function() {
          return false;
        });

        return true;
      }
    }

    if (selected_option.parent("optgroup").is(".font_subsets")) {
      var input_hidden = div_parent.find('input[name*="_subsets"]:hidden');
    }

    var values = ui.value;
    if (input_hidden.val().length !== 0) {
      values = values + "," + input_hidden.val();
    }

    values = $.map(values.split(","), function(checkbox) {
      if (ui.value != checkbox || (ui.value == checkbox && ui.checked)) {
        return checkbox;
      }
    }).join(",");

    input_hidden.val(values);
  });

  $(document).ready(function() {
    $("body > div.ui-multiselect-menu li.ui-multiselect-optgroup-label").bind("click", function() {
      return false;
    });
  });

</script>