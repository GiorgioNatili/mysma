jQuery( function($) {

  // Slider options
  $("#image_intro").slides({
    preloadImage: '',
    effect: slideEffect,
    autoHeight: true,
    crossfade: true,
    preload: true,
    fadeSpeed: 800,
    slideSpeed: 800,
    next: 's_button_next',
    prev: 's_button_prev',
    play: 5000,
    generatePagination: false
  });

  // Next/Prev buttons hover effect
  $("#intro .s_button_prev, #intro .s_button_next").hover(
    function() {
      $(this).stop().animate({
          backgroundColor: '#' + $sReg.get('/tb/schemer_config/colors/secondary')
        },300
      );
    }
    ,
    function() {
      $(this).stop().animate({
          backgroundColor: '#' + $sReg.get('/tb/schemer_config/colors/main')
        },300
      );
    }
  );
  
});