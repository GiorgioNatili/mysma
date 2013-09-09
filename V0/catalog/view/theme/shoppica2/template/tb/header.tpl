<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<?php if (null === $tbData->is_touch || $tbData->do_javascript_detection): ?>
<script type="text/javascript">
function createCookie(name,value,days) {
  if (days) {
    var date = new Date();
    date.setTime(date.getTime()+(days*24*60*60*1000));
    var expires = "; expires="+date.toGMTString();
  }
  else var expires = "";
  document.cookie = name+"="+value+expires+"; path=/";
}
</script>
<?php endif; ?>
<?php if ($tbData->do_javascript_detection): ?>
<script type="text/javascript">
if (screen.width < 767) {
  createCookie("is_mobile", "1", 7);
  createCookie("is_touch", "1", 7);
  window.location.reload();
} else {
  createCookie("is_mobile", "0", 7);
}
</script>
<?php endif; ?>
<?php if (false === $tbData->touch_detected): ?>
<script>
;window.Modernizr=function(a,b,c){function v(a){i.cssText=a}function w(a,b){return v(l.join(a+";")+(b||""))}function x(a,b){return typeof a===b}function y(a,b){return!!~(""+a).indexOf(b)}function z(a,b,d){for(var e in a){var f=b[a[e]];if(f!==c)return d===!1?a[e]:x(f,"function")?f.bind(d||b):f}return!1}var d="2.5.3",e={},f=b.documentElement,g="modernizr",h=b.createElement(g),i=h.style,j,k={}.toString,l=" -webkit- -moz- -o- -ms- ".split(" "),m={},n={},o={},p=[],q=p.slice,r,s=function(a,c,d,e){var h,i,j,k=b.createElement("div"),l=b.body,m=l?l:b.createElement("body");if(parseInt(d,10))while(d--)j=b.createElement("div"),j.id=e?e[d]:g+(d+1),k.appendChild(j);return h=["&#173;","<style>",a,"</style>"].join(""),k.id=g,m.innerHTML+=h,m.appendChild(k),l||(m.style.background="",f.appendChild(m)),i=c(k,a),l?k.parentNode.removeChild(k):m.parentNode.removeChild(m),!!i},t={}.hasOwnProperty,u;!x(t,"undefined")&&!x(t.call,"undefined")?u=function(a,b){return t.call(a,b)}:u=function(a,b){return b in a&&x(a.constructor.prototype[b],"undefined")},Function.prototype.bind||(Function.prototype.bind=function(b){var c=this;if(typeof c!="function")throw new TypeError;var d=q.call(arguments,1),e=function(){if(this instanceof e){var a=function(){};a.prototype=c.prototype;var f=new a,g=c.apply(f,d.concat(q.call(arguments)));return Object(g)===g?g:f}return c.apply(b,d.concat(q.call(arguments)))};return e});var A=function(c,d){var f=c.join(""),g=d.length;s(f,function(c,d){var f=b.styleSheets[b.styleSheets.length-1],h=f?f.cssRules&&f.cssRules[0]?f.cssRules[0].cssText:f.cssText||"":"",i=c.childNodes,j={};while(g--)j[i[g].id]=i[g];e.touch="ontouchstart"in a||a.DocumentTouch&&b instanceof DocumentTouch||(j.touch&&j.touch.offsetTop)===9},g,d)}([,["@media (",l.join("touch-enabled),("),g,")","{#touch{top:9px;position:absolute}}"].join("")],[,"touch"]);m.touch=function(){return e.touch};for(var B in m)u(m,B)&&(r=B.toLowerCase(),e[r]=m[B](),p.push((e[r]?"":"no-")+r));return v(""),h=j=null,e._version=d,e._prefixes=l,e.testStyles=s,e}(this,this.document);
if (Modernizr.touch){
  createCookie("is_touch", "1", 7);
  var head = document.getElementsByTagName('head')[0],
      style = document.createElement('style'),
      rules = document.createTextNode('.s_grid_view .s_item .s_actions { display: block !important; }');
  style.type = 'text/css';
  if(style.styleSheet)
      style.styleSheet.cssText = rules.nodeValue;
  else style.appendChild(rules);
  head.appendChild(style);
} else {
  createCookie("is_touch", "0", 7);
}
</script>
<?php endif; ?>
<?php echo $tbData->fbMeta; ?>
<link rel="stylesheet" type="text/css" href="<?php echo $tbData->theme_stylesheet_url; ?>screen.css.php?v=<?php echo $tbData->theme_version; ?>&amp;<?php echo http_build_query($tbData->css_fontvars, '', '&amp;'); ?>" media="screen" />
<!--[if lt IE 9]>
<link rel="stylesheet" type="text/css" href="<?php echo $tbData->theme_stylesheet_url; ?>ie.css.php?v=<?php echo $tbData->theme_version; ?>&amp;theme=<?php echo $tbData->basename; ?>" media="screen" />
<![endif]-->
<?php foreach ($tbData->webfonts as $font): ?>
<link href='http<?php if($tbData->isHTTPS) echo 's'?>://fonts.googleapis.com/css?family=<?php echo $font['family']; ?>&amp;subset=<?php echo $font['subset']; ?>' rel='stylesheet' type='text/css'>
<?php endforeach; ?>
<style type="text/css"><?php echo $tbData->schemer_css; ?> <?php echo $tbData->custom_stylesheet; ?></style>

<script type="text/javascript" src="http<?php if($tbData->isHTTPS) echo 's'?>://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script type="text/javascript" src="http<?php if($tbData->isHTTPS) echo 's'?>://ajax.googleapis.com/ajax/libs/jqueryui/1.8.21/jquery-ui.min.js"></script>

<?php echo $tbData->getJavascriptRegistry(); ?>

<script type="text/javascript">
  $.widget("tb.tbTabs", $.ui.tabs, {});
  $(document).ready(function () {
    <?php if ($tbData->is_mobile && $tbData->route != 'common/home'): ?>
    window.location.hash = 'intro';
    <?php endif; ?>
    <?php if ($tbData->category_path != '0'): ?>
    $.each($sReg.get("/tb/category_path").split("_"), function(number, id){ $("#menu_" + id).addClass("s_selected"); });
    <?php endif; ?>
  });
</script>