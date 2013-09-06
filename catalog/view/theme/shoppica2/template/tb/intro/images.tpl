<?php $hasSlider = count($intro_images['files']) > 1; ?>
<div id="intro_wrap">
  <div id="image_intro" class="s_wrap">
    <div id="image_intro_preview"<?php if ($intro_images['with_border']) { ?> class="s_boxed"<?php } ?>>
      <div class="slides_container">
        <?php $i = 0; foreach($intro_images['files'] as $image): ?>
        <div class="slideItem"<?php if($hasSlider): ?> style="display: none"<?php endif; ?>>
          <?php if($image['url']): ?>
          <a href="<?php echo $image['url']?>">
          <?php endif; ?>
            <img src="<?php echo $image['http_file']; ?>" width="<?php echo $image['width'] ?>" height="<?php echo $image['height'] ?>" />
          <?php if($image['url']): ?>
          </a>
          <?php endif; ?>
        </div>
        <?php $i++; endforeach; ?>
      </div>
      <?php if($hasSlider): ?>
      <span class="s_button_prev_holder">
        <a class="s_button_prev" href="javascript:;"></a>
      </span>
      <span class="s_button_next_holder">
        <a class="s_button_next" href="javascript:;"></a>
      </span>
      <?php endif; ?>
    </div>
  </div>
</div>

<?php if($hasSlider): ?>
<script type="text/javascript" src="<?php echo $tbData->theme_javascript_url; ?>jquery/jquery.slides.min.js"></script>
<script type="text/javascript">
  var slideEffect = '<?php echo $intro_images['rotation_type'] ?>';
</script>
<script type="text/javascript" src="<?php echo $tbData->theme_javascript_url; ?>images_slide.js"></script>
<?php endif; ?>