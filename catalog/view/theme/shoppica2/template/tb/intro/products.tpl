<?php $hasSlider = count($products) > 1; ?>
<div id="intro_wrap">
  <div id="product_intro" class="s_size_<?php echo $size; ?> s_wrap">
    <div id="product_intro_info" class="s_col_<?php echo 5 + (3 - $size) ?>">
      <?php $i = 0; foreach ($products as $product): ?>
      <div style="position: relative;<?php if($i > 0) echo ' display: none;'; ?>">
        <h2><a href="<?php echo $this->url->link('product/product', 'product_id=' . $product['id']); ?>"><?php echo $product['name']; ?></a></h2>
        <?php if($product['rating']): ?>
        <div class="s_rating_holder">
          <p class="s_rating s_rating_big s_rating_5">
            <span style="width: <?php echo $product['rating'] * 2 ; ?>0%;" class="s_percent"></span>
          </p>
          <span class="s_average"><?php echo $product['rating']; ?>/5</span>
        </div>
        <?php endif; ?>
        <p class="s_desc"><?php echo utf8_substr($product['description'], 0, 300); ?>...</p>
        <?php if ($product['price']): ?>
        <div class="s_price_holder s_size_<?php if($size == 3): echo '4'; else: echo '3'; endif; ?> s_label">
          <?php if (!$product['special']): ?>
          <p class="s_price"><?php echo $tbData->priceFormat($product['price']); ?></p>
          <?php else: ?>
          <p class="s_price s_promo_price">
            <span class="s_old_price"><?php echo $tbData->priceFormat($product['price']); ?></span>
            <?php echo $tbData->priceFormat($product['special']); ?>
          </p>
          <?php endif; ?>
        </div>
        <?php endif; ?>
      </div>
      <?php $i++; endforeach; ?>
    </div>
    <div id="product_intro_preview">
      <div class="slides_container">
      <?php foreach($products as $product): ?>
        <div class="slideItem"<?php if($hasSlider): ?> style="display: none"<?php endif; ?>><a href="<?php echo $this->url->link('product/product', 'product_id=' . $product['id']); ?>"><img src="<?php echo $product['image']; ?>" /></a></div>
      <?php endforeach; ?>
      </div>
      <?php if($hasSlider): ?>
      <a class="s_button_prev" href="javascript:;"></a>
      <a class="s_button_next" href="javascript:;"></a>
      <?php endif; ?>
    </div>
  </div>
</div>

<?php if($hasSlider): ?>
<script type="text/javascript" src="<?php echo $tbData->theme_javascript_url; ?>jquery/jquery.slides.min.js"></script>
<script type="text/javascript" src="<?php echo $tbData->theme_javascript_url; ?>products_slide.js"></script>
<?php endif; ?>