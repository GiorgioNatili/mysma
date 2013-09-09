<?php echo $header; ?>

  <!-- ---------------------- -->
  <!--     I N T R O          -->
  <!-- ---------------------- -->
  <div id="intro">
    <div id="intro_wrap">
      <div class="s_wrap">
        <div id="breadcrumbs" class="s_col_12">
          <?php foreach ($breadcrumbs as $breadcrumb): ?>
          <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
          <?php endforeach; ?>
        </div>
        <h1><?php echo $text_edit_address; ?></h1>
      </div>
    </div>
  </div>
  <!-- end of intro -->

  <!-- ---------------------- -->
  <!--      C O N T E N T     -->
  <!-- ---------------------- -->
  <div id="content" class="s_wrap">
  
    <?php if ($tbData->common['column_position'] == "left" && $column_right): ?>
    <div id="left_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

    <div id="edit_address" class="s_main_col">

      <?php echo $content_top; ?>

      <form id="address_form" class="clearfix" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

        <div class="s_row_2<?php if ($error_firstname): ?> s_error_row<?php endif; ?> clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_firstname; ?></label>
          <input type="text" name="firstname" value="<?php echo $firstname; ?>" size="30" class="required" title="<?php echo $this->language->get('error_firstname'); ?>" />
          <?php if ($error_firstname): ?>
          <p class="s_error_msg"><?php echo $error_firstname; ?></p>
          <?php endif; ?>
        </div>

        <div class="s_row_2<?php if ($error_lastname): ?> s_error_row<?php endif; ?> clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_lastname; ?></label>
          <input type="text" name="lastname" value="<?php echo $lastname; ?>" size="30" class="required" title="<?php echo $this->language->get('error_lastname'); ?>" />
          <?php if ($error_lastname): ?>
          <p class="s_error_msg"><?php echo $error_lastname; ?></p>
          <?php endif; ?>
        </div>

        <div class="s_row_2 clearfix">
          <label><?php echo $entry_company; ?></label>
          <input type="text" name="company" value="<?php echo $company; ?>" size="30" />
        </div>

        <?php if ($company_id_display): ?>
        <div class="s_row_2 clearfix">
          <label><?php echo $entry_company_id; ?></label>
          <input type="text" name="company_id" value="<?php echo $company_id; ?>" size="30" />
          <?php if ($error_company_id): ?>
          <p class="s_error_msg"><?php echo $error_company_id; ?></p>
          <?php endif; ?>
        </div>
        <?php endif; ?>

        <?php if ($tax_id_display): ?>
        <div class="s_row_2 clearfix">
          <label><?php echo $entry_tax_id; ?></label>
          <input type="text" name="tax_id" value="<?php echo $tax_id; ?>" size="30" />
          <?php if ($error_tax_id): ?>
          <p class="s_error_msg"><?php echo $error_tax_id; ?></p>
          <?php endif; ?>
        </div>
        <?php endif; ?>

        <div class="s_row_2<?php if ($error_address_1): ?> s_error_row<?php endif; ?> clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_address_1; ?></label>
          <input type="text" name="address_1" value="<?php echo $address_1; ?>" size="30" class="required" title="<?php echo $this->language->get('error_address_1'); ?>" />
          <?php if ($error_address_1): ?>
          <p class="s_error_msg"><?php echo $error_address_1; ?></p>
          <?php endif; ?>
        </div>

        <div class="s_row_2 clearfix">
          <label><?php echo $entry_address_2; ?></label>
          <input type="text" name="address_2" value="<?php echo $address_2; ?>" size="30" />
        </div>

        <div class="s_row_2<?php if ($error_city): ?> s_error_row<?php endif; ?> clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_city; ?></label>
          <input type="text" name="city" value="<?php echo $city; ?>" size="30" class="required" title="<?php echo $this->language->get('error_city'); ?>" />
          <?php if ($error_city): ?>
          <p class="s_error_msg"><?php echo $error_city; ?></p>
          <?php endif; ?>
        </div>

        <div id="postcode_div" class="s_row_2<?php if ($error_postcode): ?> s_error_row<?php endif; ?> clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_postcode; ?></label>
          <input type="text" id="postcode" name="postcode" value="<?php echo $postcode; ?>" size="30" title="<?php echo $this->language->get('error_postcode'); ?>" />
          <?php if ($error_postcode): ?>
          <p class="s_error_msg"><?php echo $error_postcode; ?></p>
          <?php endif; ?>
        </div>

        <div class="s_row_2<?php if ($error_country) { ?> s_error_row<?php } ?> clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_country; ?></label>
          <select id="country_id" name="country_id" class="required" title="<?php echo $this->language->get('error_country'); ?>">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($countries as $country): ?>
            <?php if ($country['country_id'] == $country_id): ?>
            <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
            <?php else: ?>
            <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
            <?php endif; ?>
            <?php endforeach; ?>
          </select>
          <?php if ($error_country): ?>
          <p class="s_error_msg"><?php echo $error_country; ?></p>
          <?php endif; ?>
        </div>

        <div class="s_row_2<?php if ($error_zone): ?> s_error_row<?php endif; ?> clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_zone; ?></label>
          <select id="zone_id" class="required" name="zone_id" title="<?php echo $this->language->get('error_zone'); ?>"></select>
          <?php if ($error_zone): ?>
          <p class="s_error_msg"><?php echo $error_zone; ?></p>
          <?php endif; ?>
        </div>

        <div class="s_row_2 s_sep clearfix">
          <label><?php echo $entry_default; ?></label>
          <div class="s_full">
            <?php if ($default): ?>
            <label class="s_radio"><input type="radio" name="default" value="1" checked="checked" /> <?php echo $text_yes; ?></label>
            <label class="s_radio"><input type="radio" name="default" value="0" /> <?php echo $text_no; ?></label>
            <?php else: ?>
            <label class="s_radio"><input type="radio" name="default" value="1" /> <?php echo $text_yes; ?></label>
            <label class="s_radio"><input type="radio" name="default" value="0" checked="checked" /> <?php echo $text_no; ?></label>
            <?php endif; ?>
          </div>
        </div>

        <span class="clear border_ddd s_sep"></span>
  
        <div class="s_submit clearfix">
          <a class="s_button_1 s_ddd_bgr left" onclick="location = '<?php echo $back; ?>'"><span class="s_text"><?php echo $button_back; ?></span></a>
          <a class="s_button_1 s_main_color_bgr" onclick="$('#address_form').submit();"><span class="s_text"><?php echo $button_continue; ?></span></a>
        </div>
  
        <?php echo $content_bottom; ?>

      </form>

    </div>

    <?php if ($tbData->common['column_position'] == "right" && $column_right): ?>
    <div id="right_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

  </div>
  <!-- end of content -->

  <script type="text/javascript" src="http<?php if($tbData->isHTTPS) echo 's'?>://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>
  <script type="text/javascript">
  $(document).ready(function() {
    jQuery.validator.setDefaults({
      errorElement: "p",
      errorClass: "s_error_msg",
      errorPlacement: function(error, element) {
        error.insertAfter(element);
      },
      highlight: function(element, errorClass, validClass) {
        $(element).addClass("error_element").removeClass(validClass);
        $(element).parent("div").addClass("s_error_row");
      },
      unhighlight: function(element, errorClass, validClass) {
        $(element).removeClass("error_element").addClass(validClass);
        $(element).parent("div").removeClass("s_error_row");
      }
    });
    $("#address_form").validate();
  });
  </script>

  <script type="text/javascript">
  $(document).ready(function() {
    $('select[name=\'country_id\']').bind('change', function(event, first_time) {
      $.ajax({
        url: 'index.php?route=account/address/country&country_id=' + this.value,
        dataType: 'json',
        beforeSend: function() {
          $('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
        },
        complete: function() {
          $('.wait').remove();
        },
        success: function(json) {
          if (json['postcode_required'] == '1') {
            $('#postcode_div strong.s_red').show();
            $('#postcode').removeClass("required").addClass("required");
          } else {
            $('#postcode_div strong.s_red').hide();
            $('#postcode').removeClass("required");
            if (typeof first_time === "undefined") {
              $("#address_form").validate().element('#postcode');
            }
          }

          var html = '<option value=""><?php echo $text_select; ?></option>';
          var selected = false;
          if (json['zone'] && json['zone'] != '') {
            for (i = 0; i < json['zone'].length; i++) {
              html += '<option value="' + json['zone'][i]['zone_id'] + '"';

              if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
                html += ' selected="selected"';
                selected = true;
              }

              html += '>' + json['zone'][i]['name'] + '</option>';
            }
          } else {
            html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
          }

          $('select[name=\'zone_id\']').html(html);
          if(typeof first_time === "undefined" && selected) {
            $("#address_form").validate().element('#address_form select[name="zone_id"]');
          }
        },
        error: function(xhr, ajaxOptions, thrownError) {
          alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
      });
    });

    $('select[name=\'country_id\']').trigger('change', ['first_time']);
  });
  </script>

<?php echo $footer; ?>