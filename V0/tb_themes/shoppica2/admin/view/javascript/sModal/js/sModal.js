/*
 * sModal - a jQuery plugin for very simple modal box, Firefox3+, Safari4+, IE7+
 * @version 0.2.0
 * @requires jQuery v1.3.2 or later
 *
 * Copyright (c) 2010 Stoyan Kyosev (http://themeburn.com)
 */

(function($) {

$.fn.sModal = function(options) {

    if (!this.length) return this;

    options = $.extend({
        width:   450,
        height:  345,
        linktag: 'href',
        onShow:  function(){}
    }, options || {});

    this.each(function() {

        var $this = $(this);

        $(this).bind("click", function() {

            var context = this;
            var $tbwindow = createWindow(options.width, options.height);

            if (jQuery.isFunction(options.linktag)) {
                var url = options.linktag.call(this);
            } else {
                var url = $(this).attr(options.linktag);
            }

            this.setContents = function(url, callback) {
                setLoading($tbwindow);
                $.get(url, function(data, textStatus) {
                    $("#sm_ajaxContent").empty().append(data);
                    removeLoading($tbwindow);
                    options.onShow.call(this, context);
                    if (jQuery.isFunction(callback)) {
                        callback.call(this);
                    }
                });
            }

            this.setContents(url);

            return false;
        });
    });

    function createWindow(width, height) {

        var $htmlbox = '';
        var $margin_left = (width)/2;
        var $margin_top  = (height)/2;

        $htmlbox += '<div id="sm_overlay" class="sm_overlayBG"></div>';
        $htmlbox += '<div id="sm_window" style="margin-left: -' + $margin_left + 'px; width: ' + width + 'px; height: ' + height + 'px; margin-top: -' + $margin_top + 'px; display: block;">';
        $htmlbox += '  <a id="sm_closeWindowButton" href="#">close</a>';
        $htmlbox += '  <div id="sm_ajaxContent"></div> \
                       <span id="sm_logo"></span> \
                     </div>';

        $("body").append($htmlbox);
        $tbwindow = $("#sm_window");

        $("#sm_closeWindowButton, #sm_overlay").bind("click", function() {

            return closeWindow($tbwindow);
        });

        return $tbwindow;
    }

    function setLoading($tbwindow) {

        $("#sm_ajaxContent", $tbwindow).addClass("sm_ajaxLoading");
    }

    function removeLoading(tbwindow) {

        $("#sm_ajaxContent", $tbwindow).removeClass("sm_ajaxLoading");
    }

    function closeWindow($tbwindow) {

        $tbwindow.fadeOut("fast", function(){
            $("#sm_window, #sm_overlay")
                .unbind()
                .remove();
        });

        return false;
    }
}

})(jQuery);
