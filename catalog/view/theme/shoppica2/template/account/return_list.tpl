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

    <div id="return_requests" class="s_main_col">

      <?php echo $content_top; ?>

      <?php if ($returns): ?>
      <div class="s_orders_listing clearfix">
        <?php foreach ($returns as $return): ?>
        <div class="s_col">
          <div class="s_order clearfix">
            <p class="s_id"><span class="s_999"><?php echo $text_return_id; ?></span> <span class="s_secondary_color">#<?php echo $return['return_id']; ?></span></p>
            <dl class="clearfix">
              <dt><?php echo $text_status; ?></dt>
              <dd><?php echo $return['status']; ?></dd>
              <dt><?php echo $text_date_added; ?></dt>
              <dd><?php echo $return['date_added']; ?></dd>
              <dt><?php echo $text_order_id; ?></dt>
              <dd><?php echo $return['order_id']; ?></dd>
              <dt><?php echo $text_customer; ?></dt>
              <dd><?php echo $return['name']; ?></dd>
            </dl>
            <span class="clear border_eee"></span>
            <br />
            <a class="s_main_color right" href="<?php echo $return['href']; ?>"><strong><?php echo $button_view; ?></strong></a>
          </div>
        </div>
        <?php endforeach ?>
      </div>

      <div class="pagination"><?php echo $pagination; ?></div>

      <span class="clear border_ddd s_sep"></span>
      
      <?php else: ?>
      <p class="align_center s_f_16 s_p_20_0"><?php echo $text_empty; ?></p>
      <?php endif; ?>
      
      <div class="s_submit clearfix">
        <a class="s_button_1 s_main_color_bgr" href="<?php echo $continue; ?>"><span class="s_text"><?php echo $button_continue; ?></span></a>
      </div>

      <?php echo $content_bottom; ?>
  
    </div>

    <?php if ($tbData->common['column_position'] == "right" && $column_right): ?>
    <div id="right_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

  </div>
  <!-- end of content -->

<?php echo $footer; ?>