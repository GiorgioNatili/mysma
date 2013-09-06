<?php echo $header; ?>

<style type="text/css">
html.blocked {
        overflow: hidden;
}
#loading_screen {
        z-index: 99999;
        position: fixed;
        top: 90px;
        left: 0;
        width: 100%;
        height: 100%;
        text-align: center;
        font-size: 18px;
        color: #fff;
        background: #fff;
}
</style>
<script type="text/javascript">

jQuery.cookie=function(key,value,options){if(arguments.length>1&&String(value)!=="[object Object]"){options=jQuery.extend({},options);if(value===null||value===undefined){options.expires=-1}if(typeof options.expires==="number"){var days=options.expires,t=options.expires=new Date();t.setDate(t.getDate()+days)}value=String(value);return(document.cookie=[encodeURIComponent(key),"=",options.raw?value:encodeURIComponent(value),options.expires?"; expires="+options.expires.toUTCString():"",options.path?"; path="+options.path:"",options.domain?"; domain="+options.domain:"",options.secure?"; secure":""].join(""))}options=value||{};var result,decode=options.raw?function(s){return s}:decodeURIComponent;return(result=new RegExp("(?:^|; )"+encodeURIComponent(key)+"=([^;]*)").exec(document.cookie))?decode(result[1]):null};

$("html").addClass('blocked');
$("body").append('<div id="loading_screen">LOADING...</div>');

var w = $(window).width();
var h = $(window).height();

$("#loading_screen").width(w)
$("#loading_screen").height(h-90)

$(window).load(function () {
        $("#loading_screen").fadeOut("normal");
        $("html").removeClass('blocked');
});
</script>

<link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=PT+Sans+Narrow:400,700&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="<?php echo $theme_admin_stylesheet_url; ?>cp.css" />
<link rel="stylesheet" type="text/safari" href="<?php echo $theme_admin_stylesheet_url; ?>webkit.css" />
<link rel="stylesheet" type="text/chrome" href="<?php echo $theme_admin_stylesheet_url; ?>webkit.css" />
<!--[if lt IE 9]>
<link rel="stylesheet" type="text/css" href="<?php echo $theme_admin_stylesheet_url; ?>ie8.css" media="screen" />
<![endif]-->
<!--[if gt IE 8]>
<link rel="stylesheet" type="text/css" href="<?php echo $theme_admin_stylesheet_url; ?>ie9.css" media="screen" />
<![endif]-->
<link rel="stylesheet" type="text/css" href="<?php echo $theme_admin_stylesheet_url; ?>farm-fresh.css" />
<link rel="stylesheet" type="text/css" href="<?php echo $theme_admin_stylesheet_url; ?>ui-lightness/ui-lightness-1.8.16.custom.css" />
<script type="text/javascript" src="<?php echo $theme_admin_javascript_url; ?>jquery.form.js"></script>
<script type="text/javascript" src="<?php echo $theme_admin_javascript_url; ?>jquery.blockUI.js"></script>
<script type="text/javascript" src="<?php echo $theme_admin_javascript_url; ?>sModal/js/sModal.js"></script>
<link rel="stylesheet" type="text/css" href="<?php echo $theme_admin_javascript_url; ?>sModal/css/sModal.css" />
<script type="text/javascript" src="<?php echo $theme_admin_javascript_url; ?>uniform/js/jquery.uniform.js"></script>
<link rel="stylesheet" type="text/css" href="<?php echo $theme_admin_javascript_url; ?>uniform/css/uniform.default.css" />
<script type="text/javascript" src="<?php echo $theme_admin_javascript_url; ?>iButton/lib/jquery.metadata.js"></script>
<script type="text/javascript" src="<?php echo $theme_admin_javascript_url; ?>iButton/lib/jquery.ibutton.js"></script>
<link rel="stylesheet" type="text/css" href="<?php echo $theme_admin_javascript_url; ?>iButton/css/jquery.ibutton.css" />
<script type="text/javascript" src="<?php echo $theme_admin_javascript_url; ?>multiselect/js/jquery.multiselect.js"></script>
<link rel="stylesheet" type="text/css" href="<?php echo $theme_admin_javascript_url; ?>multiselect/css/jquery.multiselect.css" media="all" />

<script type="text/javascript">
$.widget("tb.tbTabs", $.ui.tabs, {});
$("link[rel=stylesheet][href*=jquery-ui][href*=custom]").remove();
</script>

<div id="content">

<div class="tb_cp">
<div id="tb_cp_wrap">

  <div id="tb_cp_header">
  <div id="tb_cp_header_wrap" class="clearfix">
        <h1><?php echo $text_heading_title; ?></h1>
    <div id="tb_store_select">
        <div class="s_row_">
        <label class="inline">Store</label>
        <select class="inline" id="oc_store">
          <option value="<?php echo HTTPS_SERVER . 'index.php?route=module/' . $basename . '&token=' . $this->session->data['token']; ?>"<?php if($store_id == 0) echo ' selected="selected"'; ?>>Default</option>
          <?php foreach ($stores as $store): ?>
          <option value="<?php echo HTTPS_SERVER . 'index.php?route=module/' . $basename . '&store_id=' . $store['store_id'] . '&token=' . $this->session->data['token']; ?>"<?php if($store_id == $store['store_id']) echo ' selected="selected"'; ?>><?php echo $store['name']; ?></option>
          <?php endforeach; ?>
        </select>
      </div>
    </div>
  </div>
  </div>

  <span class="clear"></span>

  <div id="tb_cp_content" class="clearfix">

  <div id="tb_error_alert" class="s_server_msg s_msg_red"<?php if(!$error_alert): ?> style="display: none"<?php endif; ?>>
    <p class="s_icon_32"><span class="s_icon s_cancel_32"></span><span class="tb_alert_text"><?php echo $error_alert; ?></span></p>
    <a class="s_close" href="javascript:;"></a>
  </div>
  <div id="tb_warning_alert" class="s_server_msg s_msg_yellow"<?php if(!$warning_alert): ?> style="display: none"<?php endif; ?>>
    <p class="s_icon_32"><span class="s_icon s_error_32"></span><span class="tb_alert_text"><?php echo $warning_alert; ?></span></p>
    <a class="s_close" href="javascript:;"></a>
  </div>
  <div id="tb_success_alert" class="s_server_msg s_msg_green"<?php if(!$success_alert): ?> style="display: none"<?php endif; ?>>
    <p class="s_icon_32"><span class="s_icon s_accept_32"></span><span class="tb_alert_text"><?php echo $success_alert; ?></span></p>
    <a class="s_close" href="javascript:;"></a>
  </div>

  <div id="tb_cp_content_wrap" class="clearfix">

    <div id="tb_cp_navigation" class="tb_tabs tb_vtabs">
      <div class="tb_tabs_nav clearfix">
        <ul>
          <li><a href="#common_settings"><span class="s_icon_16"><span class="s_icon s_wrench_orange_16"></span><?php echo $text_menu_general; ?></span></a></li>
          <li><a href="#store_settings"><span class="s_icon_16"><span class="s_icon s_cart_16"></span><?php echo $text_menu_store; ?></span></a></li>
          <li><a href="#design_settings"><span class="s_icon_16"><span class="s_icon s_palette_16"></span><?php echo $text_menu_design; ?></span></a></li>
          <li><a href="#intro_settings"><span class="s_icon_16"><span class="s_icon s_images_16"></span><?php echo $text_menu_intro; ?></span></a></li>
          <li><a href="#footer_settings"><span class="s_icon_16"><span class="s_icon s_layout_footer_16"></span><?php echo $text_menu_footer; ?></span></a></li>
          <?php $tbSlot->flag('tb\theme.tabs.navigation'); ?>
          <li><a href="#extension_settings"><span class="s_icon_16"><span class="s_icon s_plugin_16"></span>Extensions</span></a></li>
        </ul>
      </div>
    </div>

    <div id="tb_cp_modules">

      <form action="<?php echo $tbUrl->generate('default'); ?>" method="post" enctype="multipart/form-data" id="form">

        <input type="hidden" name="store_id" value="<?php echo $store_id; ?>" />

        <div id="common_settings" class="divtab">
          <?php require(TB_Utils::vqmodCheck(dirname(__FILE__) . '/theme_common.tpl')); ?>
        </div>

        <div id="store_settings" class="divtab">
          <?php require(TB_Utils::vqmodCheck(dirname(__FILE__) . '/theme_store.tpl')); ?>
        </div>

        <div id="design_settings" class="divtab">
          <?php require(TB_Utils::vqmodCheck(dirname(__FILE__) . '/theme_design.tpl')); ?>
        </div>

        <div id="intro_settings" class="divtab">
          <?php require(TB_Utils::vqmodCheck(dirname(__FILE__) . '/theme_intro.tpl')); ?>
        </div>

        <div id="footer_settings" class="divtab">
          <?php require(TB_Utils::vqmodCheck(dirname(__FILE__) . '/theme_footer.tpl')); ?>
        </div>

        <div id="extension_settings" class="divtab">
          <?php require(TB_Utils::vqmodCheck(dirname(__FILE__) . '/theme_extensions.tpl')); ?>
        </div>

      </form>

      <?php $tbSlot->flag('tb\theme.tabs.content'); ?>

    </div>

  </div>
  </div>

  <div id="tb_cp_footer">
  </div>

  <div id="#ajax_errorlog"></div>


</div>
</div>

<script type="text/javascript">

  $(document).ready(function (){
    $("#tb_cp_wrap .tb_toggle").iButton();
    $("#tb_cp_wrap").find("select, input:file, input:checkbox, input:radio").not(".tb_toggle, .tb_multiselect").uniform();
        $("#tb_cp_wrap .tb_multiselect").multiselect({
                header: false,
                noneSelectedText: '<?php echo $text_label_font_options; ?>',
                selectedList: 2
        });

  });

  $("#oc_store").bind("change", function() {
    window.location = $(this).val();
  });

  var theTimeout = setTimeout(function() {
    $("div.success").hide("slow");
  }, 5000);
  $("div#yourdiv").mouseover(function() {
    clearTimeout(theTimeout);
  });

  function getQueryVar(query, variable) {
    var urlParams = {};
    var e,
        a = /\+/g,  // Regex for replacing addition symbol with a space
        r = /([^&=]+)=?([^&]*)/g,
        d = function (s) { return decodeURIComponent(s.replace(a, " ")); },
        q = query;

    while (e = r.exec(q))
       urlParams[d(e[1])] = d(e[2]);

    if (variable in urlParams) {
      return urlParams[variable];
    }

    return null
  }

  function getUrlVar(variable) {

    return getQueryVar(window.location.search.substring(1), variable);
  }

  function guidGenerator() {
      var S4 = function() {
         return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
      };
      return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
  }

  $('#tb_cp_content_wrap').tbTabs({
    cookie: {
      expires: 2000,
      name: "tbmenumaintabs"
    },
    cache: true,
    select : function (event, ui) {
      var url = $.data(ui.tab, 'load.tabs');
      if(url && true !== $.data(ui.tab, "cache.tabs")) {
        $.getJSON('<?php echo HTTP_SERVER; ?>isLogged.php', function(data) {
          if (data != true) {
            $("body").empty();
            location.reload();
          }
        });
      }

      return true;
    }
  });

  $.ajaxSetup({
    complete: function(jqXHR) {
      var basename = '<?php echo $basename; ?>';
      if (getQueryVar(this.url.split("?", 2)[1], "route") == "module/" + basename &&
        jqXHR.getResponseHeader("Theme-Basename") != basename) {
        $.getJSON('<?php echo HTTP_SERVER; ?>isLogged.php', function(data) {
          if (data != true) {
            $("body").empty();
            location.reload();
          }
        });
      }
    }
  });

  $("#ajax_errorlog").ajaxError(function(e, jqxhr, settings, exception) {
    displayAlertError(exception + "\r\n" + jqxhr.statusText + "\r\n" + jqxhr.responseText);
    $(this).append(exception + "\r\n" + jqxhr.statusText + "\r\n" + jqxhr.responseText);
  });

  function displayAlertError(msg)
  {
    $("#tb_error_alert").show().find("span.tb_alert_text").text(msg);
  }

  function displayAlertWarning(msg)
  {
    $("#tb_warning_alert").show().find("span.tb_alert_text").text(msg);
  }

  function displayAlertSuccess(msg)
  {
    $("#tb_success_alert").show().find("span.tb_alert_text").text(msg);
  }

  $("#tb_cp_content > div.s_server_msg a.s_close").bind("click", function() {
     $(this).parent("div.s_server_msg").hide();
  });

</script>

<script type="text/javascript">

function image_upload(field, preview) {
  $('#dialog').remove();

  $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

  $('#dialog').dialog({
    title: '<?php echo $text_image_manager; ?>',
    close: function (event, ui) {
      if ($('#' + field).attr('value')) {
        $.ajax({
          url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
          dataType: 'text',
          success: function(data) {
            $('#' + preview).replaceWith('<img src="' + data + '" alt="" id="' + preview + '" class="image" onclick="image_upload(\'' + field + '\', \'' + preview + '\');" />');
          }
        });
      }
    },
    bgiframe: false,
    width: 700,
    height: 400,
    resizable: false,
    modal: false,
    open: function(event, ui) {
      $(event.target).parents("div.ui-dialog:first").wrap('<div class="tb_jquery_ui"></div>');
    }
  });
};

function addImage(table_id, varname, language_id) {
  var table = $("#" + table_id);
  var image_row = table.find("tr.image_row").length + 1;

  html = '<tr id="image_row_' + language_id + '_' + image_row + '" class="image_row">\
            <td>\
              <input type="hidden" name="' + varname + '[images][' + language_id + '][files][' + image_row + '][image]" id="image_' + language_id + '_' + image_row + '" />\
              <img src="<?php echo $no_image; ?>" alt="" id="preview_' + language_id + '_' + image_row + '" class="image" onclick="image_upload(\'image_' + language_id + '_' + image_row + '\', \'preview_' + language_id + '_' + image_row + '\');" />\
            </td>\
            <td><input class="ord_num" type="text" name="' + varname + '[images][' + language_id + '][files][' + image_row + '][order]" style="width: 15px;" size="1" /></td>\
            <td><input class="url" type="text" name="' + varname + '[images][' + language_id + '][files][' + image_row + '][url]"  style="width: 98%;" /></td>\
            <td><a onclick="$(\'#image_row_' + language_id + '_' + image_row  + '\').remove();" class="s_button_close">Remove</a></td>\
          </tr>';

  table.append(html);
}
</script>

<?php if ($first_time == 1): ?>
<script type="text/javascript">
  $("#tb_warning_alert").show().find("span.tb_alert_text").append('<span style="display: block; text-align: left; font-weight: normal; padding-right: 40px;">If you want to install sample data, click on the install button. <a id="confirm_install_sample_data" class="s_button s_button_2 s_ml_20 right" href="<?php echo $tbUrl->generate('default/installSampleData'); ?>"><span class="s_icon_16"><span class="s_icon s_database_add_16"></span><?php echo $text_install; ?></span></a> This message will no longer appear once you save the theme settings.');
  $("#confirm_install_sample_data").bind("click", function() {
    if (confirm('Attention! This action will erase your current theme settings and will install sample ones. It will also change your system image settings.')) {
      $.getJSON($(this).attr("href"), function(data) {
        $("#tb_warning_alert").hide();
        if (data.success == true) {
          $("#tb_cp_content_wrap").block("<h1>Loading...</h1>");
          location.reload();
        } else {
          displayAlertError(data.message);
        }
      });

      return false;
    } else {
      return false;
    }
  });
</script>
<?php endif; ?>

<!-- The closing </div> of the <div id="content"> is in the footer.tpl -->

<?php echo $footer; ?>