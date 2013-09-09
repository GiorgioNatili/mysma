<?php foreach ($category_tree as $category): ?>
<?php if ($category['top']): ?>
<li id="menu_<?php echo $category['category_id']; ?>" class="s_category_menu">
  <a href="<?php echo $category['url']; ?>"><?php echo $category['name']; ?></a>
  <?php $submenu = $tbData->getCategorySubMenu($category); $manufacturers = $tbData->getCategoryManufacturers($category);?>
  <?php if (!empty($submenu) || !empty($manufacturers)): ?>
  <div class="s_submenu">

    <?php if (!empty($submenu)): ?>
    <!-- Subcategories -->
    <div class="s_category_group s_menu_group">
      <h3><?php echo $tbData->text_menu_inside; ?> <?php echo $category['name']; ?></h3>
      <?php echo $submenu; ?>
    </div>
    <?php endif; ?>

    <?php if ($tbData->common['menu_brands_enabled']): ?>
    <?php if (!empty($manufacturers)): ?>
    <!-- Brands -->
    <div class="s_brands_group s_menu_group">
      <h3><?php echo $category['name']; ?> <?php echo $tbData->text_menu_brands; ?></h3>
      <ul class="s_brands_list s_list_1 clearfix">
        <?php foreach ($manufacturers as $manufacturer): ?>
        <li><a href="<?php echo $this->url->link('category/manufacturer', 'c_id=' . $category['category_id'] . '&man_id=' . $manufacturer['manufacturer_id']); ?>"><?php echo $manufacturer['name']; ?></a></li>
        <?php endforeach; ?>
      </ul>
    </div>
    <?php endif; ?>
    <?php endif; ?>

  </div>
  <?php endif; ?>
</li>
<?php endif; ?>
<?php endforeach; ?>