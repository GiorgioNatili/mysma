<div class="s_categories_module s_box">
  <h2><?php echo $heading_title; ?></h2>
  <div class="s_list_1">
    <ul>
      <?php if (!isset($module_instance['count'])) $module_instance['count'] = 0; ?>
      <?php if ($module_instance['count']) $categories = $tbData->getCategoryTreeWithTotalProductsMaxLevel2(); else $categories = $tbData->category_tree; ?>
      <?php foreach ($categories as $category): ?>
      <li>
        <?php if ($category['category_id'] == $category_id): ?>
        <a href="<?php echo $category['url']; ?>" class="active"><strong><?php echo $category['name']; ?><?php if ($module_instance['count']): ?> (<?php echo $category['products_count']; ?>)<?php endif; ?></strong></a>
        <?php if ($category['children']): ?>
        <ul>
          <?php foreach ($category['children'] as $child): ?>
          <li>
          <?php if ($child['category_id'] == $child_id): ?>
            <a href="<?php echo $child['url']; ?>" class="active"><strong><?php echo $child['name']; ?><?php if ($module_instance['count']): ?> (<?php echo $child['products_count']; ?>)<?php endif; ?></strong></a>
          <?php else: ?>
            <a href="<?php echo $child['url']; ?>"><?php echo $child['name']; ?><?php if ($module_instance['count']): ?> (<?php echo $child['products_count']; ?>)<?php endif; ?></a>
          <?php endif; ?>
          </li>
          <?php endforeach; ?>
        </ul>
        <?php endif; ?>
        <?php else: ?>
        <a href="<?php echo $category['url']; ?>"><?php echo $category['name']; ?><?php if ($module_instance['count']): ?> (<?php echo $category['products_count']; ?>)<?php endif; ?></a>
        <?php endif; ?>
      </li>
      <?php endforeach; ?>
    </ul>
  </div>
</div>
