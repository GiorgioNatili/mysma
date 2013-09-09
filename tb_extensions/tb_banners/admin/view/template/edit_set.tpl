<h2>
  <span>
    <a class="banners_edit_set_form_cancel" href="<?php echo $tbUrl->generate('default/listSets'); ?>">Banner sets</a>
    <span class="s_separator"></span><?php if ($set['action'] == 'add') echo $text_add_banner_set; else echo $text_edit_banner_set; ?>
  </span>
</h2>

<?php if ($error_warning): ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php endif ?>

<form action="<?php echo $tbUrl->generate('default/saveSet'); ?>" method="post" id="banners_edit_set_form">

  <input type="hidden" name="set[setId]" value="<?php echo $set['id']; ?>" />

  <div class="s_row_2 first clearfix">
    <label>Set Name:</label>
    <input type="text" id="banner_name" name="set[name]" value="<?php echo $set['name']; ?>" size="40" />
  </div>

  <?php $tbSlot->flag('tb_banners\edit_set.settings', array('set' => $set)); ?>

  <div id="banners_extension_new_set" class="htabs clearfix">
    <?php foreach ($languages as $language): ?>
    <a href="#banners_extension_new_set_language_<?php echo $language['language_id']; ?>">
      <img class="inline" src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
    </a>
    <?php endforeach; ?>
  </div>

  <?php foreach ($languages as $language): $lid = $language['language_id']; ?>
  <div id="banners_extension_new_set_language_<?php echo $language['language_id']; ?>" class="divtab">

    <table id="banner_images_table_<?php echo $lid; ?>" class="s_table" cellpadding="0" cellspacing="0" border="0">
      <thead>
        <tr>
          <td width="100">Image</td>
          <td width="23">#</td>
          <td>Url</td>
          <td width="80">New Window</td>
          <td width="30">&nbsp;</td>
        </tr>
      </thead>
      <tbody>
        <?php $image_row = 0; ?>
        <?php foreach ($set['images'][$lid] as $banner_image): ?>
        <tr id="banner_image_row_<?php echo $lid; ?>_<?php echo $image_row; ?>" class="image_row">
          <td>
            <input type="hidden" name="set[images][<?php echo $lid; ?>][<?php echo $image_row; ?>][image]" value="<?php echo $banner_image['file']; ?>" id="banner_image_<?php echo $lid; ?>_<?php echo $image_row; ?>"  />
            <img src="<?php echo $banner_image['preview']; ?>" id="banner_preview_<?php echo $lid; ?>_<?php echo $image_row; ?>" class="image" onclick="image_upload('banner_image_<?php echo $lid; ?>_<?php echo $image_row; ?>', 'banner_preview_<?php echo $lid; ?>_<?php echo $image_row; ?>');" />
          </td>
          <td><input type="text" name="set[images][<?php echo $lid; ?>][<?php echo $image_row; ?>][order]" value="<?php echo $banner_image['order']; ?>" style="width: 15px;" size="1" /></td>
          <td><input type="text" name="set[images][<?php echo $lid; ?>][<?php echo $image_row; ?>][url]" value="<?php echo $banner_image['url']; ?>" style="width: 98%;" /></td>
          <td><input type="checkbox" name="set[images][<?php echo $lid; ?>][<?php echo $image_row; ?>][new_window]" value="1"<?php if($banner_image['new_window']) echo ' checked="checked"';?> /></td>
          <td><a onclick="$('#banner_image_row_<?php echo $lid . '_' . $image_row; ?>').remove();" class="s_button_close"><span>Remove</span></a></td>
        </tr>
        <?php $image_row++; ?>
        <?php endforeach; ?>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="5"><a onclick="addImage('banner_images_table_<?php echo $lid; ?>', 'set', '<?php echo $lid; ?>');" class="s_button s_button_2 s_button_green s_mr_0 right">Add Image</a></td>
        </tr>
      </tfoot>
    </table>
  </div>
  <?php endforeach; ?>

</form>

<div class="s_submit clearfix">
  <a href="<?php echo $tbUrl->generate('default/listSets'); ?>" class="s_button banners_edit_set_form_cancel"><span class="s_icon_16"><span class="s_icon s_cross_16"></span><?php echo $text_cancel; ?></span></a>
  <a href="#" class="s_button" id="banners_edit_set_form_submit"><span class="s_icon_16"><span class="s_icon s_tick_16"></span><?php echo $text_save; ?></span></a>
</div>

<script type="text/javascript">

$("#banners_extension_new_set a").tabs();

function addImage(table_id, varname, language_id) {

  var image_row = $("#" + table_id).find("tr.image_row").length + 1;

  if ($("#banner_images_table tbody > tr").length < 4) {
    html = '<tr id="banner_image_row_' + language_id + '_' + image_row + '" class="image_row">';
    html += '<td><input type="hidden" name="'   + varname + '[images][' + language_id + '][' + image_row + '][image]" value="" id="banner_image_' + language_id + '_' + image_row + '" /><img src="<?php echo $no_image; ?>" alt="" id="banner_preview_' + language_id + '_' + image_row + '" class="image" onclick="image_upload(\'banner_image_' + language_id + '_' + image_row + '\', \'banner_preview_' + language_id + '_' + image_row + '\');" /></td>';
    html += '<td><input type="text" name="'     + varname + '[images][' + language_id + '][' + image_row + '][order]" style="width: 15px;" size="1" /></td>';
    html += '<td><input type="text" name="'     + varname + '[images][' + language_id + '][' + image_row + '][url]" style="width: 98%;" /></td>';
    html += '<td><input type="checkbox" name="' + varname + '[images][' + language_id + '][' + image_row + '][new_window]" value="1" size="50" /></td>';
    html += '<td><a onclick="$(\'#banner_image_row_' + language_id + '_' + image_row  + '\').remove();" class="s_button_close">Remove</a></td>';
    html += '</tr>';

    $("#" + table_id).find("tbody").append(html);
  } else {
    alert("Only 4 images allowed");
  }

  return false;
}

$(".banners_edit_set_form_cancel").bind("click", function() {
  $("#banners_extension").tbTabs("load", 1);
  return false;
});

$("#banners_edit_set_form_submit").bind("click", function() {
  if ($("#banner_name").val()) {
    $("#banners_edit_set_form").block("<h1>Saving...</h1>");
    $.getJSON("<?php echo $tbUrl->generateJs('default/checkPermissions'); ?>", function(response) {
      if (response.success == true) {
        $("#banners_edit_set_form").ajaxSubmit({
          type: "post",
          dataType: "json",
          success: function(response) {
            if (response.success == true) {
              $("#banners_extension").tbTabs("load", 1);
            } else {
              displayAlertWarning(response.message);
            }
            $("#banners_edit_set_form").unblock();
          }
        });
      } else {
        displayAlertWarning(response.message);
        $("#banners_edit_set_form").unblock();
      }
    });
  } else {
    alert("Please, enter a set name!");
  }

  return false;
});

</script>
