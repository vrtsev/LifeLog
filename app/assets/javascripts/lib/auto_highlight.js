$(document).on('turbolinks:load', function() {
  $('pre').each(function(i, block) {
    hljs.highlightBlock(block);
  });
});