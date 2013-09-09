  <div id="product_options">
    <h3><?php echo $text_option; ?></h3>

    <?php foreach ($options as $option): ?>

    <?php if ($option['type'] == 'select'): ?>
    <div id="option-<?php echo $option['product_option_id']; ?>" class="s_row_2 clearfix">
      <label>
        <?php if ($option['required']): ?>
        <strong class="s_red">*</strong>
        <?php endif; ?>
        <?php echo $option['name']; ?>
      </label>
      <div class="s_full clearfix">
        <select name="option[<?php echo $option['product_option_id']; ?>]">
          <option value=""><?php echo $text_select; ?></option>
          <?php foreach ($option['option_value'] as $option_value): ?>
          <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
          <?php if ($option_value['price']): ?>
          (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
          <?php endif; ?>
          </option>
          <?php endforeach; ?>
        </select>
      </div>
    </div>
    <?php endif; ?>

    <?php if ($option['type'] == 'radio'): ?>
    <div id="option-<?php echo $option['product_option_id']; ?>" class="s_row_2 clearfix">
      <label>
        <?php if ($option['required']): ?>
        <strong class="s_red">*</strong>
        <?php endif; ?>
        <?php echo $option['name']; ?>
      </label>
      <div class="s_full clearfix">
        <?php foreach ($option['option_value'] as $option_value): ?>
        <label class="s_radio" for="option-value-<?php echo $option_value['product_option_value_id']; ?>">
          <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <?php echo $option_value['name']; ?>
          <?php if ($option_value['price']): ?>
          (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
          <?php endif; ?>
        </label>
        <span class="clear"></span>
        <?php endforeach; ?>
      </div>
    </div>
    <?php endif; ?>

    <?php if ($option['type'] == 'checkbox'): ?>
    <div id="option-<?php echo $option['product_option_id']; ?>" class="s_row_2 clearfix">
      <label>
        <?php if ($option['required']): ?>
        <strong class="s_red">*</strong>
        <?php endif; ?>
        <?php echo $option['name']; ?>
      </label>
      <div class="s_full clearfix">
        <?php foreach ($option['option_value'] as $option_value): ?>
        <label class="s_checkbox" for="option-value-<?php echo $option_value['product_option_value_id']; ?>">
          <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <?php echo $option_value['name']; ?>
          <?php if ($option_value['price']): ?>
          (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
          <?php endif; ?>
        </label>
        <span class="clear"></span>
        <?php endforeach; ?>
      </div>
    </div>
    <?php endif; ?>

    <?php if ($option['type'] == 'image'): ?>
    <div id="option-<?php echo $option['product_option_id']; ?>" class="s_image_option s_row_2 clearfix">
      <label>
        <?php if ($option['required']): ?>
        <strong class="s_red">*</strong>
        <?php endif; ?>
        <?php echo $option['name']; ?>
      </label>
      <div class="s_full clearfix">
        <?php foreach ($option['option_value'] as $option_value): ?>
        <label class="s_image" for="option-value-<?php echo $option_value['product_option_value_id']; ?>">
          <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" />
          <span class="s_label">
            <span class="s_radio">
              <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
              <?php echo $option_value['name']; ?>
              <?php if ($option_value['price']): ?>
              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
              <?php endif; ?>
            </span>
          </span>
        </label>
        <?php endforeach; ?>
      </div>
    </div>
    <?php endif; ?>

    <?php if ($option['type'] == 'text'): ?>
    <div id="option-<?php echo $option['product_option_id']; ?>" class="s_row_2 clearfix">
      <label>
        <?php if ($option['required']): ?>
        <strong class="s_red">*</strong>
        <?php endif; ?>
        <?php echo $option['name']; ?>
      </label>
      <div class="s_full clearfix">
        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
      </div>
    </div>
    <?php endif; ?>

    <?php if ($option['type'] == 'textarea'): ?>
    <div id="option-<?php echo $option['product_option_id']; ?>" class="s_row_2 clearfix">
      <label>
        <?php if ($option['required']): ?>
        <strong class="s_red">*</strong>
        <?php endif; ?>
        <?php echo $option['name']; ?>
      </label>
      <div class="s_full clearfix">
        <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
      </div>
    </div>
    <?php endif; ?>

    <?php if ($option['type'] == 'file'): ?>
    <div id="option-<?php echo $option['product_option_id']; ?>" class="s_row_2 clearfix">
      <label>
        <?php if ($option['required']): ?>
        <strong class="s_red">*</strong>
        <?php endif; ?>
        <?php echo $option['name']; ?>
      </label>
      <a id="button-option-<?php echo $option['product_option_id']; ?>" class="s_button_1 s_button_1_small s_main_color_bgr"><span class="s_text"><?php echo $button_upload; ?></span></a>
      <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
    </div>
    <?php endif; ?>

    <?php if ($option['type'] == 'date'): ?>
    <div id="option-<?php echo $option['product_option_id']; ?>" class="s_row_2 clearfix">
      <label>
        <?php if ($option['required']): ?>
        <strong class="s_red">*</strong>
        <?php endif; ?>
        <?php echo $option['name']; ?>
      </label>
      <div class="s_full clearfix">
        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
      </div>
    </div>
    <?php endif; ?>

    <?php if ($option['type'] == 'datetime'): ?>
    <div id="option-<?php echo $option['product_option_id']; ?>" class="s_row_2 clearfix">
      <label>
        <?php if ($option['required']): ?>
        <strong class="s_red">*</strong>
        <?php endif; ?>
        <?php echo $option['name']; ?>
      </label>
      <div class="s_full clearfix">
        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
      </div>
    </div>
    <?php endif; ?>

    <?php if ($option['type'] == 'time'): ?>
    <div id="option-<?php echo $option['product_option_id']; ?>" class="s_row_2 clearfix">
      <label>
        <?php if ($option['required']): ?>
        <strong class="s_red">*</strong>
        <?php endif; ?>
        <?php echo $option['name']; ?>
      </label>
      <div class="s_full clearfix">
        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
      </div>
    </div>
    <?php endif; ?>

  <?php endforeach; ?>

  <script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
  <script type="text/javascript">
  <?php foreach ($options as $option): ?>
    <?php if ($option['type'] == 'file'): ?>
    new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
      action: 'index.php?route=product/product/upload',
      name: 'file',
      autoSubmit: true,
      responseType: 'json',
      onSubmit: function(file, extension) {
        $('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" id="loading" style="padding-left: 5px;" />');
      },
      onComplete: function(file, json) {
        $('.s_error_msg').remove();

        if (json.success) {
          alert(json.success);

          $('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json.file);
        }

        if (json.error) {
          $('#option-<?php echo $option['product_option_id']; ?>').append('<p class="s_error_msg">' + json.error + '</p>');
        }

        $('#loading').remove();
      }
    });
    <?php endif; ?>
  <?php endforeach; ?>
  </script>

  <link rel="stylesheet" type="text/css" href="<?php echo $tbData->theme_stylesheet_url; ?>jquery_ui/jquery-ui-1.8.14.custom.css" media="screen" />
  <script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script>
  <script type="text/javascript">
  jQuery(document).ready(function () {
    $('.date').datepicker({
      dateFormat: 'yy-mm-dd',
      beforeShow: function(input, inst) {
        var newclass = 's_jquery_ui';
        if (!inst.dpDiv.parent().hasClass('s_jquery_ui')) {
          inst.dpDiv.wrap('<div class="'+newclass+'"></div>')
        }
      }
    });
    $('.datetime').datetimepicker({
      dateFormat: 'yy-mm-dd',
      timeFormat: 'h:m',
      beforeShow: function(input, inst) {
        var newclass = 's_jquery_ui';
        if (!inst.dpDiv.parent().hasClass('s_jquery_ui')) {
          inst.dpDiv.wrap('<div class="'+newclass+'"></div>')
        }
      }
    });
    $('.time').timepicker({
      timeFormat: 'h:m',
      beforeShow: function(input, inst) {
        var newclass = 's_jquery_ui';
        if (!inst.dpDiv.parent().hasClass('s_jquery_ui')) {
          inst.dpDiv.wrap('<div class="'+newclass+'"></div>')
        }
      }
    });
  });
  </script>

</div>
