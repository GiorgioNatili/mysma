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

    <div id="login_page" class="s_main_col">

      <?php echo $content_top; ?>

      <?php if ($success): ?>
      <div class="s_server_msg s_msg_green"><p><?php echo $success; ?></p></div>
      <?php endif; ?>
      <?php if ($error_warning) : ?>
      <div class="s_server_msg s_msg_red"><p><?php echo $error_warning; ?></p></div>
      <?php endif; ?>

      <?php echo $text_description; ?>

      <span class="clear s_sep s_pt_10 border_ddd"></span>
      
      <div class="s_2col_wrap clearfix">
      
        <div class="s_col s_1_2">
          <h2 class="s_title_1"><span><?php echo $text_new_affiliate; ?></span></h2>
          <div class="s_row_3 s_h_170 clearfix">
            <?php echo $text_register_account; ?>
          </div>
          <span class="clear s_sep border_ddd"></span>
          <a href="<?php echo $register; ?>" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
        </div>

        <div class="s_col s_1_2">
          <h2 class="s_title_1"><span><?php echo $text_returning_affiliate; ?></span></h2>
          <form id="login" class="clearfix" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
            <div class="s_row_3 clearfix">
              <?php echo $text_i_am_returning_affiliate; ?><br /><br />
              <label><strong><?php echo $entry_email; ?></strong></label>
              <input type="text" name="email" value="<?php echo $email; ?>" size="35" class="required email" title="<?php echo $tbData->text_error_email ?>" />
            </div>
            <div class="s_row_3 s_sep clearfix">
              <span class="clear"></span>
              <label><strong><?php echo $entry_password; ?></strong></label>
              <input type="password" name="password" value="<?php echo $password; ?>" size="35" class="required" title="<?php echo $tbData->text_error_password ?>" />
            </div>

            <span class="clear s_sep border_ddd"></span>
						
            <div class="s_submit clearfix">
              <div class="s_nav s_size_2 left">
                <ul class="s_mb_0 clearfix">
                  <li><a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></li>
                </ul>
              </div>
              <a class="s_button_1 s_main_color_bgr" onclick="$('#login').submit();"><span class="s_text"><?php echo $button_login; ?></span></a>
              <?php if ($redirect): ?>
              <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
              <?php endif; ?>
            </div>
          </form>
        </div>
      </div>

      <?php echo $content_bottom; ?>

    </div>

    <?php if ($tbData->common['column_position'] == "right" && $column_right): ?>
    <div id="right_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

    <script type="text/javascript" src="http<?php if($tbData->isHTTPS) echo 's'?>://ajax.aspnetcdn.com/ajax/jquery.validate/1.8/jquery.validate.min.js"></script>
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
      $("#login").validate();
    </script>

  </div>
  <!-- end of content -->
  

<?php echo $footer; ?>