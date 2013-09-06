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

    <div id="transactions" class="s_main_col">
  
      <?php echo $content_top; ?>

      <p><?php echo $text_balance; ?><b> <?php echo $balance; ?></b>.</p>
      <table class="s_table" width="100%" cellpadding="0" cellspacing="0" border="0">
        <thead>
          <tr>
            <th><?php echo $column_date_added; ?></th>
            <th><?php echo $column_description; ?></th>
            <th><?php echo $column_amount; ?></th>
          </tr>
        </thead>
        <tbody>
          <?php if ($transactions) { ?>
          <?php foreach ($transactions  as $transaction) { ?>
          <tr>
            <td><?php echo $transaction['date_added']; ?></td>
            <td><?php echo $transaction['description']; ?></td>
            <td><?php echo $transaction['amount']; ?></td>
          </tr>
          <?php } ?>
          <?php } else { ?>
          <tr>
            <td class="center" colspan="5"><?php echo $text_empty; ?></td>
          </tr>
          <?php } ?>
        </tbody>
      </table>
      
      <div class="pagination"><?php echo $pagination; ?></div>
      
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