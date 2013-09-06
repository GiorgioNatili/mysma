<?php if ($currencies && count($currencies) > 1): ?>
<form action="<?php echo $action; ?>" method="post" id="currency_form">
  <div id="currency_switcher" class="s_switcher">
    <?php foreach ($currencies as $currency): ?>
    <?php if ($currency['code'] == $currency_code): ?>
    <span class="s_selected"><?php echo $currency['title']; ?></span>
    <?php endif; ?>
    <?php endforeach; ?>
    <ul class="s_options">
      <?php foreach ($currencies as $currency): ?>
      <li>
        <a href="javascript:;" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $('#currency_form').submit();"><?php echo $currency['title']; ?></a>
      </li>
      <?php endforeach; ?>
    </ul>
  </div>
  <input class="s_hidden" type="hidden" name="currency_code" value="" />
  <input class="s_hidden" type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
<?php endif; ?>