<ul class="s_list_1 clearfix">
  <?php foreach ($category['children'] as $category): ?>
  <li id="menu_<?php echo $category['category_id']; ?>">
    <a href="<?php echo $category['url']; ?>"><?php echo $category['name']; ?></a><?php echo $tbData->getCategorySubMenu($category); ?>
  </li>
  <?php endforeach; ?>
</ul>