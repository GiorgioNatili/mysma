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

    <div id="change_password" class="s_main_col">

      <?php echo $content_top; ?>

      <form id="password_form" class="clearfix" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

        <h2 class="s_title_1"><span><?php echo $text_password; ?></span></h2>

        <div class="s_row_2<?php if ($error_password): ?> s_error_row<?php endif; ?> clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_password; ?></label>
          <input type="password" name="password" id="password" value="<?php echo $password; ?>" size="30" title="<?php echo $this->language->get('error_password'); ?>" />
          <?php if ($error_password): ?>
          <p class="s_error_msg"><?php echo $error_password; ?></p>
          <?php endif; ?>
        </div>

        <div class="s_row_2<?php if ($error_confirm): ?> s_error_row<?php endif; ?>  s_sep clearfix">
          <label><strong class="s_red">*</strong> <?php echo $entry_confirm; ?></label>
          <input type="password" name="confirm" id="confirm" value="<?php echo $confirm; ?>" size="30" title="<?php echo $this->language->get('error_confirm'); ?>" />
          <?php if ($error_confirm): ?>
          <p class="s_error_msg"><?php echo $error_confirm; ?></p>
          <?php endif; ?>
        </div>

        <span class="clear border_ddd s_sep"></span>

        <div class="s_submit clearfix">
          <a class="s_button_1 s_ddd_bgr left" onclick="location = '<?php echo $back; ?>'"><span class="s_text"><?php echo $button_back; ?></span></a>
          <a class="s_button_1 s_main_color_bgr" onclick="$('#password_form').submit();"><span class="s_text"><?php echo $button_continue; ?></span></a>
        </div>

      </form>

      <?php echo $content_bottom; ?>

    </div>

    <?php if ($tbData->common['column_position'] == "right" && $column_right): ?>
    <div id="right_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

    <script type="text/javascript" src="http<?php if($tbData->isHTTPS) echo 's'?>://ajax.aspnetcdn.com/ajax/jquery.validate/1.8.1/jquery.validate.min.js"></script>
    <script type="text/javascript">
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
      $("#password_form").validate({
        rules: {
          password: {
              required: true, minlength: 3
          },
          confirm: {
              required: function(element) {
                  var str = $("#password").val();
  
                  return str.length > 0;
              },
              equalTo: "#password",
              minlength: 3
          }
        }
      });
    </script>

  </div>
  <!-- end of content -->


<?php echo $footer; ?>
