  <div class="s_row_3 clearfix">
    <?php if ($addresses): ?>
    <label class="s_checkbox" for="shipping-address-existing">
      <input type="radio" name="shipping_address" value="existing" id="shipping-address-existing" checked="checked" />
      <?php echo $text_address_existing; ?>
    </label>
    <div id="shipping-existing" class="s_mb_20 clearfix">
      <select name="address_id" id="shipping_address_id" size="5" style="min-width: 406px;">
        <?php foreach ($addresses as $address): ?>
        <?php if ($address['address_id'] == $address_id): ?>
        <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['country']; ?></option>
        <?php else: ?>
        <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['country']; ?></option>
        <?php endif; ?>
        <?php endforeach; ?>
      </select>
    </div>
    <span class="clear"></span>
    <label class="s_checkbox" for="shipping-address-new"> <input type="radio" name="shipping_address" value="new" id="shipping-address-new" /> <?php echo $text_address_new; ?></label>
    <?php endif; ?>
  </div>

  <form id="shipping_form" class="s_address"<?php if ($addresses): ?> style="display: none;"<?php endif; ?>>

    <div class="s_row_2 clearfix">
      <label><strong class="s_red">*</strong> <?php echo $entry_firstname; ?></label>
      <input type="text" name="firstname" value="" size="30" class="required" title="<?php echo $this->language->get('error_firstname'); ?>" />
    </div>

    <div class="s_row_2 clearfix">
      <label><strong class="s_red">*</strong> <?php echo $entry_lastname; ?></label>
      <input type="text" name="lastname" value="" size="30" class="required" title="<?php echo $this->language->get('error_lastname'); ?>" />
    </div>

    <div class="s_row_2 clearfix">
      <label><?php echo $entry_company; ?></label>
      <input type="text" name="company" value="" size="30" />
    </div>

    <div class="s_row_2 clearfix">
      <label><strong class="s_red">*</strong> <?php echo $entry_address_1; ?></label>
      <input type="text" name="address_1" value="" size="30" class="required" title="<?php echo $this->language->get('error_address_1'); ?>" />
    </div>

    <div class="s_row_2 clearfix">
      <label><?php echo $entry_address_2; ?></label>
      <input type="text" name="address_2" value="" size="30" />
    </div>

    <div class="s_row_2 clearfix">
      <label><strong class="s_red">*</strong> <?php echo $entry_city; ?></label>
      <input type="text" name="city" value="" size="30" class="required" title="<?php echo $this->language->get('error_city'); ?>" />
    </div>

    <div class="postcode_div s_row_2 clearfix">
      <label><strong class="s_red">*</strong> <?php echo $entry_postcode; ?></label>
      <input type="text" name="postcode" value="<?php echo $postcode; ?>" size="30" title="<?php echo $this->language->get('error_postcode'); ?>" />
    </div>

    <div class="s_row_2 clearfix">
      <label><strong class="s_red">*</strong> <?php echo $entry_country; ?></label>
      <select name="country_id" id="country_id" class="required" title="<?php echo $this->language->get('error_country'); ?>">
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
      <select id="zone_id" class="required" name="zone_id" title="<?php echo $this->language->get('error_zone'); ?>"></select>
    </div>

  </form>

  <span class="clear s_mb_20 border_eee"></span>

  <div class="s_submit clearfix">
    <a id="button-shipping-address" class="shipping_button-address s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
  </div>

  <script type="text/javascript">
  $(document).ready(function() {
    $("#shipping_form").validate();
    if($("#shipping_address_id option:selected").length == 0) {
      $("#shipping_address_id option:first").attr("selected", "selected");
    }
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
            $('#shipping_form .postcode_div .s_red').show();
            $('#shipping_form input[name=\'postcode\']').removeClass("required").addClass("required");
          } else {
            $('#shipping_form .postcode_div .s_red').hide();
            $('#shipping_form input[name=\'postcode\']').removeClass("required");
            if(typeof first_time === "undefined") {
              $("#shipping_form").validate().element('#shipping_form input[name="postcode"]');
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

          $('#shipping-address select[name=\'zone_id\']').html(html);
          if(typeof first_time === "undefined" && selected) {
            $("#shipping_form").validate().element('#shipping_form select[name="zone_id"]');
          }
        },
        error: function(xhr, ajaxOptions, thrownError) {
          alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
      });
    });

    $('#shipping-address select[name=\'country_id\']').trigger('change', ['first_time']);

    $('#shipping-address input[name=\'shipping_address\']').live('change', function() {
      if (this.value == 'new') {
        $('#shipping-existing').hide();
        $('#shipping_form').show();
      } else {
        $('#shipping-existing').show();
        $('#shipping_form').hide();
      }
    });
  });
  </script>
