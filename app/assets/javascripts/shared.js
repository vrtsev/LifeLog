$(document).on('turbolinks:load', function() {
  // Comment form
  $('.comment-action-btn').on('click', function(e) {
    e.preventDefault();
    $('#new-comment-box').toggleClass('hidden');
    $('#new-comment-form').toggleClass('hidden');
    $('.new-comment-input').focus();
  });

  var messageBox = $('.flash-message-box')
  if (messageBox.length == 1) {
    setTimeout(function() {
      messageBox.fadeOut('fast');
    }, 5000);
  }
})
