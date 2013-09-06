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

    <div id="return_request_info" class="s_main_col">

      <?php echo $content_top; ?>

      <div class="s_order clearfix">

        <p class="s_status"><span class="s_999"><?php echo $text_order_id; ?></span> <span class="s_secondary_color">#<?php echo $order_id; ?></span></p>

        <p class="s_id"><span class="s_999"><?php echo $text_return_id; ?></span> <span class="s_main_color">#<?php echo $return_id; ?></span></p>

        <span class="clear s_sep border_eee"></span>
        
        <dl class="s_1_2 clearfix">
          <dt><?php echo $text_date_ordered; ?></dt>
          <dd><?php echo $date_ordered; ?></dd>
          <dt><?php echo $text_date_added; ?></dt>
          <dd><?php echo $date_added; ?></dd>
        </dl>
        
        <span class="clear s_sep border_eee"></span>
        
        <h2><?php echo $text_product; ?></h2>
        
        <table class="s_table" width="100%" cellpadding="0" cellspacing="0" border="0">
	  <?php if ($tbData->is_mobile == "0"): ?>
          <thead>
            <tr>
              <th><?php echo $column_product; ?></th>
              <th><?php echo $column_model; ?></th>
              <th><?php echo $column_quantity; ?></th>
              <th><?php echo $column_reason; ?></th>
              <th><?php echo $column_opened; ?></th>
              <th><?php echo $column_action; ?></th>
            </tr>
          </thead>
          </thead>
          <tbody>
            <tr>
              <td><?php echo $product; ?></td>
              <td><?php echo $model; ?></td>
              <td><?php echo $quantity; ?></td>
              <td><?php echo $reason; ?></td>
              <td><?php echo $opened; ?></td>
              <td><?php echo $action; ?></td>
            </tr>
          </tbody>
	  <?php else: ?>
          <thead>
            <tr>
              <th><?php echo $column_product; ?></th>
              <th><?php echo $column_model; ?></th>
              <th><?php echo $column_quantity; ?></th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><?php echo $product; ?></td>
              <td><?php echo $model; ?></td>
              <td><?php echo $quantity; ?></td>
            </tr>
          </tbody>
          <thead>
            <tr>
              <th><?php echo $column_reason; ?></th>
              <th><?php echo $column_opened; ?></th>
              <th><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><?php echo $reason; ?></td>
              <td><?php echo $opened; ?></td>
              <td><?php echo $action; ?></td>
            </tr>
          </tbody>
	  <?php endif; ?>
        </table>
        
        <?php if ($comment): ?>
	<h2><?php echo $text_comment; ?></h2>
        <p><?php echo $comment; ?></p>
        <?php endif; ?>
        
        <?php if ($histories) { ?>
        <h2><?php echo $text_history; ?></h2>
        <table class="s_table" width="100%" cellpadding="0" cellspacing="0" border="0">
          <thead>
            <tr>
              <?php if ($tbData->is_mobile == "0"): ?>
              <th width="80"><?php echo $column_date_added; ?></th>
              <th width="80"><?php echo $column_status; ?></th>
              <th><?php echo $column_comment; ?></th>
              <?php else: ?>
              <th colspan="2"><?php echo $column_comment; ?></th>
              <?php endif; ?>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($histories as $history) { ?>
            <?php if ($tbData->is_mobile == "0"): ?>
            <tr>
              <td><?php echo $history['date_added']; ?></td>
              <td><?php echo $history['status']; ?></td>
              <td class="align_left"><?php echo $history['comment']; ?></td>
            </tr>
            <?php else: ?>
            <tr>
              <td width="50%"><?php echo $history['date_added']; ?></td>
              <td width="50%"><?php echo $history['status']; ?></td>
            </tr>
            <tr>
              <td class="align_left" colspan="2"><?php echo $history['comment']; ?></td>
            </tr>
            <?php endif ?>
            <?php } ?>
          </tbody>
        </table>
        <?php } ?>
      
        <div class="s_submit s_mb_0 clearfix">
          <a class="s_button_1 s_main_color_bgr" href="<?php echo $continue; ?>"><span class="s_text"><?php echo $button_continue; ?></span></a>
        </div>
        
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