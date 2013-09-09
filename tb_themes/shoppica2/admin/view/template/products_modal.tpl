<h2><?php echo $text_title_add_intro_products; ?> <strong class="title_add"></strong></h2>
<div class="tb_filter_holder">
  <h3><?php echo $text_title_product_filter; ?></h3>
  <form class="filter_form">
    <div class="s_row_1 clearfix">
      <label class="s_mb_5"><?php echo $text_name; ?></label>
      <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" size="18" />
    </div>
    <div class="s_row_1 clearfix">
      <label class="s_mb_5"><?php echo $text_model; ?></label>
      <input type="text" name="filter_model" value="<?php echo $filter_model; ?>" size="18" />
    </div>
    <div class="s_row_1 s_price_fields clearfix">
      <label class="s_mb_5"><?php echo $text_price; ?></label>
      <span class="clear"></span>
      <span class="s_metric left">&gt;&nbsp;</span>
      <input type="text" name="filter_price_more" value="<?php echo $filter_price_more; ?>" size="16" />
      <span class="clear s_mb_5"></span>
      <span class="s_metric left">&lt;&nbsp;</span>
      <input type="text" name="filter_price_less" value="<?php echo $filter_price_less; ?>" size="16" />
      <span class="clear s_mb_5"></span>
      <span class="s_metric left">=&nbsp;</span>
      <input type="text" name="filter_price_equals" value="<?php echo $filter_price_equals; ?>" size="16" />
    </div>
    <div class="s_row_1 clearfix">
      <label class="s_checkbox"><input type="checkbox" name="filter_selected" value="1"<?php if($filter_selected == 1): ?> checked="checked"<?php endif; ?> /><?php echo $text_label_show_selected_only; ?></label>
    </div>
  </form>
  <div class="s_row_1 clearfix">
    <a class="s_button s_button_2 s_button_green s_button_filter"><?php echo $text_button_filter; ?></a>
    <a class="right reset_filter_button"><?php echo $text_reset; ?></a>
  </div>
</div>
<div class="tb_data_holder">
  <table class="s_table" cellpadding="0" cellspacing="0" border="0">
    <thead>
      <tr>
        <td width="30">&nbsp;</td>
        <td width="40">&nbsp;</td>
        <td width="270">
          <?php if ($sort == 'pd.name'): ?>
          <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
          <?php else: ?>
          <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
          <?php endif; ?>
        </td>
        <td>
          <?php if ($sort == 'p.model'): ?>
          <a href="<?php echo $sort_model; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_model; ?></a>
          <?php else: ?>
          <a href="<?php echo $sort_model; ?>"><?php echo $column_model; ?></a>
          <?php endif; ?>
        </td>
        <td>
          <?php if ($sort == 'p.price'): ?>
          <a href="<?php echo $sort_price; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_price; ?></a>
          <?php else: ?>
          <a href="<?php echo $sort_price; ?>"><?php echo $column_price; ?></a>
          <?php endif; ?>
        </td>
      </tr>
    </thead>
    <tbody>
    <?php if ($products): ?>
      <?php foreach ($products as $product): ?>
      <tr<?php if ($product['added']) echo ' class="s_selected"'; ?>>
        <td>
          <input type="hidden" value="<?php echo $product['product_id']; ?>" />
          <a class="tb_button_add add_product" href="#"><span class="s_text_add"><?php echo $text_add; ?></span><span class="s_text_added"><?php echo $text_added; ?></span><span class="s_text_remove"><?php echo $text_remove; ?></span></a>
        </td>
        <td><img width="40" height="40" src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>" /></td>
        <td><strong><?php echo $product['name']; ?></strong></td>
        <td><?php echo $product['model']; ?></td>
        <td>
          <?php if ($product['special']): ?>
          <span style="text-decoration:line-through"><?php echo $product['price']; ?></span><br/><span style="color:#b00;"><?php echo $product['special']; ?></span>
          <?php else: ?>
          <?php echo $product['price']; ?>
          <?php endif; ?>
        </td>
      </tr>
      <?php endforeach; ?>
      <?php if (8 > count($products)): ?>
      <tr rowspan="<?php echo 8 - count($products); ?>"><td class="s_dummy_row" colspan="5" style="height: <?php echo (55 * (8 - count($products)) - 1); ?>px;">&nbsp;</td></tr>
      <?php endif; ?>
    <?php else: ?>
      <tr>
        <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
      </tr>
    <?php endif; ?>
    </tbody>
  </table>
  <div class="pagination"><?php echo $pagination; ?></div>
</div>

<span class="clear"></span>