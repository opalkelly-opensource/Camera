'use strict';

/**
 * Initialize carousels (Slick.js)
 */
var Carousel = function ($) {
  var $carousel = $('.js-carousel');
  var options = {
    dots: true,
    infinite: false
  };

  /**
   * Init
   */
  var init = function init() {
    $carousel.slick(options);
  };

  /**
   * Return
   * @return {function}
   */
  return {
    init: init
  };
}(jQuery);

/**
 * Initialize on load
 */
Carousel.init();