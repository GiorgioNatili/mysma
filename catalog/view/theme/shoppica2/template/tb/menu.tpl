<ul class="clearfix">
  <li id="menu_home">
    <a href="<?php echo $tbData->base_http; ?>"><?php echo $tbData->text_menu_home; ?></a>
  </li>

  <?php echo $menu_categories; ?>
  
  <?php if ($tbData->common['menu_infopages_enabled']): ?>
  <li id="menu_information">
    <a href="#" onclick="return false; "><?php echo $tbData->text_menu_information; ?></a>

    <div class="s_submenu">
      
      <div class="s_menu_group">
        <h3><?php echo $tbData->text_menu_information; ?></h3>
        <ul class="s_list_1 clearfix">
          <?php foreach ($informations as $result): ?>
          <?php if($result['sort_order'] != '-1'): ?>
          <li><a href="<?php echo $this->url->link('information/information', 'information_id=' . $result['information_id']); ?>"><?php echo $result['title']; ?></a></li>
          <?php endif; ?>
          <?php endforeach; ?>
        </ul>
      </div>

      <div class="s_menu_group">
        <h3><?php echo $text_extra; ?></h3>
        <ul class="s_list_1 clearfix">
          <?php if ($tbData->common['manufacturers_enabled']): ?>
          <li><a href="<?php echo $this->url->link('product/manufacturer', '', 'SSL'); ?>"><?php echo $text_manufacturer; ?></a></li>
          <?php endif; ?>
          <?php if ($tbData->common['voucher_enabled']): ?>
          <li><a href="<?php echo $this->url->link('account/voucher', '', 'SSL'); ?>"><?php echo $text_voucher; ?></a></li>
          <?php endif; ?>
          <?php if ($tbData->common['affiliate_enabled']): ?>
          <li><a href="<?php echo $this->url->link('affiliate/account', '', 'SSL'); ?>"><?php echo $text_affiliate; ?></a></li>
          <?php endif; ?>
          <li><a href="<?php echo $this->url->link('product/special', '', 'SSL'); ?>"><?php echo $text_special; ?></a></li>
        </ul>
      </div>

      <div class="s_menu_group">
        <h3><?php echo $text_service; ?></h3>
        <ul class="s_list_1 clearfix">
          <li><a href="<?php echo $this->url->link('information/contact', '', 'SSL'); ?>"><?php echo $text_contact; ?></a></li>
          <?php if ($tbData->common['returns_enabled']): ?>
          <li><a href="<?php echo $this->url->link('account/return/insert', '', 'SSL'); ?>"><?php echo $text_return; ?></a></li>
          <?php endif; ?>
          <li><a href="<?php echo $this->url->link('information/sitemap', '', 'SSL'); ?>"><?php echo $text_sitemap; ?></a></li>
        </ul>
      </div>

    </div>
  </li>
  <?php endif; ?>

  <?php /*
  <!-- use this if you want to add another custom menu. just remove the '<?php /*' and '/* ?>' tags -->
  <li id="custom_menu_id">
    <a href="#" onclick="return false; ">Custom Menu Name</a>
    <div class="s_submenu">

      <div class="s_menu_group">
        <h3>Section 1</h3>
        <ul class="s_list_1 clearfix">
          <li><a href="link1">Item 1</a></li>
          <li><a href="link2">Item 2</a></li>
        </ul>
      </div>

      <div class="s_menu_group">
        <h3>Section 2</h3>
        <ul class="s_list_1 clearfix">
          <li><a href="link1">Item 1</a></li>
          <li><a href="link2">Item 2</a></li>
        </ul>
      </div>

    </div>
  <li>
  */ ?>

</ul>
