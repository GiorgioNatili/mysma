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

    <div id="wishlist" class="s_main_col">
  
      <?php echo $content_top; ?>
  
      <?php if ($products): ?>
      <div class="wishlist-product">
        <table class="s_table_1" cellpadding="0" cellspacing="0" border="0" width="100%">
          <thead>
            <tr>
              <th class="s_cell_image"><?php echo $column_image; ?></th>
              <th class="s_cell_name"><?php echo $column_name; ?></th>
              <th class="s_cell_model"><?php echo $column_model; ?></th>
              <th class="s_cell_price"><?php echo $column_stock; ?></th>
              <th class="s_cell_total"><?php echo $column_price; ?></th>
              <th class="s_cell_cart"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($products as $product): ?>
            <tr id="wishlist-row<?php echo $product['product_id']; ?>">
              <td class="s_cell_image">
                <?php if ($product['thumb']): ?>
                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                <?php endif; ?>
                <strong class="s_hidden s_mb_5">
                  <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                </strong>
                <?php if ($tbData->common['checkout_enabled']): ?>
                <span class="s_hidden s_mb_10">
                  <a class="s_main_color" href="javascript:;" onclick="addToCart('<?php echo $product['product_id']; ?>');"><img class="inline" src="catalog/view/theme/default/image/cart-add.png" alt="<?php echo $button_cart; ?>" title="<?php echo $button_cart; ?>" /> <?php echo $button_cart; ?></a>
                </span>
                <?php endif; ?>
                <span class="s_hidden">
                  <a class="s_main_color" href="<?php echo $product['remove']; ?>"><img class="inline" src="catalog/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /> <?php echo $button_remove; ?></a>
                </span>
              </td>
              <td class="s_cell_name"><a class="s_main_color" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></td>
              <td class="s_cell_model"><?php echo $product['model']; ?></td>
              <td class="s_cell_price"><?php echo $product['stock']; ?></td>
              <td class="s_cell_total"><?php if ($product['price']): ?>
                <div class="price">
                  <?php if (!$product['special']): ?>
                  <?php echo $product['price']; ?>
                  <?php else: ?>
                  <s><?php echo $product['price']; ?></s><br /><b><?php echo $product['special']; ?></b>
                  <?php endif; ?>
                </div>
                <?php endif; ?>
              </td>
              <td class="s_cell_cart">
                <?php if ($tbData->common['checkout_enabled']): ?>
                <a href="javascript:;" onclick="addToCart('<?php echo $product['product_id']; ?>');"><img class="inline" src="catalog/view/theme/default/image/cart-add.png" alt="<?php echo $button_cart; ?>" title="<?php echo $button_cart; ?>" /></a>
                &nbsp;
                <?php endif; ?>
                <a href="<?php echo $product['remove']; ?>"><img class="inline" src="catalog/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a>
              </td>
            </tr>
            <?php endforeach; ?>
          </tbody>
        </table>
      </div>
      
      <div class="s_submit clearfix">
        <a href="<?php echo $continue; ?>" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
      </div>
      
      <?php else: ?>
      
      <div class="content"><?php echo $text_empty; ?></div>
      <div class="s_submit clearfix">
        <a href="<?php echo $continue; ?>" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
      </div>
      
      <?php endif; ?>

      
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