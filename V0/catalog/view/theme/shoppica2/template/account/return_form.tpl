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

    <div id="return_request" class="s_main_col">

      <?php echo $content_top; ?>

      <?php if ($error_warning) : ?>
      <div class="s_server_msg s_msg_red"><p><?php echo $error_warning; ?></p></div>
      <?php endif; ?>

      <?php echo $text_description; ?>
      
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="return">

        <h2><?php echo $text_order; ?></h2>
        
        <div class="s_row_2 clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_firstname; ?></label>
          <input type="text" name="firstname" value="<?php echo $firstname; ?>" size="30" />
          <?php if ($error_firstname): ?>
          <p class="s_error_msg"><?php echo $error_firstname; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2 clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_lastname; ?></label>
          <input type="text" name="lastname" value="<?php echo $lastname; ?>" size="30" />
          <?php if ($error_lastname): ?>
          <p class="s_error_msg"><?php echo $error_lastname; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2 clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_email; ?></label>
          <input type="text" name="email" value="<?php echo $email; ?>" size="30" />
          <?php if ($error_email): ?>
          <p class="s_error_msg"><?php echo $error_email; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2 clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_telephone; ?></label>
          <input type="text" name="telephone" value="<?php echo $telephone; ?>" size="30" />
          <?php if ($error_telephone): ?>
          <p class="s_error_msg"><?php echo $error_telephone; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2 clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_order_id; ?></label>
          <input type="text" name="order_id" value="<?php echo $order_id; ?>" size="30" />
          <?php if ($error_order_id): ?>
          <p class="s_error_msg"><?php echo $error_order_id; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2 clearfix">
          <label><?php echo $entry_date_ordered; ?></label>
          <input type="text" name="date_ordered" value="<?php echo $date_ordered; ?>" size="30" class="date" />
        </div>
        
        <span class="clear s_sep"></span>

        <div class="s_box_1 clearfix">
          <h2 class="left s_secondary_color"><?php echo $text_product; ?></h2>
          <div id="return_product" class="s_product_row">
            <div class="s_row_2 clearfix">
              <label><strong class="s_red">*</strong> <?php echo $entry_product; ?></label>
              <input type="text" name="product" value="<?php echo $product; ?>" />
              <?php if ($error_product): ?>
              <p class="s_error_msg"><?php echo $error_product; ?></p>
              <?php endif; ?>
            </div>
            <div class="s_row_2 clearfix">
              <label><strong class="s_red">*</strong> <?php echo $entry_model; ?></label>
              <input type="text" name="model" value="<?php echo $model; ?>" />
              <?php if ($error_model): ?>
              <p class="s_error_msg"><?php echo $error_model; ?></p>
              <?php endif; ?>
            </div>
            <div class="s_row_2 clearfix">
              <label><?php echo $entry_quantity; ?></label>
              <input type="text" name="quantity" value="<?php echo $quantity; ?>" />
            </div>
            <div class="s_row_2 clearfix">
              <label><strong class="s_red">*</strong> <?php echo $entry_reason; ?></label>
              <div class="s_full">
                <?php foreach ($return_reasons as $return_reason): ?>
                <?php if ($return_reason['return_reason_id'] == $return_reason_id): ?>
                <label class="s_radio" for="return-reason-id<?php echo $return_reason['return_reason_id']; ?>"> 
                  <input type="radio" name="return_reason_id" value="<?php echo $return_reason['return_reason_id']; ?>" id="return-reason-id<?php echo $return_reason['return_reason_id']; ?>" checked="checked" />
                  <?php echo $return_reason['name']; ?>
                </label>
                <?php else: ?>
                <label class="s_radio" for="return-reason-id<?php echo $return_reason['return_reason_id']; ?>"> 
                  <input type="radio" name="return_reason_id" value="<?php echo $return_reason['return_reason_id']; ?>" id="return-reason-id<?php echo $return_reason['return_reason_id']; ?>" />
                  <?php echo $return_reason['name']; ?>
                </label>
                <?php endif; ?>
                <?php endforeach; ?>
                <?php if ($error_reason): ?>
                <span class="clear"></span>
                <p class="s_error_msg"><?php echo $error_reason; ?></p>
                <?php endif; ?>
              </div>
            </div>
            <div class="s_row_2 clearfix">
              <label><?php echo $entry_opened; ?></label>
              <div class="s_full clearfix">
                <label class="s_radio" for="opened">
                  <input type="radio" name="opened" value="1" id="opened"<?php if ($opened): ?> checked="checked"<?php endif; ?> />
                	<?php echo $text_yes; ?>
                </label>
                <label class="s_radio" for="unopened">
                	<input type="radio" name="opened" value="0" id="unopened"<?php if (!$opened): ?> checked="checked"<?php endif; ?> />
                  <?php echo $text_no; ?>
                </label>
              </div>
            </div>
            <div class="s_row_2 clearfix">
              <label><?php echo $entry_fault_detail; ?></label>
              <div class="s_full clearfix">
                <textarea name="comment" cols="45" rows="6"><?php echo $comment; ?></textarea>
              </div>
            </div>
          </div>
            
        </div>
        
        <div class="s_row_3 clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_captcha; ?></label>
          <input type="text" name="captcha" value="<?php echo $captcha; ?>" />
          <span class="clear"></span>
          <br />
          <img src="index.php?route=account/return/captcha" alt="" />
          <?php if ($error_captcha): ?>
          <p class="s_error_msg"><?php echo $error_captcha; ?></p>
          <?php endif; ?>
        </div>

        <span class="clear s_mb_25 border_eee"></span>

        <div class="s_submit clearfix">
          <a href="<?php echo $back; ?>" class="s_button_1 s_ddd_bgr left"><span class="s_text"><?php echo $button_back; ?></span></a>
          <?php if ($text_agree): ?>
          <div class="right"><?php echo $text_agree; ?>
            <?php if ($agree): ?>
            <input type="checkbox" name="agree" value="1" checked="checked" />
            <?php else: ?>
            <input type="checkbox" name="agree" value="1" />
            <?php endif; ?>
            <input type="submit" value="<?php echo $button_continue; ?>" class="button" />
            </div>
          <?php endif; ?>
          <a class="s_button_1 s_main_color_bgr" onclick="$('#return').submit();"><span class="s_text"><?php echo $button_continue; ?></span></a>
        </div>

      </form>
  
      <?php echo $content_bottom; ?>
      
    </div>
    
    <?php if ($tbData->common['column_position'] == "right" && $column_right): ?>
    <div id="right_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

    <link rel="stylesheet" type="text/css" href="<?php echo $tbData->theme_stylesheet_url; ?>jquery_ui/jquery-ui-1.8.14.custom.css" media="screen" />
    <script type="text/javascript"><!--
    $(document).ready(function() {
      $('.date').datepicker({
        dateFormat: 'yy-mm-dd',
        beforeShow: function(input, inst) {
          var newclass = 's_jquery_ui';
          if (!inst.dpDiv.parent().hasClass('s_jquery_ui')) {
            inst.dpDiv.wrap('<div class="'+newclass+'"></div>')
          }
        } 
      });
    });
    //--></script> 

  </div>
  <!-- end of content -->


<?php echo $footer; ?>