'use strict';

/**
 * Custom site JS
 */
$(document).ready(function () {

   // Toggle visibility of buffer depth

   $('[data-toggle="buffer-depth"]').change(function () {
      $('#buffer-depth').slideToggle('fast');
   });

   // Toggle visibility of controls

   $('[data-toggle="controls"]').on('click', function () {
      $('#controls').toggleClass('in');
      return false;
   });

   // Toggle log

   $('[data-toggle="log"]').on('click', function () {
      $('#log').toggleClass('log-expanded');
      return false;
   });

   // Toggle log on session pages

   $('[data-toggle="log-switch"]').on('click', function () {
      $('#log').toggleClass('log-switch-expanded');
      $(this).toggleClass('log-switch-active');
      return false;
   });
});