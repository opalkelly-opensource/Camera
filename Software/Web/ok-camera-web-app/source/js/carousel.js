/**
 * Initialize carousels (Slick.js)
 */
const Carousel = (($) => {
  const $carousel = $('.js-carousel');
  const options = {
    dots: true,
    infinite: false
  };

  /**
   * Init
   */
  const init = () => {
    $carousel.slick(options);
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
Carousel.init();
