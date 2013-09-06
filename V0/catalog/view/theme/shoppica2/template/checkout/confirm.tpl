<?php if (!isset($redirect)): ?>
<div id="shopping_cart_confirm">

  <table class="s_table_1 s_sep" width="100%" cellpadding="0" cellspacing="0" border="0">
    <thead>
      <tr>
        <th class="s_cell_name"><?php echo $column_name; ?></th>
        <th class="s_cell_model"><?php echo $column_model; ?></th>
        <th class="s_cell_quantity"><?php echo $column_quantity; ?></th>
        <th class="s_cell_price"><?php echo $column_price; ?></th>
        <th class="s_cell_total"><?php echo $column_total; ?></th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($products as $product) { ?>
      <tr>
        <td class="s_cell_name align_left">
          <strong class="inline s_hidden"><?php echo $product['quantity']; ?> x</strong>
          <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
          <?php foreach ($product['option'] as $option) { ?>
          <br />
          <small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
          <?php } ?></td>
        <td class="s_cell_model"><?php echo $product['model']; ?></td>
        <td class="s_cell_quantity"><?php echo $product['quantity']; ?></td>
        <td class="s_cell_price"><?php echo $product['price']; ?></td>
        <td class="s_cell_total"><?php echo $product['total']; ?></td>
      </tr>
      <?php } ?>
      <?php foreach ($vouchers as $voucher) { ?>
      <tr>
        <td class="s_cell_name"><?php echo $voucher['description']; ?></td>
        <td class="s_cell_model"></td>
        <td class="s_cell_quantity">1</td>
        <td class="s_cell_price"><?php echo $voucher['amount']; ?></td>
        <td class="s_cell_total"><?php echo $voucher['amount']; ?></td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
  
  <?php if ($totals) { $i = 0; $j = count($totals); ?>
  <?php foreach ($totals as $total) { ?>
  <p class="s_total<?php if($i == $j-1) echo ' s_secondary_color last s_sep'; ?>">
    <strong><?php echo $total['title']; ?></strong>
    <?php echo $total['text']; ?>
  </p>
  <?php $i++; } ?>
  
  <span class="clear s_sep border_eee"></span>
  <?php } ?>

  <div class="payment clearfix"><?php echo $payment; ?></div>

</div>
<?php else: ?>
<script type="text/javascript">
location = '<?php echo $redirect; ?>';
</script>
<?php endif; ?>