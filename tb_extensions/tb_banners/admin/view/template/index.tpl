<div id="banners_extension" class="tb_tabs tb_htabs tb_top_tabs">
  <ul class="tb_tabs_nav clearfix">
    <li><a href="<?php echo $tbUrl->generate('default/listPositions'); ?>" title="bannerPositions">Banner Positions</a></li>
    <li><a href="<?php echo $tbUrl->generate('default/listSets'); ?>" title="bannerSets">Banner Sets</a></li>
  </ul>

  <div id="bannerPositions"></div>
  <div id="bannerSets"></div>
</div>

<script type="text/javascript">

$('#banners_extension').tbTabs({
    cookie: {
      expires: 2000
    },
    load: function(event, ui) {
        $(ui.panel).find("a.openHere").bind("click", function() {
            $(ui.panel).load(this.href, function() {
              $(ui.panel).find("select").uniform();
            });

            return false;
        });
    },
    select : function (event, ui) {
      var url = $.data(ui.tab, 'load.tabs');
      if(url && true !== $.data(ui.tab, "cache.tabs")) {
        $(ui.panel).html("Loading...");
      }
      return true;
    }
  });

</script>
