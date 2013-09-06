<div class="s_banners">
  <?php $i = 0; foreach($banners as $image): ?>
  <?php if ($image['url']): ?>
  <a class="s_banner" href="<?php echo $image['url']; ?>"<?php if($image['new_window']) echo ' target="_blank"'; ?>>
    <img src="<?php echo $image['http_file'];?>">
  </a>
  <?php else: ?>
  <img class="s_banner" src="<?php echo $image['http_file'];?>">
  <?php endif; ?>
  <?php $i++; endforeach; ?>
  <div class="clear"></div>
</div>