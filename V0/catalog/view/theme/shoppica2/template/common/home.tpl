<?php echo $header; ?>

  <?php if(!empty($tbData->introHTML)): ?>
  <!-- ---------------------- -->
  <!--     I N T R O          -->
  <!-- ---------------------- -->
  <div id="intro">
    <?php echo $tbData->introHTML; ?>
  </div>
  <!-- end of intro -->
  <?php endif; ?>

  <?php if ($content_top || $content_bottom || $column_right): ?>
  <!-- ---------------------- -->
  <!--      C O N T E N T     -->
  <!-- ---------------------- -->
  <div id="content" class="s_wrap">
  
    <?php if ($tbData->common['column_position'] == "left" && $column_right): ?>
    <div id="left_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>
    
    <div id="home" class="s_main_col">

      <?php echo $content_top; ?>

      <?php echo $content_bottom; ?>
    
    </div>

    <?php if ($tbData->common['column_position'] == "right" && $column_right): ?>
    <div id="right_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

  </div>
  <!-- end of content -->
  <?php endif; ?>

<?php echo $footer; ?>
