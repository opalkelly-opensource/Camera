/**
 * Open external links in new window
 * Originally from https://css-tricks.com/snippets/jquery/open-external-links-in-new-window/
 */
const Anchor = (($) => {
  const selector = 'a';

  /**
   * Init
   */
  const init = () => {
    $(document).on('click', selector, handleClick);
  }

  /**
   * Handle click
   * @param {object} e
   */
  const handleClick = (e) => {
    const $target = $(e.target);
    const $anchor = $target.is('a') ? $target : $target.closest('a');
    const href = $anchor.prop('href');
    const a = new RegExp('/' + window.location.host + '/');

    if ($anchor.is('a[href*="mailto"]')) {
      return;
    }

    if (!a.test(href)) {
      e.preventDefault();
      window.open(href, '_blank');
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
Anchor.init();
