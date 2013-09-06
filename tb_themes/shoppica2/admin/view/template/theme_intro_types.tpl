<div class="s_row_2 clearfix">
  <label><?php echo $text_label_intro_type; ?></label>
  <select name="intro[type]" id="intro_type_choice">
    <?php if($url_intro_category_id != 0): ?>
    <option value="parent"<?php if($intro['type'] == 'parent') echo ' selected="selected"';?>><?php echo $text_opt_intro_type_0; ?></option>
    <?php endif; ?>
    <option value="nointro"<?php if($intro['type'] == 'nointro') echo ' selected="selected"';?>><?php echo $text_opt_intro_type_1; ?></option>
    <option value="products"<?php if($intro['type'] == 'products') echo ' selected="selected"';?>><?php echo $text_opt_intro_type_2; ?></option>
    <option value="images"<?php if($intro['type'] == 'images') echo ' selected="selected"';?>><?php echo $text_opt_intro_type_3; ?></option>
  </select>
</div>

<div id="intro_type_products" style="display: none">
  <div class="s_row_2 clearfix">
    <label><?php echo $text_label_intro_size; ?></label>
    <select name="intro[products][size]">
      <option value="3"<?php if($intro['products']['size'] == '3') echo ' selected="selected"';?>><?php echo $text_large; ?></option>
      <option value="2"<?php if($intro['products']['size'] == '2') echo ' selected="selected"';?>><?php echo $text_middle; ?></option>
      <option value="1"<?php if($intro['products']['size'] == '1') echo ' selected="selected"';?>><?php echo $text_small; ?></option>
    </select>
  </div>

  <div class="s_row_2 clearfix">
    <label><?php echo $text_label_intro_text_source; ?></label>
    <select name="intro[products][text_source]">
      <option value="metadesc"<?php if($intro['products']['text_source'] == 'metadesc') echo ' selected="selected"';?>><?php echo $text_opt_intro_text_source_1; ?></option>
      <option value="details"<?php if($intro['products']['text_source'] == 'details') echo ' selected="selected"';?>><?php echo $text_opt_intro_text_source_2; ?></option>
      <option value="combined"<?php if($intro['products']['text_source'] == 'combined') echo ' selected="selected"';?>><?php echo $text_opt_intro_text_source_3; ?></option>
    </select>
  </div>

  <?php $tbSlot->flag('tb\theme_intro_types.products.settings', array('intro' => $intro)); ?>

  <div class="s_row_2 clearfix">
    <?php echo $text_you_have_added; ?> <strong><span class="intro_category_products_count"><?php echo $intro_category_products_count; ?></span></strong> <?php echo $text_products_to; ?> <strong><?php echo $intro_category_name; ?></strong>
    <a class="sModal s_button s_button_2 s_button_green right s_mr_0" href="<?php echo $tbUrl->generate('intro/getIntroBannerProductsHtml'); ?>"><?php echo $text_button_choose_products; ?></a>
  </div>
</div>

<div id="intro_type_images" style="display: none; padding-top: 10px;">

  <div id="intro_type_images_tabs" class="htabs clearfix">
    <?php foreach ($languages as $language): ?>
    <a href="#language_<?php echo $language['language_id']; ?>">
      <img class="inline" src="<?php echo $theme_catalog_resource_url; ?>images/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
    </a>
    <?php endforeach; ?>
  </div>

  <?php foreach ($languages as $language): $lid = $language['language_id']; ?>
  <div id="language_<?php echo $lid; ?>" class="divtab">

    <div class="s_row_2 first clearfix">
      <label><?php echo $text_label_image_settings; ?></label>
      <div class="s_full">
        <input type="hidden" name="intro[images][<?php echo $lid; ?>][with_border]" value="0" />
        <label class="s_checkbox" for="intro_image_border_yes_<?php echo $lid; ?>">
          <input id="intro_image_border_yes_<?php echo $lid; ?>" type="checkbox" value="1" name="intro[images][<?php echo $lid; ?>][with_border]"<?php if($intro['images'][$lid]['with_border'] == '1') echo ' checked="checked"'; ?> />
          <?php echo $text_label_put_border; ?>
        </label>
      </div>
    </div>

    <div class="s_row_2 s_mb_10 clearfix">
      <label><?php echo $text_label_rotation_type; ?></label>
      <select name="intro[images][<?php echo $lid; ?>][rotation_type]">
        <option value="slide"<?php if($intro['images'][$lid]['rotation_type'] == 'slide') echo ' selected="selected"'; ?>><?php echo $text_opt_rotation_type_1; ?></option>
        <option value="fade"<?php if($intro['images'][$lid]['rotation_type'] == 'fade') echo ' selected="selected"'; ?>><?php echo $text_opt_rotation_type_2; ?></option>
      </select>
    </div>

    <?php $tbSlot->flag('tb\theme_intro_types.images.settings', array('intro' => $intro, 'language_id' => $lid)); ?>

    <table id="intro_type_images_table_<?php echo $lid; ?>" class="s_table" cellpadding="0" cellspacing="0" border="0">
      <thead>
        <tr>
          <td class="first" width="100"><?php echo $text_image; ?></td>
          <td width="23">#</td>
          <td><?php echo $text_url; ?></td>
          <td width="30">&nbsp;</td>
        </tr>
      </thead>
      <tbody>
      <?php if (isset($intro['images'][$lid]['files'])): $image_row = 0; ?>
        <?php foreach ($intro['images'][$lid]['files'] as $image): ?>
        <tr id="image_row_<?php echo $lid; ?>_<?php echo $image_row; ?>" class="image_row">
          <td>
            <input type="hidden" name="intro[images][<?php echo $lid; ?>][files][<?php echo $image_row; ?>][image]" value="<?php echo $image['file']; ?>" id="image_<?php echo $lid; ?>_<?php echo $image_row; ?>"  />
            <img src="<?php echo $image['preview']; ?>" alt="" id="preview_<?php echo $lid; ?>_<?php echo $image_row; ?>" class="image" onclick="image_upload('image_<?php echo $lid; ?>_<?php echo $image_row; ?>', 'preview_<?php echo $lid; ?>_<?php echo $image_row; ?>');" />
          </td>
          <td><input class="ord_num" type="text" name="intro[images][<?php echo $lid; ?>][files][<?php echo $image_row; ?>][order]" value="<?php echo $image['order']; ?>" style="width: 15px;" size="1" /></td>
          <td><input class="url" type="text" name="intro[images][<?php echo $lid; ?>][files][<?php echo $image_row; ?>][url]" value="<?php echo $image['url']; ?>" style="width: 98%;" /></td>
          <td><a onclick="$('#image_row_<?php echo $lid; ?>_<?php echo $image_row; ?>').remove();" class="s_button_close"><?php echo $text_remove; ?></a></td>
        </tr>
        <?php $image_row++; endforeach; ?>
      <?php endif; ?>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="4"><a onclick="addImage('intro_type_images_table_<?php echo $lid; ?>', 'intro', <?php echo $lid; ?>);" class="s_button s_button_2 s_button_green right s_mr_0"><?php echo $text_button_add_image; ?></a></td>
        </tr>
      </tfoot>
    </table>
  </div>
  <?php endforeach; ?>

</div>