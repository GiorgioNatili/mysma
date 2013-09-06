<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <ul class="box-filter">
      <?php foreach ($filter_groups as $filter_group) { ?>
      <li>
        <strong id="filter-group<?php echo $filter_group['filter_group_id']; ?>" class="s_mb_10 block"><?php echo $filter_group['name']; ?></strong>
        <ul class="clear">
          <?php foreach ($filter_group['filter'] as $filter) { ?>
          <?php if (in_array($filter['filter_id'], $filter_category)) { ?>
          <li class="clear clearfix">
            <label for="filter<?php echo $filter['filter_id']; ?>">
              <input type="checkbox" value="<?php echo $filter['filter_id']; ?>" id="filter<?php echo $filter['filter_id']; ?>" checked="checked" />
              <?php echo $filter['name']; ?>
            </label>
          </li>
          <?php } else { ?>
          <li class="clear clearfix">
            <label for="filter<?php echo $filter['filter_id']; ?>">
              <input type="checkbox" value="<?php echo $filter['filter_id']; ?>" id="filter<?php echo $filter['filter_id']; ?>" />
              <?php echo $filter['name']; ?>
            </label>
          </li>
          <?php } ?>
          <?php } ?>
        </ul>
      </li>
      <?php } ?>
    </ul>
    <div class="s_submit">
      <a id="button-filter" class="button s_button_1 s_button_1_small s_main_color_bgr"><span class="s_text"><?php echo $button_filter; ?></span></a>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#button-filter').bind('click', function() {
  filter = [];
  
  $('.box-filter input[type=\'checkbox\']:checked').each(function(element) {
    filter.push(this.value);
  });
  
  location = '<?php echo $action; ?>&filter=' + filter.join(',');
});
//--></script> 
