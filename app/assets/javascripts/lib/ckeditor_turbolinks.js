var ready = function() {
  $('.ckeditor').each(function() {
    CKEDITOR.replace($(this).attr('id'))
  })
}

$(document).on('turbolinks:load', ready)