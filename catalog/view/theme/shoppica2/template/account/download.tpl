<?php echo $header; ?>

  <!-- ---------------------- -->
  <!--     I N T R O          -->
  <!-- ---------------------- -->
  <div id="intro">
    <div id="intro_wrap">
      <div class="s_wrap">
        <div id="breadcrumbs" class="s_col_12">
          <?php foreach ($breadcrumbs as $breadcrumb): ?>
          <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
          <?php endforeach; ?>
        </div>
        <h1><?php echo $heading_title; ?></h1>
      </div>
    </div>
  </div>
  <!-- end of intro -->

  <!-- ---------------------- -->
  <!--      C O N T E N T     -->
  <!-- ---------------------- -->
  <div id="content" class="s_wrap">
  
    <?php if ($tbData->common['column_position'] == "left" && $column_right): ?>
    <div id="left_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

    <div id="downloads" class="s_main_col">

      <?php echo $content_top; ?>
      
      <table class="s_table" width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
          <th class="s_cell_id"><?php echo $text_order; ?></th>
          <th class="s_cell_name"><?php echo $text_name; ?></th>
          <th class="s_cell_size"><?php echo $text_size; ?></th>
          <th class="s_cell_date"><?php echo $text_date_added; ?></th>
          <th class="s_cell_quantity"><?php echo $text_remaining; ?></th>
          <th class="s_cell_download">&nbsp;</th>
        </tr>
        <?php foreach ($downloads as $download): ?>
        <tr>
          <td><?php echo $download['order_id']; ?></td>
          <td class="s_cell_name">
            <strong class="inline s_hidden"><?php echo $download['remaining']; ?> x</strong>
            <?php echo $download['name']; ?>
            <?php if ($download['remaining'] > 0): ?>
            <strong class="s_hidden"><a class="s_main_color" href="<?php echo $download['href']; ?>"><?php echo $text_download; ?></a></strong>
            <?php endif; ?>
          </td>
          <td class="s_cell_size"><?php echo $download['size']; ?></td>
          <td class="s_cell_date"><?php echo $download['date_added']; ?></td>
          <td class="s_cell_quantity"><?php echo $download['remaining']; ?></td>
          <td class="s_cell_download">
            <?php if ($download['remaining'] > 0): ?>
            <a class="s_main_color" href="<?php echo $download['href']; ?>"><strong><?php echo $button_download; ?></strong></a>
            <?php endif; ?>
          </td>
        </tr>
        <?php endforeach; ?>
      </table>

      <div class="pagination"><?php echo $pagination; ?></div>

      <span class="clear border_ddd s_sep"></span>

      <div class="s_submit clearfix">
        <a class="s_button_1 s_main_color_bgr" href="<?php echo $continue; ?>"><span class="s_text"><?php echo $button_continue; ?></span></a>
      </div>

      <?php echo $content_bottom; ?>

    </div>

    <?php if ($tbData->common['column_position'] == "right" && $column_right): ?>
    <div id="right_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>
    
  </div>
  <!-- end of content -->


<?php echo $footer; ?>
