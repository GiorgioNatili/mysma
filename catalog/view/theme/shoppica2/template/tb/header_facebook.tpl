<div id="fb-root"></div>
<script type="text/javascript">
  window.fbAsyncInit = function() {
    FB.init({
      <?php if($tbData->footerInfo['facebook_appid']): ?>appId: '<?php echo $tbData->footerInfo['facebook_appid']; ?>',<?php endif; ?>
      <?php if($tbData->footerInfo['facebook_channel']): ?>channelUrl : '<?php echo $tbData->footerInfo['facebook_channel']; ?>',<?php endif; ?>
      status: true,
      cookie: true,
      xfbml: true,
      oauth : true
    });
  };
  (function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/<?php if($tbData->footerInfo['facebook_locale']): echo $tbData->footerInfo['facebook_locale']; else: echo 'en_US'; endif; ?>/all.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));
</script>