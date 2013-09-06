  <form id="guest_shipping_form">

    <div class="left s_1_2">

      <div class="s_row_2 clearfix">
        <label><strong class="s_red">*</strong> <?php echo $entry_firstname; ?></label>
        <input type="text" name="firstname" value="<?php echo $firstname; ?>" size="30" class="required" title="<?php echo $this->language->get('error_firstname'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><strong class="s_red">*</strong> <?php echo $entry_lastname; ?></label>
        <input type="text" name="lastname" value="<?php echo $lastname; ?>" size="30" class="required" title="<?php echo $this->language->get('error_lastname'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_company; ?></label>
        <input type="text" name="company" value="<?php echo $company; ?>" size="30" />
      </div>

      <div class="s_row_2 clearfix">
        <label><strong class="s_red">*</strong> <?php echo $entry_address_1; ?></label>
        <input type="text" name="address_1" value="<?php echo $address_1; ?>" size="30" class="required" title="<?php echo $this->language->get('error_address_1'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_address_2; ?></label>
        <input type="text" name="address_2" value="<?php echo $address_2; ?>" size="30" />
      </div>

    </div>

    <div class="left s_1_2">

      <div class="s_row_2 clearfix">
        <label><strong class="s_red">*</strong> <?php echo $entry_city; ?></label>
        <input type="text" name="city" value="<?php echo $city; ?>" size="30" class="required" title="<?php echo $this->language->get('error_city'); ?>" />
      </div>

      <div class="postcode_div s_row_2 clearfix">
        <label><strong class="s_red">*</strong> <?php echo $entry_postcode; ?></label>
        <input type="text" name="postcode" value="<?php echo $postcode; ?>" size="30" class="required" title="<?php echo $this->language->get('error_postcode'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
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
      </div>

      <div class="s_row_2 clearfix">
        <label><strong class="s_red">*</strong> <?php echo $entry_zone; ?></label>
        <select id="zone_id" name="zone_id" class="required" title="<?php echo $this->language->get('error_zone'); ?>"></select>
      </div>

    </div>
    
  </form>
  
  <span class="clear s_sep"></span>

  <div class="s_submit clearfix">
    <a id="button-guest-shipping" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
  </div>

  <script type="text/javascript">
  $(document).ready(function() {
    $("#guest_shipping_form").validate();
  });
  </script>

  <script type="text/javascript">
  $(document).ready(function() {
    $('#shipping-address select[name=\'country_id\']').bind('change', function(event, first_time) {
      if (this.value == '') return;
      $.ajax({
        url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
        dataType: 'json',
        beforeSend: function() {
          $('#shipping-address select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
        },
        complete: function() {
          $('.wait').remove();
        },
        success: function(json) {
          if (json['postcode_required'] == '1') {
            $('#guest_shipping_form .postcode_div .s_red').show();
            $('#guest_shipping_form input[name=\'postcode\']').removeClass("required").addClass("required");
          } else {
            $('#guest_shipping_form .postcode_div .s_red').hide();
            $('#guest_shipping_form input[name=\'postcode\']').removeClass("required");
            if(typeof first_time === "undefined") {
              $("#guest_shipping_form").validate().element('#guest_shipping_form input[name="postcode"]');
            }
          }

          var html = '<option value=""><?php echo $text_select; ?></option>';
          var selected = false;
          if (json['zone'] != '') {
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

          $('#shipping-address select[name=\'zone_id\']').html(html);
          if(typeof first_time === "undefined" && selected) {
            $("#guest_shipping_form").validate().element('#guest_shipping_form select[name="zone_id"]');
          }
        },
        error: function(xhr, ajaxOptions, thrownError) {
          alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
      });
    });

    $('#shipping-address select[name=\'country_id\']').trigger('change', ['first_time']);
  });
  </script>