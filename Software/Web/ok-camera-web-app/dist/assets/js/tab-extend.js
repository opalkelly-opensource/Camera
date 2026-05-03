'use strict';

/**
 * Bootstrap tabs update
 */
var Tabs = function ($) {
  var $tabs = $('[data-toggle="tab"]');
  var $tabSelector = $('.js-tab-selector');
  var hashPrefix = 'tab-';
  var targetData = 'target';

  /**
   * Init
   */
  var init = function init() {
    selectTabFromUrlHash();

    $tabs.on('shown.bs.tab', updateUrlAndSelector);

    $tabSelector.on('change', selectTabFromSelector);
  };

  /**
   * Update URL and selector (select element) on tab change
   * @param {object} e
   */
  var updateUrlAndSelector = function updateUrlAndSelector(e) {
    e.preventDefault();

    var hash = e.target.hash.substr(1);

    hash = hash === '' ? $(e.target).data(targetData).substr(1) : hash;

    window.location.hash = hashPrefix + hash;

    updateSelectorOption('#' + hash);
  };

  /**
   * Select tab from the URL hash
   */
  var selectTabFromUrlHash = function selectTabFromUrlHash() {
    var locationHash = location.hash;

    if (locationHash === '') {
      return;
    }

    var hash = locationHash.replace(hashPrefix, '');
    var $tab = $tabs.filter('[href="' + hash + '"]');

    // If someone uses data-target instead of href for id
    if ($tab.length === 0) {
      $tab = $tabs.filter('[data-target="' + hash + '"]');
    }

    $tab.tab('show');

    updateSelectorOption(hash);
  };

  /**
   * Select tab when selected option in tab selector (select element)
   * @parem {object} e
   */
  var selectTabFromSelector = function selectTabFromSelector(e) {
    var id = e.target.value;
    var $tab = $('a[href="' + id + '"]');

    // If someone uses data-target instead of href for id
    if ($tab.length === 0) {
      $tab = $('[data-target="' + id + '"]');
    }

    $tab.tab('show');
  };

  /**
   * Update option in the tab selector (select element)
   * @parem {string} hash
   */
  var updateSelectorOption = function updateSelectorOption(hash) {
    if ($tabSelector.length === 0) {
      return;
    }

    $tabSelector.find('option[value="' + hash + '"]').prop('selected', true);
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

Tabs.init();