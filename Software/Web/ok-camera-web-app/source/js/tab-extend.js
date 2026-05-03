/**
 * Bootstrap tabs update
 */
const Tabs = (($) => {
  const $tabs = $('[data-toggle="tab"]');
  const $tabSelector = $('.js-tab-selector');
  const hashPrefix = 'tab-';
  const targetData = 'target';

  /**
   * Init
   */
  const init = () => {
    selectTabFromUrlHash();

    $tabs.on('shown.bs.tab', updateUrlAndSelector);

    $tabSelector.on('change', selectTabFromSelector);
  }

  /**
   * Update URL and selector (select element) on tab change
   * @param {object} e
   */
  const updateUrlAndSelector = (e) => {
    e.preventDefault();

    let hash = e.target.hash.substr(1);

    hash = (hash === '') ? $(e.target).data(targetData).substr(1) : hash;

    window.location.hash = hashPrefix +  hash;

    updateSelectorOption('#' + hash);
  }

  /**
   * Select tab from the URL hash
   */
  const selectTabFromUrlHash = () => {
    const locationHash = location.hash;

    if (locationHash === '') {
      return;
    }

    const hash = locationHash.replace(hashPrefix, '');
    let $tab = $tabs.filter('[href="' + hash + '"]');

    // If someone uses data-target instead of href for id
    if ($tab.length === 0) {
      $tab = $tabs.filter('[data-target="' + hash + '"]');
    }

    $tab.tab('show');

    updateSelectorOption(hash);
  }

  /**
   * Select tab when selected option in tab selector (select element)
   * @parem {object} e
   */
  const selectTabFromSelector = (e) => {
    const id = e.target.value;
    let $tab = $('a[href="' + id + '"]');

    // If someone uses data-target instead of href for id
    if ($tab.length === 0) {
      $tab = $('[data-target="' + id + '"]');
    }

    $tab.tab('show');
  }

  /**
   * Update option in the tab selector (select element)
   * @parem {string} hash
   */
  const updateSelectorOption = (hash) => {
    if ($tabSelector.length === 0) {
      return;
    }

    $tabSelector.find('option[value="' + hash + '"]').prop('selected', true);
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

Tabs.init();
