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

    <div id="tracking_code" class="s_main_col">

      <?php echo $content_top; ?>

      <p><?php echo $text_description; ?></p>

      <div class="s_row_2 clearfix">
        <label><?php echo $text_code; ?></label>
        <input type="text" size="43" name="product" value="<?php echo $code; ?>" />
      </div>
      <div class="s_row_2 clearfix">
        <label><?php echo $text_generator; ?></label>
        <input type="text" size="43" name="product" value="" />
      </div>
      <div class="s_row_2 s_sep clearfix">
        <label><?php echo $text_link; ?></label>
        <textarea name="link" cols="40" rows="5"></textarea>
      </div>

      <span class="clear s_sep border_eee"></span>

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

    <link rel="stylesheet" type="text/css" href="<?php echo $tbData->theme_stylesheet_url; ?>jquery_ui/jquery-ui-1.8.14.custom.css" media="screen" />
    <script type="text/javascript"><!--
    $(document).ready( function() {
  
      $('input[name=\'product\']').autocomplete({
        delay: 300,
        create: function() {
          var newclass = 's_jquery_ui';
          $('body > ul.ui-autocomplete').wrap('<div class="'+newclass+'"></div>');
        },
        source: function(request, response) {
            $.ajax({
                url: 'index.php?route=affiliate/tracking/autocomplete&filter_name=' +  encodeURIComponent(request.term),
                dataType: 'json',
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            label: item.name,
                            value: item.link
                        }
                    }));
                }
            });
    
        },
        select: function(event, ui) {
          $('input[name=\'product\']').attr('value', ui.item.label);
          $('textarea[name=\'link\']').attr('value', ui.item.value);
    
          return false;
        },
        focus: function(event, ui) {
          return false;
        }
      });
  
    });
    //--></script>

  </div>
  <!-- end of content -->


<?php echo $footer; ?>