<div class="s_row_2 first clearfix">
  <label><?php echo $text_label_category; ?></label>
  <select id="schemer_categories" name="schemer[path]">
    <?php if ($url_schemer_category_id == 0): ?>
    <option value="0">*<?php echo $text_global; ?>*</option>
    <?php else: ?>
    <option value="<?php echo $tbUrl->generate('schemer/index', 'schemer_category_path=0'); ?>">*<?php echo $text_global; ?>*</option>
    <?php endif; ?>
    <?php foreach ($schemer_categories as $category): ?>
    <?php if ($category['category_id'] == $url_schemer_category_id): ?>
    <option value="<?php echo $category['path']; ?>" selected="selected"><?php echo str_repeat('--', $category['level']) . ' ' . $category['name']; ?></option>
    <?php else: ?>
    <option value="<?php echo $tbUrl->generate('schemer/index', 'schemer_category_path=' . $category['path']); ?>"><?php echo str_repeat('--', $category['level']) . ' ' . $category['name']; ?></option>
    <?php endif; ?>
    <?php endforeach; ?>
  </select>
</div>

<div class="s_row_2 clearfix">
  <label><?php echo $text_label_color_scheme; ?></label>
  <?php $already_selected = false; ?>
  <select id="schemer_predefined_scheme" name="schemer[predefined_scheme]">
      <?php if ($url_schemer_category_id != 0): ?>
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

<input type="hidden" id="colors_data" value='<?php echo $schemer_json_data; ?>' />

<div class="s_row_2 clearfix">
  <label><?php echo $text_label_basic_colors; ?></label>
  <div class="s_full tb_4col_wrap clearfix">
  
    <div class="s_row_1 tb_col tb_1_4 clearfix">
      <label><?php echo $text_label_main_color; ?></label>
      <div id="mainColorSelector" class="colorSelector" name="main">
        <div style="background-color: #<?php echo $schemer['colors']['main'] ?>;"></div>
      </div>
      <input type="hidden" name="schemer[colors][main]" value="<?php echo $schemer['colors']['main'] ?>" />
    </div>

    <div class="s_row_1 tb_col tb_1_4 clearfix">
      <label><?php echo $text_label_secondary_color; ?></label>
      <div id="secondaryColorSelector" class="colorSelector" name="secondary">
        <div style="background-color: #<?php echo $schemer['colors']['secondary'] ?>;"></div>
      </div>
      <input type="hidden" name="schemer[colors][secondary]" value="<?php echo $schemer['colors']['secondary'] ?>" />
    </div>

    <div class="s_row_1 tb_col tb_1_4 clearfix">
      <label><?php echo $text_label_body_color; ?></label>
      <div id="backgroundColorSelector" class="colorSelector" name="background">
        <div style="background-color: #<?php echo $schemer['colors']['background'] ?>;"></div>
      </div>
      <input type="hidden" name="schemer[colors][background]" value="<?php echo $schemer['colors']['background'] ?>" />
    </div>
    
  </div>
</div>

<div class="s_row_2 clearfix">
  <label><?php echo $text_label_intro_colors; ?></label>
  <div class="s_full tb_4col_wrap clearfix">

    <div class="s_row_1 tb_col tb_1_4 clearfix">
      <label><?php echo $text_label_intro_color; ?></label>
      <div id="introColorSelector" class="colorSelector" name="intro">
        <div style="background-color: #<?php echo $schemer['colors']['intro'] ?>;"></div>
      </div>
      <input type="hidden" name="schemer[colors][intro]" value="<?php echo $schemer['colors']['intro'] ?>" />
    </div>

    <div class="s_row_1 tb_col tb_1_4 clearfix">
      <label><?php echo $text_label_intro_text_color; ?></label>
      <div id="introTextColorSelector" class="colorSelector" name="intro_text">
        <div style="background-color: #<?php echo $schemer['colors']['intro_text'] ?>;"></div>
      </div>
      <input type="hidden" name="schemer[colors][intro_text]" value="<?php echo $schemer['colors']['intro_text'] ?>" />
    </div>

    <div class="s_row_1 tb_col tb_1_4 clearfix">
      <label><?php echo $text_label_intro_title_color; ?></label>
      <div id="introTitleColorSelector" class="colorSelector" name="intro_title">
        <div style="background-color: #<?php echo $schemer['colors']['intro_title'] ?>;"></div>
      </div>
      <input type="hidden" name="schemer[colors][intro_title]" value="<?php echo $schemer['colors']['intro_title'] ?>" />
    </div>

  </div>
</div>

<div class="s_row_2 clearfix">
  <label><?php echo $text_label_price_label_colors; ?></label>
  <div class="s_full tb_4col_wrap clearfix">

    <div class="s_row_1 tb_col tb_1_4 clearfix">
      <label><?php echo $text_label_price_color; ?></label>
      <div id="priceColorSelector" class="colorSelector" name="price">
        <div style="background-color: #<?php echo $schemer['colors']['price'] ?>;"></div>
      </div>
      <input type="hidden" name="schemer[colors][price]" value="<?php echo $schemer['colors']['price'] ?>" />
    </div>

    <div class="s_row_1 tb_col tb_1_4 clearfix">
      <label><?php echo $text_label_price_text_color; ?></label>
      <div id="priceTextColorSelector" class="colorSelector" name="price_text">
        <div style="background-color: #<?php echo $schemer['colors']['price_text'] ?>;"></div>
      </div>
      <input type="hidden" name="schemer[colors][price_text]" value="<?php echo $schemer['colors']['price_text'] ?>" />
    </div>

    <div class="s_row_1 tb_col tb_1_4 clearfix">
      <label><?php echo $text_label_promo_color; ?></label>
      <div id="promoPriceColorSelector" class="colorSelector" name="promo_price">
        <div style="background-color: #<?php echo $schemer['colors']['promo_price'] ?>;"></div>
      </div>
      <input type="hidden" name="schemer[colors][promo_price]" value="<?php echo $schemer['colors']['promo_price'] ?>" />
    </div>

    <div class="s_row_1 tb_col tb_1_4 clearfix">
      <label><?php echo $text_label_promo_text_color; ?></label>
      <div id="promoPriceTextColorSelector" class="colorSelector" name="promo_price_text">
        <div style="background-color: #<?php echo $schemer['colors']['promo_price_text'] ?>;"></div>
      </div>
      <input type="hidden" name="schemer[colors][promo_price_text]" value="<?php echo $schemer['colors']['promo_price_text'] ?>" />
    </div>

  </div>
</div>

<div class="s_row_2 s_mb_10 clearfix">
  <label><?php echo $text_label_plain_price_colors; ?></label>
  <div class="s_full tb_4col_wrap clearfix">

    <div class="s_row_1 tb_col tb_1_4 clearfix">
      <label><?php echo $text_label_price_text_color; ?></label>
      <div id="plainPriceTextColorSelector" class="colorSelector" name="plain_price_text">
        <div style="background-color: #<?php echo $schemer['colors']['plain_price_text'] ?>;"></div>
      </div>
      <input type="hidden" name="schemer[colors][plain_price_text]" value="<?php echo isset($schemer['colors']['plain_price_text']) ?  $schemer['colors']['plain_price_text'] : '000000' ?>" />
    </div>

    <div class="s_row_1 tb_col tb_1_4 clearfix">
      <label><?php echo $text_label_promo_text_color; ?></label>
      <div id="plainPromoPriceTextColorSelector" class="colorSelector" name="plain_promo_price_text">
        <div style="background-color: #<?php echo $schemer['colors']['plain_promo_price_text'] ?>;"></div>
      </div>
      <input type="hidden" name="schemer[colors][plain_promo_price_text]" value="<?php echo isset($schemer['colors']['plain_promo_price_text']) ? $schemer['colors']['plain_promo_price_text'] : 'ff3000' ?>" />
    </div>

  </div>
</div>

<input type="hidden" name="schemer[colors][texture]" value="<?php echo $schemer['colors']['texture'] ?>" />

