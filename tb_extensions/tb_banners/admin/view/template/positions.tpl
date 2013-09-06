<h2><span>Banner positions</span></h2>

<form action="<?php echo $tbUrl->generate('default/savePositions'); ?>" method="post" id="banners_position_form">

  <table id="module" class="s_table" cellpadding="0" cellspacing="0" border="0">
    <thead>
      <tr>
        <td width="23">#</td>
        <td>Banner Set</td>
        <td><?php echo $text_layout; ?></td>
        <td><?php echo $text_position; ?></td>
        <td width="90"><?php echo $text_status; ?></td>
        <td width="30">&nbsp;</td>
      </tr>
    </thead>
    <tbody>
      <?php $module_row = 0; ?>
      <?php foreach ($positions as $module): ?>
      <tr id="module-row<?php echo $module_row; ?>">
        <td><input type="text" name="<?php echo $form_scope; ?>_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="1" style="width: 15px;" /></td>
        <td>
          <select name="<?php echo $form_scope; ?>_module[<?php echo $module_row; ?>][setId]" style="width: 110px">
            <?php foreach ($banners_sets as $setId => $banners_set): ?>
            <option value="<?php echo $setId; ?>"<?php if ($setId == $module['setId']): ?> selected="selected"<?php endif; ?>>
              <?php echo $banners_set['name']; ?>
            </option>
            <?php endforeach; ?>
          </select>
        </td>
        </td>
        <td>
          <select name="<?php echo $form_scope; ?>_module[<?php echo $module_row; ?>][layout_id]">
            <?php foreach ($layouts as $layout): ?>
            <?php if ($layout['layout_id'] == $module['layout_id']): ?>
            <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
            <?php else: ?>
            <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
            <?php endif; ?>
            <?php endforeach; ?>
          </select>
        </td>
        <td>
          <select name="<?php echo $form_scope; ?>_module[<?php echo $module_row; ?>][position]">
            <?php if ($module['position'] == 'content_top'): ?>
            <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
            <?php else: ?>
            <option value="content_top"><?php echo $text_content_top; ?></option>
            <?php endif; ?>
            <?php if ($module['position'] == 'content_bottom'): ?>
            <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
            <?php else: ?>
            <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
            <?php endif; ?>
            <?php if ($module['position'] == 'column_right'): ?>
            <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
            <?php else: ?>
            <option value="column_right"><?php echo $text_column_right; ?></option>
            <?php endif; ?>
          </select>
        </td>
        <td>
          <input type="hidden" name="<?php echo $form_scope; ?>_module[<?php echo $module_row; ?>][status]" value="0" />
          <input id="footer_categories_yes" class="tb_toggle" type="checkbox" name="<?php echo $form_scope; ?>_module[<?php echo $module_row; ?>][status]" value="1"<?php if($module['status'] == '1') echo ' checked="checked"';?> />
        </td>
        <td><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="s_button_close"><span><?php echo $text_remove; ?></span></a></td>
      </tr>
      <?php $module_row++; ?>
      <?php endforeach; ?>
    </tbody>
    <tfoot>
      <tr>
        <td colspan="6"><a onclick="addModule();" class="s_button s_button_2 s_button_green right s_mr_0"><span><?php echo $text_add_module; ?></span></a></td>
      </tr>
    </tfoot>
  </table>

</form>

<div class="s_submit clearfix">
  <a class="s_button" id="banners_position_form_cancel" href="<?php echo $tbUrl->generate('default/listPositions'); ?>"><span class="s_icon_16"><span class="s_icon s_cross_16"></span><?php echo $text_cancel; ?></span></a>
  <a class="s_button" id="banners_position_form_submit"><span class="s_icon_16"><span class="s_icon s_tick_16"></span><?php echo $text_save; ?></span></a>
</div>

<script type="text/javascript">

$("#module select").uniform();
$("#module .tb_toggle").iButton();


$("#banners_position_form_cancel").bind("click", function() {
  $("#banners_extension").tbTabs("load", 0);

  return false;
});

$("#banners_position_form_submit").bind("click", function() {

  $("#banners_position_form").block("<h1>Saving...</h1>");
  $.getJSON("<?php echo $tbUrl->generateJs('default/checkPermissions'); ?>", function(response) {
    if (response.success == true) {
      $("#banners_position_form").ajaxSubmit({
        type: "post",
        dataType: "json",
        success: function(response) {
          if (response.success == true) {
            $("#banners_extension").tbTabs("load", 0);
          } else {
            displayAlertWarning(response.message);
          }
          $("#banners_position_form").unblock();
        }
      });
    } else {
      displayAlertWarning(response.message);
      $("#banners_position_form").unblock();
    }
  });

  return false;
});

var module_row = <?php echo $module_row; ?>;

function addModule() {
    <?php if (empty($banners_sets)): ?>
    alert('Please, add at least one banner set first!');
    return false;
    <?php endif; ?>
    html 	= '  <tr id="module-row' + module_row + '">';
    html += '    <td><input type="text" name="<?php echo $form_scope; ?>_module[' + module_row + '][sort_order]" value="" size="1" style="width: 15px;" /></td>';
    html += '    <td><select name="<?php echo $form_scope; ?>_module[' + module_row + '][setId]" style="width: 110px">';
    <?php foreach ($banners_sets as $setId => $banner_set): ?>
    html += '      <option value="<?php echo $setId; ?>"><?php echo $banner_set['name']; ?></option>';
    <?php endforeach; ?>
    html += '    </select></td>';
    html += '    <td><select name="<?php echo $form_scope; ?>_module[' + module_row + '][layout_id]">';
    <?php foreach ($layouts as $layout): ?>
    html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
    <?php endforeach; ?>
    html += '    </select></td>';
    html += '    <td><select name="<?php echo $form_scope; ?>_module[' + module_row + '][position]">';
    html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
    html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
    html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
    html += '    </select></td>';
    html += '    <td><input type="hidden" name="<?php echo $form_scope; ?>_module[' + module_row + '][status]" value="0" />';
    html += '    <input id="footer_categories_yes" class="tb_toggle" type="checkbox" name="<?php echo $form_scope; ?>_module[' + module_row + '][status]" value="1" /></td>';
    html += '    <td><a onclick="$(\'#module-row' + module_row + '\').remove();" class="s_button_close"><span><?php echo $text_remove; ?></span></a></td>';
    html += '  </tr>';

    $('#module tbody').append(html);
		var row_selector = '#module-row' + module_row + ' select';
		var row_selector_1 = '#module-row' + module_row + ' .tb_toggle';
		$(row_selector).uniform();
		$(row_selector_1).iButton();

    module_row++;
}
</script>