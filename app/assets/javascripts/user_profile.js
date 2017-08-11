//= require shared

$(document).on('turbolinks:load', function() {
  $('#change-photo-btn').on('click', function(e) {
    e.preventDefault();
    $('#photo-upload-field').fadeToggle();
  })
})