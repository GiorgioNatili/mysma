<div id="account_module" class="s_box_1 clearfix">
  <h2 class="s_secondary_color"><?php echo $heading_title; ?></h2>
  <ul class="s_list_1">
    <?php if ($tbData->common['checkout_enabled']): ?>
    <?php if (!$logged): ?>
    <li><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a> / <a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
    <li><a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></li>
    <?php else: ?>
    <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
    <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
    <?php endif; ?>
    <?php endif; ?>
    <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
    <li><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
    <?php if ($tbData->common['wishlist_enabled']): ?>
    <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
    <?php endif; ?>
    <?php if ($tbData->common['checkout_enabled']): ?>
    <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
    <?php endif; ?>
    <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
    <?php if ($tbData->common['returns_enabled']): ?>
    <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
    <?php endif; ?>
    <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
    <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
    <?php if ($logged) { ?>
    <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
    <?php } ?>
  </ul>
</div>
