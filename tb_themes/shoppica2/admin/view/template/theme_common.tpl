<h2><span><?php echo $text_title_general; ?></span></h2>

<div class="s_row_2 first clearfix">
  <label><?php echo $text_label_lang_direction; ?></label>
  <div class="s_full tb_4col_wrap clearfix">
    <?php foreach ($languages as $language): ?>
    <div class="s_row_1 tb_col tb_5_24 clearfix">
      <label><img class="inline" src="<?php echo $theme_catalog_resource_url; ?>images/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></label>
      <div class="s_full clearfix">
        <select name="common[language_direction][<?php echo $language['language_id']; ?>]">
          <option value="ltr"<?php if($common['language_direction'][$language['language_id']] == 'ltr') echo ' selected="selected"';?>><?php echo $text_opt_lang_direction_1; ?></option>
          <option value="rtl"<?php if($common['language_direction'][$language['language_id']] == 'rtl') echo ' selected="selected"';?>><?php echo $text_opt_lang_direction_2; ?></option>
        </select>
      </div>
    </div>
    <?php endforeach; ?>
  </div>
</div>

<div class="s_row_2 clearfix">
  <label><?php echo $text_label_layout_type; ?></label>
  <select name="common[layout_type]">
    <option value="fixed"<?php if($common['layout_type'] == 'fixed') echo ' selected="selected"';?>><?php echo $text_opt_layout_type_1; ?></option>
    <option value="full"<?php if($common['layout_type'] == 'full') echo ' selected="selected"';?>><?php echo $text_opt_layout_type_2; ?></option>
  </select>
</div>

<div class="s_row_2 clearfix">
  <label><?php echo $text_label_side_col_position; ?></label>
  <select name="common[column_position]">
    <option value="right"<?php if($common['column_position'] == 'right') echo ' selected="selected"';?>><?php echo $text_opt_side_col_position_1; ?></option>
    <option value="left"<?php if($common['column_position'] == 'left') echo ' selected="selected"';?>><?php echo $text_opt_side_col_position_2; ?></option>
  </select>
</div>

<div class="s_row_2 clearfix">
  <label><?php echo $text_label_theme_version; ?></label>
  <span class="s_metric"><?php echo $common['theme_version']; ?></span>
</div>

<div class="s_submit clearfix">
  <a class="s_button" onclick="$('#form').submit();"><span class="s_icon_16"><span class="s_icon s_tick_16"></span><?php echo $text_button_save_settings; ?></span></a>
</div>
