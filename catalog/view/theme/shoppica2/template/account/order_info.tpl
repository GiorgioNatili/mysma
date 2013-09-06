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

    <div id="order_details" class="s_main_col">  

      <?php echo $content_top; ?>

      <div class="s_order clearfix">

        <?php if ($invoice_no): ?>
        <p class="s_status"><span class="s_999"><?php echo $text_invoice_no; ?></span> <span class="s_secondary_color"><?php echo $invoice_no; ?></span></p>
        <?php endif; ?>

        <p class="s_id"><span class="s_999"><?php echo $text_order_id; ?></span> <span class="s_main_color">#<?php echo $order_id; ?></span></p>

        <span class="clear s_sep border_eee"></span>
        
        <dl class="s_1_2 s_sep clearfix">
          <dt><?php echo $text_date_added; ?></dt>
          <dd><?php echo $date_added; ?></dd>
          <?php if ($payment_method): ?>
          <dt><?php echo $text_payment_method; ?></dt>
          <dd><?php echo $payment_method; ?></dd>
          <?php endif; ?>
          <?php if ($shipping_method): ?>
          <dt><?php echo $text_shipping_method; ?></dt>
          <dd><?php echo $shipping_method; ?></dd>
          <?php endif; ?>
        </dl>

        <span class="clear s_sep border_eee"></span>

        <div class="s_2col_wrap clearfix">

          <div class="s_col s_1_2">
            <h2><?php echo $text_payment_address; ?></h2>
            <p><?php echo $payment_address; ?></p>
          </div>

          <?php if ($shipping_address): ?>
          <div class="s_col s_1_2">
            <h2><?php echo $text_shipping_address; ?></h2>
            <p><?php echo $shipping_address; ?></p>
          </div>
          <?php endif; ?>
          
        </div>

        <span class="clear s_sep border_eee"></span>

        <h2><?php echo $tbData->text_ordered_products; ?></h2>
        <table class="s_table s_sep" width="100%" cellpadding="0" cellspacing="0" border="0">
          <thead>
            <tr>
              <?php if ($tbData->common['returns_enabled']): ?>
              <th class="s_cell_select" width="1">&nbsp;</th>
              <?php endif; ?>
              <th class="s_cell_name"><?php echo $column_name; ?></th>
              <th class="s_cell_model"><?php echo $column_model; ?></th>
              <th class="s_cell_quantity"><?php echo $column_quantity; ?></th>
              <th class="s_cell_price"><?php echo $column_price; ?></th>
              <th class="s_cell_total"><?php echo $column_total; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($products as $product): ?>
            <tr>
              <?php if ($tbData->common['returns_enabled']): ?>
              <td class="s_cell_select"><a href="<?php echo $product['return']; ?>"><img src="catalog/view/theme/default/image/return.png" alt="<?php echo $button_return; ?>" title="<?php echo $button_return; ?>" /></a></td>
              <?php endif; ?>
              <td class="s_cell_name">
                <?php if ($tbData->is_mobile == "1"): ?>
                <strong class="inline s_hidden"><?php echo $product['quantity']; ?> x</strong>
                <?php endif; ?>
                <?php echo $product['name']; ?>
                <?php foreach ($product['option'] as $option): ?>
                <br />
                &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                <?php endforeach; ?>
              </td>
              <td class="s_cell_model"><?php echo $product['model']; ?></td>
              <td class="s_cell_quantity"><?php echo $product['quantity']; ?></td>
              <td class="s_cell_price"><?php echo $product['price']; ?></td>
              <td class="s_cell_total"><?php echo $product['total']; ?></td>
            </tr>
            <?php endforeach; ?>
            <?php foreach ($vouchers as $voucher) { ?>
            <tr>
              <td class="s_cell_select"></td>
              <td class="s_cell_name"><?php echo $voucher['description']; ?></td>
              <td class="s_cell_model"></td>
              <td class="s_cell_quantity">1</td>
              <td class="s_cell_price"><?php echo $voucher['amount']; ?></td>
              <td class="s_cell_total"><?php echo $voucher['amount']; ?></td>
            </tr>
            <?php } ?>
          </tbody>
          <?php if ($totals): $i = 0; $j = count($totals); ?>
          <tfoot>
            <?php foreach ($totals as $total): ?>
            <tr<?php if($i == $j-1) echo ' class="last"'; ?>>
              <td class="align_right" colspan="<?php if ($tbData->common['returns_enabled']): ?><?php if ($tbData->is_mobile == "1") { echo '2'; } else { echo '5'; } ?><?php else: ?><?php if ($tbData->is_mobile == "1") { echo '1'; } else { echo '4'; } ?><?php endif; ?>"><strong><?php echo $total['title']; ?></strong></td>
              <td<?php if($i == $j-1) echo ' class="s_secondary_color"'; ?>><?php echo $total['text']; ?></td>
            </tr>
            <?php $i++; endforeach; ?>
          </tfoot>
          <?php endif; ?>
        </table>
     
        <?php if ($histories): ?>
        <span class="clear s_sep"></span>

        <h2><?php echo $text_history; ?></h2>
        <table class="s_table s_sep" width="100%" cellpadding="0" cellspacing="0" border="0">
          <thead>
            <tr>
	            <?php if ($tbData->is_mobile == "0"): ?>
              <th><?php echo $column_date_added; ?></th>
              <th><?php echo $column_status; ?></th>
              <th><?php echo $column_comment; ?></th>
	            <?php else: ?>
              <th colspan="2"><?php echo $column_comment; ?></th>
	            <?php endif; ?>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($histories as $history): ?>
            <tr>
              <td<?php if ($tbData->is_mobile == "1"): ?> width="50%"<?php endif; ?>><strong><?php echo $history['date_added']; ?></strong></td>
              <td<?php if ($tbData->is_mobile == "1"): ?> width="50%"<?php endif; ?>><strong><?php echo $history['status']; ?></strong></td>
              <?php if ($tbData->is_mobile == "1"): ?>
            </tr>
            <tr>
              <td class="align_left" colspan="2"><?php echo $history['comment']; ?></td>
              <?php else: ?>
              <td class="align_left"><?php echo $history['comment']; ?></td>
              <?php endif; ?>
            </tr>
            <?php endforeach; ?>
          </tbody>
        </table>
        <?php endif; ?>

        <?php if ($comment): ?>
        <span class="clear"></span>

        <h2><?php echo $text_comment; ?></h2>
        <p class="s_mb_25"><?php echo $comment; ?></p>
        <?php endif; ?>

        <span class="clear border_ddd s_sep"></span>

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
