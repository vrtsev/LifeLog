//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require semantic-ui
//= require ckeditor/init

$(document).ready(function() {
  $('.ckeditor').each(function() {
    CKEDITOR.replace $(this).attr('id')
  })
})

$(document).on('page:load', function() {
  $('.ckeditor').each(function() {
    CKEDITOR.replace $(this).attr('id')
  })
})


$(document).on('turbolinks:load', function() {
  $('pre').each(function(i, block) {
    hljs.highlightBlock(block);
  });

  // Post form actions
  $('input.checkbox').each(function() {
    if ($(this).prop('checked')) {
      $('li#' + this.id).addClass('active-btn');
    };
  });
  
  $('ul.form-buttons li.checkbox').on('click', function(e) {
    e.preventDefault();
    var checkbox = $('input#' + this.id)
    
    checkbox.click();
    $(this).toggleClass('active-btn');
  });

  $('ul.form-buttons li.field-block').on('click', function(e) {
    e.preventDefault();
    var obj = $('div#'+ this.id)

    $(obj).toggle();
    $(this).toggleClass('active-btn');
  });
});
