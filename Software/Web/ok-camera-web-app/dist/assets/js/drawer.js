'use strict';

/**
 * Drawer
 */
var Drawer = function ($) {
  var drawer = '.drawer';
  var toggleAction = '[data-toggle="drawer"]';
  var closeAction = '[data-dismiss="drawer"]';
  var visibilityClass = 'show';

  /**
   * Init
   */
  var init = function init() {
    $(document).on('click', toggleAction, toggle);
    $(document).on('click', closeAction, close);
  };

  /**
   * Toggle (show/hide)
   * @param {object} e
   */
  var toggle = function toggle(e) {
    e.preventDefault();

    $($(e.target).attr('href')).toggleClass(visibilityClass);
  };

  /**
   * Close/Hide
   * @param {object} e
   */
  var close = function close(e) {
    e.preventDefault();

    $(e.target).closest(drawer).removeClass(visibilityClass);
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
Drawer.init();