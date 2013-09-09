<?php if (!isset($tbData)) require dirname(__FILE__) . '/../tb/install_error.tpl'; ?>

<?php if ($module_position == 'content_top' || $module_position == 'content_bottom'): ?>

<!-- ------------------ -->
<!--  Featured Content  -->
<!-- ------------------ -->
<?php $products = $tbSlot->filter('module\featured.filter_products', $products, array('data' => $this->data)); ?>
<?php $tbSlot->start('module\featured_content.products_listing', array('products' => $products, 'data' => $this->data)); ?>
<?php if ($products): ?>
<div class="s_module_featured s_module_content">

  <h2 class="s_title_1"><span><?php echo $heading_title; ?></span></h2>

  <div class="s_listing s_grid_view <?php echo $tbData->common['products_per_row']; ?> clearfix">

    <?php foreach ($products as $product): ?>
    <?php $tbSlot->start('module\featured_content.products.each', array('products' => $products, 'product' => $product, 'data' => $this->data)); ?>
    <div class="s_item product_<?php echo $product['product_id']; ?>">
      <a class="s_thumb" href="<?php echo $product['href']; ?>">
        <img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
      </a>
      <div class="s_item_info">
        <h3><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
        <?php if ($product['price']): ?>
        <div class="s_price_holder s_size_<?php echo $tbData->common['price_size']; ?> <?php echo 's_' . $tbData->common['price_design']; ?>">
          <?php if (!$product['special']): ?>
          <p class="s_price"><?php echo $tbData->priceFormat($product['price']); ?></p>
          <?php else: ?>
          <p class="s_price s_promo_price"><span class="s_old_price"><?php echo $tbData->priceFormat($product['price']); ?></span><?php echo $tbData->priceFormat($product['special']); ?></p>
          <?php endif ?>
        </div>
        <?php endif; ?>
        <?php if ($product['rating']): ?>
        <p class="s_rating s_rating_5">
          <span style="width: <?php echo $product['rating'] * 2 ; ?>0%;" class="s_percent"></span>
        </p>
        <?php endif; ?>
        <?php if ($tbData->common['checkout_enabled'] || $tbData->common['wishlist_enabled'] || $tbData->common['compare_enabled']): ?>
        <div class="s_actions">
          <?php if ($product['price'] && $tbData->common['checkout_enabled']): ?>
          <a class="s_button_add_to_cart" href="javascript:;" onclick="addToCart('<?php echo $product['product_id']; ?>');">
            <span class="s_icon_16"><span class="s_icon"></span><?php echo $button_cart; ?></span>
          </a>
          <?php endif; ?>
          <?php if ($tbData->common['wishlist_enabled']): ?>
          <a class="s_button_wishlist s_icon_10" onclick="addToWishList('<?php echo $product['product_id']; ?>');"><span class="s_icon s_add_10"></span><?php echo $tbData->text_wishlist; ?></a>
          <?php endif; ?>
          <?php if ($tbData->common['compare_enabled']): ?>
          <a class="s_button_compare s_icon_10" onclick="addToCompare('<?php echo $product['product_id']; ?>');"><span class="s_icon s_add_10"></span><?php echo $tbData->text_compare; ?></a>
          <?php endif; ?>
        </div>
        <?php endif; ?>
      </div>
    </div>
    <?php $tbSlot->stop(); ?>
    <?php endforeach; ?>

    <span class="clear"></span>
  </div>

</div>
<?php endif; ?>
<?php $tbSlot->stop(); ?>
<!-- End of Content -->

<?php else: ?>

<!-- ------------------ -->
<!--  Featured Column   -->
<!-- ------------------ -->
<?php $products = $tbSlot->filter('module\featured.filter_products', $products, array('data' => $this->data)); ?>
<?php $tbSlot->start('module\featured_column.products_listing', array('products' => $products, 'data' => $this->data)); ?>
<?php if ($products): ?>
<div class="s_box clearfix">
  <h2><?php echo $heading_title; ?></h2>

  <?php foreach ($products as $product): ?>
  <?php $tbSlot->start('module\featured_column.products.each', array('products' => $products, 'product' => $product, 'data' => $this->data)); ?>
  <div class="s_item s_size_1 clearfix product_<?php echo $product['product_id']; ?>">

    <?php if ($product['thumb']): ?>
    <a class="s_thumb" href="<?php echo $product['href']; ?>">
      <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />
    </a>
    <?php endif; ?>

    <h3><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>

    <?php if ($product['price']): ?>
    <p>
      <a href="<?php echo $product['href']; ?>">
        <?php if (!$product['special']): ?>
        <span class="s_main_color"><?php echo $product['price']; ?></span>
        <?php else: ?>
        <span class="s_old"><?php echo $product['price']; ?></span> <span class="s_secondary_color"><?php echo $product['special']; ?></span>
        <?php endif; ?>
      </a>
    </p>
    <?php endif; ?>

    <?php if ($product['rating']): ?>
    <div class="s_rating_holder clearfix">
      <p class="s_rating s_rating_small s_rating_5 left">
        <span style="width: <?php echo $product['rating'] * 2 ; ?>0%;" class="s_percent"></span>
      </p>
      <span class="left">&nbsp;<?php echo $product['rating']; ?>/5</span>
    </div>
    <?php endif; ?>

  </div>
  <?php $tbSlot->stop(); ?>
  <?php endforeach; ?>

</div>
<?php endif; ?>
<?php $tbSlot->stop(); ?>
<!-- End of Column -->

<?php endif; ?>