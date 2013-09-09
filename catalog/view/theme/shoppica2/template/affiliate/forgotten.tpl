<?php echo $header; ?>

  <!-- ---------------------- -->
  <!--     I N T R O          -->
  <!-- ---------------------- -->
  <div id="intro">
    <div id="intro_wrap">
      <div class="s_wrap">
        <div id="breadcrumbs" class="s_col_12">
          <?php foreach ($breadcrumbs as $breadcrumb) { ?>
          <?php echo $breadcrumb['separator']; ?><a href="<?php echo str_replace('&', '&amp;', $breadcrumb['href']); ?>"><?php echo $breadcrumb['text']; ?></a>
          <?php } ?>
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

    <div id="forgotten_password" class="s_main_col">

      <?php if ($error_warning) { ?>
      <div class="s_msg_red s_server_msg"><p><?php echo $error_warning; ?></p></div>
      <?php } ?>

      <form  id="forgotten" class="clearfix" action="<?php echo str_replace('&', '&amp;', $action); ?>" method="post" enctype="multipart/form-data">
        <p><?php echo $text_email; ?></p>

        <div class="s_row_2 s_sep clearfix">
          <label><?php echo $entry_email; ?></label>
          <input type="text" name="email" size="30" />
        </div>

        <span class="clear s_sep border_ddd"></span>
        
        <div class="s_submit clearfix">
          <a class="s_button_1 s_ddd_bgr left" onclick="location = '<?php echo str_replace('&', '&amp;', $back); ?>'"><span class="s_text"><?php echo $button_back; ?></span></a>
          <a class="s_button_1 s_main_color_bgr" onclick="$('#forgotten').submit();"><span class="s_text"><?php echo $button_continue; ?></span></a>
        </div>

      </form>
      
    </div>

    <?php if ($tbData->common['column_position'] == "right" && $column_right): ?>
    <div id="right_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

  </div>
  <!-- end of content -->


<?php echo $footer; ?>
