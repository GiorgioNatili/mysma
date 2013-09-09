<?php if (!isset($tbData)) require dirname(__FILE__) . '/../tb/install_error.tpl'; ?>

<?php if ($module_position == 'content_top' || $module_position == 'content_bottom'): ?>
<!-- ---------------------- -->
<!--      Content           -->
<!-- ---------------------- -->
<div class="s_module_content clearfix">
	<h2><?php echo $heading_title; ?></h2>
	<?php echo $message; ?>
</div>
<!--      End of Content    -->

<?php else: ?>
<!-- ---------------------- -->
<!--      Column            -->
<!-- ---------------------- -->
<div class="welcome s_box">
	<h2><?php echo $heading_title; ?></h2>
	<?php echo $message; ?>
</div>
<!--      End of Column     -->
<?php endif; ?>