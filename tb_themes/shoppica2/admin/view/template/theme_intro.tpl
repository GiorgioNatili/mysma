<h2><span><?php echo $text_title_intro; ?></span></h2>

<div class="s_row_2 first clearfix">
  <label><?php echo $text_label_category; ?></label>
  <select id="intro_categories" name="intro[category_path]">
    <?php if ($url_intro_category_id == 0): ?>
    <option value="0">*<?php echo $text_global; ?>*</option>
    <?php else: ?>
    <option value="<?php echo $tbUrl->generate('default/index'); ?>">*<?php echo $text_global; ?>*</option>
    <?php endif; ?>
    <?php foreach ($intro_categories as $category): ?>
    <?php if ($category['category_id'] == $url_intro_category_id): ?>
    <option value="<?php echo $category['path']; ?>" selected="selected"><?php echo $category['name']; ?></option>
    <?php else: ?>
    <option value="<?php echo $category['path']; ?>"><?php echo str_repeat('--', $category['level']) . ' ' . $category['name']; ?></option>
    <?php endif; ?>
    <?php endforeach; ?>
  </select>
</div>

<div id="intro_types">
  <?php require 'theme_intro_types.tpl'; ?>
</div>

<div class="s_submit clearfix">
  <a class="s_button" onclick="$('#form').submit();"><span class="s_icon_16"><span class="s_icon s_tick_16"></span><?php echo $text_button_save_settings; ?></span></a>
</div>


<script type="text/javascript">

$("#intro_categories").bind("change", function() {
  $("#intro_types").block({ message: "<h1>Loading...</h1>" });
  var ajaxurl = "<?php echo $tbUrl->generateJs('intro/categoryIntro'); ?>" + "&intro_category_path=" + $(this).val();
  $("#intro_types").load(ajaxurl, function() {
    $("#intro_types select").uniform();
    bindIntroEvents();
    $("#intro_type_choice").trigger("change");
    $("#intro_type_images_tabs a").tabs();
    $("#intro_types").unblock();
  });

  return false;
});

function bindIntroEvents() {

  $("#intro_type_choice").bind("change", function() {
    $('#intro_types > div[id^="intro_type"]').hide();
    $("#intro_type_" + $(this).val()).show();
  });

  $('#intro_type_products a.sModal').sModal({
    'width'   : 1000,
    'height'  : 620,
    'linktag' : function() {
      return $(this).attr("href") + "&category_path=" + $("#intro_categories").val();
    },
    'onShow' : function(obj) {

      $("#sm_ajaxContent .title_add").text($("#intro_categories :selected").text().replace(/^\s*/g, '').replace(/\s*$/g, ''));

      $("#sm_ajaxContent a.s_button_filter").bind("click", function() {
        var url = getProductsFilterUrl() + "&category_path=" + $("#intro_categories").val();
        obj.setContents(url);

        return false;
      });

      $("#sm_ajaxContent .reset_filter_button").bind("click", function() {
        $("#sm_ajaxContent .filter_form").clearForm();
        var url = getProductsFilterUrl() + "&category_path=" + $("#intro_categories").val();
        obj.setContents(url);

        return false;
      });

      $("#sm_ajaxContent div.pagination a").bind("click", function() {
        var url = $(this).attr("href") + "&category_path=" + $("#intro_categories").val();
        obj.setContents(url);

        return false;
      });

      $("#sm_ajaxContent form input").bind("keydown", function(e) {
        if (e.keyCode == 13) {
          var url = getProductsFilterUrl() + "&category_path=" + $("#intro_categories").val();
          obj.setContents(url);
        }
      });

      $("#sm_ajaxContent table.s_table thead a").bind("click", function() {
        var url = $(this).attr("href") + "&category_path=" + $("#intro_categories").val();
        obj.setContents(url);

        return false;
      });

      $("#sm_ajaxContent a.add_product").bind("click", function() {
        elem = $(this);
        if (elem.parents("tr:first").is(":not(.s_selected)")) {
          var action = "add";
          var url = '<?php echo str_replace('&amp;', '&', $tbUrl->generate('intro/addIntroBannerProduct')); ?>';
        } else {
          var action = "remove";
          var url = '<?php echo str_replace('&amp;', '&', $tbUrl->generate('intro/removeIntroBannerProduct')); ?>';
        }

        var url = url + '&product_id=' + $(this).prev("input").val()+ "&category_path=" + $("#intro_categories").val();
        $.get(url, function(data, textStatus) {
            if (action == "add") {
              elem.parents("tr:first").addClass("s_selected");
            } else {
              elem.parents("tr:first").removeClass("s_selected");
            }
            $("#intro_type_products span.intro_category_products_count").text(data.products_total);
        }, 'json');

        return false;
      });

    }
  });
}
bindIntroEvents();
$("#intro_type_choice").trigger("change");
$("#intro_type_images_tabs a").tabs();

function getProductsFilterUrl() {
  url = '<?php echo str_replace('&amp;', '&', $tbUrl->generate('intro/getIntroBannerProductsHtml')); ?>';

  var filter_name = $('input[name=\'filter_name\']').attr('value');
  if (filter_name) {
    url += '&filter_name=' + encodeURIComponent(filter_name);
  }

  var filter_model = $('input[name=\'filter_model\']').attr('value');
  if (filter_model) {
    url += '&filter_model=' + encodeURIComponent(filter_model);
  }

  var filter_price_less = $('input[name=\'filter_price_less\']').attr('value');
  if (filter_price_less) {
    url += '&filter_price_less=' + encodeURIComponent(filter_price_less);
  }

  var filter_price_more = $('input[name=\'filter_price_more\']').attr('value');
  if (filter_price_more) {
    url += '&filter_price_more=' + encodeURIComponent(filter_price_more);
  }

  var filter_price_equals = $('input[name=\'filter_price_equals\']').attr('value');
  if (filter_price_equals) {
    url += '&filter_price_equals=' + encodeURIComponent(filter_price_equals);
  }

  if ($('input[name=\'filter_selected\']').is(":checked")) {
    url += '&filter_selected=1';
  }

  return url;
}

</script>