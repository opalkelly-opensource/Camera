'use strict';

/**
 * Responsive breadcrumbs
 */
var Breadcrumb = function ($) {
  var $breadcrumbs = $('.js-breadcrumbs');
  var $moreAction = $breadcrumbs.find('.breadcrumb-more');
  var $dropdown = $moreAction.find('.dropdown-menu');
  var itemSelector = '.breadcrumb-item';
  var visibleItemsSelector = '> .breadcrumb-item:not(.breadcrumb-more)';
  var hiddenClass = 'hidden';
  var debounceDelay = 250;

  /**
   * Init
   */
  var init = function init() {
    handleBreadcrumbs();

    $(window).on('resize', $.debounce(debounceDelay, handleBreadcrumbs));
  };

  /**
   * Handle responsiveness
   */
  var handleBreadcrumbs = function handleBreadcrumbs() {
    var navWidth = 0;
    var moreWidth = $moreAction.outerWidth(true);
    var $visibleItems = $breadcrumbs.find(visibleItemsSelector);
    var availableSpace = $breadcrumbs.parent().width() - moreWidth;

    $visibleItems.each(function () {
      navWidth += $(this).outerWidth(true);
    });

    if (navWidth > availableSpace) {
      var $lastItem = $visibleItems.not(':last-child').last();

      $lastItem.attr('data-width', $lastItem.outerWidth(true));
      $lastItem.prependTo($dropdown);

      handleBreadcrumbs();
    } else {
      var $firstMoreElement = $dropdown.find(itemSelector).first();

      if (navWidth + $firstMoreElement.data('width') < availableSpace) {
        $firstMoreElement.insertBefore($moreAction);
      }
    }

    if ($dropdown.find(itemSelector).length > 0) {
      $moreAction.removeClass(hiddenClass);
    } else {
      $moreAction.addClass(hiddenClass);
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
Breadcrumb.init();