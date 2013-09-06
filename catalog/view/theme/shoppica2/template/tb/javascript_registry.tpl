<script type="text/javascript">var $sReg=new function(){function c(){var a=Array.prototype.slice.call(arguments);a.unshift({});return b.apply(null,a)}function b(c){for(var d=1,e=arguments.length;d<e;d++){var f=arguments[d];if(typeof f!="object")continue;for(var g in f){var h=f[g],i=c[g];c[g]=i&&typeof h=="object"&&typeof i=="object"?b(i,h):a(h)}}return c}function a(b){var c;switch(typeof obj){case"object":c={};for(var d in b)c[d]=a(b[d]);break;case"array":c=[];for(var e=0,f=b.length;e<f;e++)c[e]=a(b[e]);break;default:return b}return c}var d={conf:{},set:function(a,b){var d=a.split("/");if(d.shift()!==""){return false}if(d.length>0&&d[d.length-1]==""){d.pop()}var e={};var f=e;var g=d.length;if(g>0){for(i=0;i<g-1;i++){f[d[i]]={};f=f[d[i]]}f[d[g-1]]=b;this.conf=c(this.conf,e)}else{this.conf=b}},get:function(a){var b=a.split("/");if(b.shift()!==""){return null}if(b.length>0&&b[b.length-1]=="")b.pop();var c=this.conf;var d=true;var e=0;if(c[b[e]]===undefined){return null}var f=b.length;while(d&&e<f){d=d&&c[b[e]]!==undefined;c=c[b[e]];e++}return c}};return d}
<?php
foreach ($jsarr as $key => $value) {
    if (is_array($value) || is_object($value)) {
        $value_str = "jQuery.parseJSON('" . addcslashes(json_encode($value), "'") . "')";
    } else {
        $value_str = "'" . $value . "'";
    }
    echo "\$sReg.set('$key', $value_str);";
}
?>
</script>
