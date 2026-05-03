'use strict';

/**
 * Open external links in new window
 * Originally from https://css-tricks.com/snippets/jquery/open-external-links-in-new-window/
 */
var Anchor = function ($) {
  var selector = 'a';

  /**
   * Init
   */
  var init = function init() {
    $(document).on('click', selector, handleClick);
  };

  /**
   * Handle click
   * @param {object} e
   */
  var handleClick = function handleClick(e) {
    var $target = $(e.target);
    var $anchor = $target.is('a') ? $target : $target.closest('a');
    var href = $anchor.prop('href');
    var a = new RegExp('/' + window.location.host + '/');

    if ($anchor.is('a[href*="mailto"]')) {
      return;
    }

    if (!a.test(href)) {
      e.preventDefault();
      window.open(href, '_blank');
    }
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
Anchor.init();