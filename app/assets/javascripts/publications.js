//= require shared

$(document).on('turbolinks:load', function() {
  $('#filter-btn').click(function(e) {
    e.preventDefault();
    $('#filter-block').toggleClass('hidden')
  });
});
