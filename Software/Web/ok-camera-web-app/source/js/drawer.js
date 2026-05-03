/**
 * Drawer
 */
const Drawer = (($) => {
  const drawer = '.drawer';
  const toggleAction = '[data-toggle="drawer"]';
  const closeAction = '[data-dismiss="drawer"]';
  const visibilityClass = 'show';

  /**
   * Init
   */
  const init = () => {
    $(document).on('click', toggleAction, toggle);
    $(document).on('click', closeAction, close);
  }

  /**
   * Toggle (show/hide)
   * @param {object} e
   */
  const toggle = (e) => {
    e.preventDefault();

    $($(e.target).attr('href')).toggleClass(visibilityClass);
  }

  /**
   * Close/Hide
   * @param {object} e
   */
  const close = (e) => {
    e.preventDefault();

    $(e.target).closest(drawer).removeClass(visibilityClass);
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
Drawer.init();
