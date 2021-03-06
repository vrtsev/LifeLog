$(document).on('turbolinks:load', function() {
  var postsBlock      = $('#posts')
  var commentsBlock   = $('#comments')
  var paginationBlock = $('.pagination')

  if (postsBlock.length && paginationBlock) {
    $(window).scroll(function() {
      var url = $('.pagination a.next_page').attr('href');
      var paginationSection = $(window).scrollTop() > $(document).height() - $(window).height() - 50

      if (url && paginationSection) {
        paginationBlock.html('<div class="loader"></div>');
        return $.getScript(url);
      };
    });
    return $(window).scroll();
  };

  if (commentsBlock.length && paginationBlock) {
    $(window).scroll(function() {
      var url = $('.pagination a.next_page').attr('href');
      var paginationSection = $(window).scrollTop() > $(document).height() - $(window).height() - 50

      if (url && paginationSection) {
        paginationBlock.html('<div class="loader"></div>');
        return $.getScript(url);
      };
    });
    return $(window).scroll();
  };
});
