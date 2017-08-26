// Standart
//= require jquery
//= require jquery_ujs
//= require turbolinks

// Third party
//= require semantic-ui

// Custom
//= require shared

// JS Code
//= require_self

$(document).ready(function() {
  // fix menu when passed
  $('.masthead')
    .visibility({
      once: false,
      onBottomPassed: function() {
        $('.fixed.menu').transition('fade in');
      },
      onBottomPassedReverse: function() {
        $('.fixed.menu').transition('fade out');
      }
    });
});