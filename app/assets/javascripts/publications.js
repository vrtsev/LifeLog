//= require shared

$(document).on('turbolinks:load', function() {
  $('pre').each(function(i, block) {
    hljs.highlightBlock(block);
  });

  $('#filter-btn').click(function(e) {
    e.preventDefault();
    $('#filter-block').toggleClass('hidden')
  });
});
