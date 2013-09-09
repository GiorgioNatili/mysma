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

    <div id="order_history" class="s_main_col">

      <?php echo $content_top; ?>
      
      <?php if ($orders): ?>
      <div class="s_orders_listing clearfix">
        <?php foreach ($orders as $order): ?>

        <div class="s_col">
          <div class="s_order clearfix">
            <p class="s_id"><span class="s_999"><?php echo $text_order_id; ?></span> <span class="s_main_color">#<?php echo $order['order_id']; ?></span></p>
            <p class="s_status s_secondary_color"><?php echo $order['status']; ?></p>
            <span class="clear"></span>
            <dl class="clearfix">
              <dt><?php echo $text_date_added; ?></dt>
              <dd><?php echo $order['date_added']; ?></dd>
              <dt><?php echo $text_customer; ?></dt>
              <dd><?php echo $order['name']; ?></dd>
              <dt><?php echo $text_products; ?></dt>
              <dd><?php echo $order['products']; ?></dd>
            </dl>
            <span class="clear border_eee"></span>
            <br />
            <p class="s_total left"><?php echo $order['total']; ?></p>
            <a class="s_details s_main_color right" href="<?php echo $order['href']; ?>"><strong><?php echo $button_view; ?></strong></a><br />
            <a class="s_reorder s_main_color right" href="<?php echo $order['reorder']; ?>"><strong><?php echo $button_reorder; ?></strong></a>
          </div>
        </div>
        <?php endforeach; ?>
      </div>
      <div class="pagination"><?php echo $pagination; ?></div>
      <?php else: ?>
      <p><?php echo $text_empty; ?></p>
      <?php endif; ?>
      
      <span class="clear border_ddd s_sep"></span>
      
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