/**
 * Responsive breadcrumbs
 */
const Breadcrumb = (($) => {
  const $breadcrumbs = $('.js-breadcrumbs');
  const $moreAction = $breadcrumbs.find('.breadcrumb-more');
  const $dropdown = $moreAction.find('.dropdown-menu');
  const itemSelector = '.breadcrumb-item';
  const visibleItemsSelector = '> .breadcrumb-item:not(.breadcrumb-more)';
  const hiddenClass = 'hidden';
  const debounceDelay = 250;

  /**
   * Init
   */
  const init = () => {
    handleBreadcrumbs();

    $(window).on('resize', $.debounce(debounceDelay, handleBreadcrumbs));
  }

  /**
   * Handle responsiveness
   */
  const handleBreadcrumbs = () => {
    let navWidth = 0;
    const moreWidth = $moreAction.outerWidth(true);
    const $visibleItems = $breadcrumbs.find(visibleItemsSelector);
    const availableSpace = $breadcrumbs.parent().width() - moreWidth;

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
  }

  /**
   * Return
   * @return {function}
   */
  return {
    init
  }
})(jQuery)

/**
 * Initialize on load
 */
Breadcrumb.init();
