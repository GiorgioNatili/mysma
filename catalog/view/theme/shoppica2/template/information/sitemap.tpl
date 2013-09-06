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

    <div id="sitemap" class="s_info_page s_main_col">

      <?php echo $content_top; ?>
      
      <span class="clear"></span>

      <div class="s_list_1">

        <ul>
          <?php foreach ($categories as $category_1): ?>
          <li><a href="<?php echo $category_1['href']; ?>"><?php echo $category_1['name']; ?></a>
            <?php if ($category_1['children']): ?>
            <ul>
              <?php foreach ($category_1['children'] as $category_2): ?>
              <li><a href="<?php echo $category_2['href']; ?>"><?php echo $category_2['name']; ?></a>
                <?php if ($category_2['children']): ?>
                <ul>
                  <?php foreach ($category_2['children'] as $category_3): ?>
                  <li><a href="<?php echo $category_3['href']; ?>"><?php echo $category_3['name']; ?></a></li>
                  <?php endforeach; ?>
                </ul>
                <?php endif; ?>
              </li>
              <?php endforeach; ?>
            </ul>
            <?php endif; ?>
          </li>
          <?php endforeach; ?>
        </ul>

        <ul>
          <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
          <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a>
            <ul>
              <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
              <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
              <li><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
              <li><a href="<?php echo $history; ?>"><?php echo $text_history; ?></a></li>
              <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
            </ul>
          </li>
          <li><a href="<?php echo $cart; ?>"><?php echo $text_cart; ?></a></li>
          <li><a href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></li>
          <li><a href="<?php echo $search; ?>"><?php echo $text_search; ?></a></li>
          <li><?php echo $text_information; ?>
            <ul>
              <?php foreach ($informations as $information): ?>
              <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
              <?php endforeach; ?>
              <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
            </ul>
          </li>
        </ul>
        
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
