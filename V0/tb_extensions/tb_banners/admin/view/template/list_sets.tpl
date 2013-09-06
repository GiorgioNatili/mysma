<h2><span>Banner sets</span></h2>

<div id="banners_list_sets">
  <table id="banners_sets_table" class="s_table s_mb_20" cellpadding="0" cellspacing="0" border="0">
    <thead>
    <tr>
      <td width="500">Banner set</td>
      <td>&nbsp;</td>
    </tr>
    </thead>
    <tbody>
    <?php foreach ($sets as $setId => $set): ?>
    <tr>
      <td><strong><?php echo $set['name']; ?></strong></td>
      <td>
        <a class="s_button_close right s_mr_0 delete_set" href="<?php echo $tbUrl->generate('default/deleteSet', 'setId=' . $setId); ?>">Delete</a>
        <a class="tb_button_edit right s_mr_5 openHere" href="<?php echo $tbUrl->generate('default/displaySet', 'setId=' . $setId); ?>">Edit</a>
      </td>
    </tr>
    <?php endforeach; ?>
    </tbody>
  </table>
</div>


<a class="s_button s_button_2 s_button_green right s_mr_0 openHere" href="<?php echo $tbUrl->generate('default/displaySet'); ?>">New banner set</a>

<script type="text/javascript">
$("#banners_sets_table a.delete_set").bind("click", function() {
  var url = $(this).attr("href");
  if (confirm ("Are you sure you want to delete this item?")) {
    $("#banners_list_sets").block("<h1>Deleting...</h1>");
    $.getJSON(url, function(response) {
      if (response.success == true) {
        $("#banners_extension").tbTabs("load", 1);
        displayAlertSuccess(response.message);
      } else {
        displayAlertWarning(response.message);
      }
      $("#banners_list_sets").unblock();
    });

    return false;
  }

  return false;
});
</script>