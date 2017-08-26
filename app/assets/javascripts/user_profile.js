// Standart
//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require turbolinks

// Third party
//= require ckeditor/init
//= require lib/highlight.pack

// Custom
//= require lib/pagination
//= require shared

// JS Code
//= require_self

$(document).on('turbolinks:load', function() {
  $('#change-photo-btn').on('click', function(e) {
    e.preventDefault();
    $('#photo-upload-field').fadeToggle();
  })
})