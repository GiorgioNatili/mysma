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
        <h1><?php echo $heading_title; ?></h1>
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

    <div id="payment_preferences" class="s_main_col">

      <?php echo $content_top; ?>

      <form id="payment_preferences_form" class="clearfix" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

        <h2 class="s_title_1"><span><?php echo $text_your_payment; ?></span></h2>

        <div class="s_row_2 clearfix">
          <label><?php echo $entry_tax; ?></label>
          <input type="text" name="tax" size="30" value="<?php echo $tax; ?>" />
        </div>
        <div class="s_row_2 clearfix">
          <label><?php echo $entry_payment; ?></label>
          <div class="s_full clearfix">
            <?php if ($payment == 'cheque') { ?>
            <label  class="s_checkbox" for="cheque"><input type="radio" name="payment" value="cheque" id="cheque" checked="checked" /> <?php echo $text_cheque; ?></label>
            <?php } else { ?>
            <label class="s_checkbox" for="cheque"><input type="radio" name="payment" value="cheque" id="cheque" /> <?php echo $text_cheque; ?></label>
            <?php } ?>
            <?php if ($payment == 'paypal') { ?>
            <label class="s_checkbox" for="paypal"><input type="radio" name="payment" value="paypal" id="paypal" checked="checked" /> <?php echo $text_paypal; ?></label>
            <?php } else { ?>
            <label class="s_checkbox" for="paypal"><input type="radio" name="payment" value="paypal" id="paypal" /> <?php echo $text_paypal; ?></label>
            <?php } ?>
            <?php if ($payment == 'bank') { ?>
            <label class="s_checkbox" for="bank"><input type="radio" name="payment" value="bank" id="bank" checked="checked" /> <?php echo $text_bank; ?></label>
            <?php } else { ?>
            <label class="s_checkbox" for="bank"><input type="radio" name="payment" value="bank" id="bank" /> <?php echo $text_bank; ?></label>
            <?php } ?>
          </div>
        </div>
        <div id="payment-cheque" class="payment s_row_2 s_sep clearfix">
          <label><?php echo $entry_cheque; ?></label>
          <input type="text" name="cheque" size="30" value="<?php echo $cheque; ?>" />
        </div>
        <div id="payment-paypal" class="payment s_row_2 s_sep clearfix">
          <label><?php echo $entry_paypal; ?></label>
          <input type="text" name="paypal" size="30" value="<?php echo $paypal; ?>" />
        </div>
        <div id="payment-bank" class="payment s_sep">
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_name; ?></label>
            <input type="text" name="bank_name" size="30" value="<?php echo $bank_name; ?>" />
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_branch_number; ?></label>
            <input type="text" name="bank_branch_number" size="30" value="<?php echo $bank_branch_number; ?>" />
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_swift_code; ?></label>
            <input type="text" name="bank_swift_code" size="30" value="<?php echo $bank_swift_code; ?>" />
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_account_name; ?></label>
            <input type="text" name="bank_account_name" size="30" value="<?php echo $bank_account_name; ?>" />
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_account_number; ?></label>
            <input type="text" name="bank_account_number" size="30" value="<?php echo $bank_account_number; ?>" />
          </div>
        </div>

        <span class="clear border_ddd s_sep"></span>

        <div class="s_submit clearfix">
          <a class="s_button_1 s_ddd_bgr left" onclick="location = '<?php echo $back; ?>'"><span class="s_text"><?php echo $button_back; ?></span></a>
          <a class="s_button_1 s_main_color_bgr" onclick="$('#payment_preferences_form').submit();"><span class="s_text"><?php echo $button_continue; ?></span></a>
        </div>

      </form>

      <?php echo $content_bottom; ?>

    </div>

    <?php if ($tbData->common['column_position'] == "right" && $column_right): ?>
    <div id="right_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

    <script type="text/javascript"><!--
      $('input[name=\'payment\']').bind('change', function() {
        $('.payment').hide();
        $('#payment-' + this.value).show();
      });
      $('input[name=\'payment\']:checked').trigger('change');
    //--></script> 

  </div>
  <!-- end of content -->
  

<?php echo $footer; ?>
