<?php if ($languages && count($languages) > 1): ?>
<form action="<?php echo $action; ?>" method="post" id="language_form">
  <div id="language_switcher" class="s_switcher">
    <?php foreach ($languages as $language): ?>
    <?php if ($language['code'] == $language_code): ?>
    <span class="s_selected"><img src="<?php echo $tbData->theme_images_url; ?>flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></span>
    <?php endif; ?>
    <?php endforeach; ?>
    <ul class="s_options">
      <?php foreach ($languages as $language): ?>
      <li>
        <a href="javascript:;" onclick="$('input[name=\'language_code\']').attr('value', '<?php echo $language['code']; ?>'); $('#language_form').submit();">
          <img src="<?php echo $tbData->theme_images_url; ?>flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
        </a>
      </li>
      <?php endforeach; ?>
    </ul>
  </div>
  <input class="s_hidden" type="hidden" name="language_code" value="" />
  <input class="s_hidden" type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
<?php endif; ?>
