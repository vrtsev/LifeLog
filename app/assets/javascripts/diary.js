//= require shared

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

  // Categories
    var categoryListState = localStorage.getItem('diaryCategoriesList')
    var categoryList      = $('#categories-list')
    var triggerButton     = $('#hide-categories-btn')

    function hideCategoryList() {
      categoryList.addClass('hidden')
      triggerButton.html('<i class="fa fa-chevron-down">')
      localStorage.setItem('diaryCategoriesList', 'hidden')
    }

    function showCategoryList() {
      categoryList.removeClass('hidden')
      triggerButton.html('<i class="fa fa-chevron-up">')
      localStorage.removeItem('diaryCategoriesList')
    }

    // Autohide menu
    if (categoryListState == 'hidden') {
      hideCategoryList();
    } else {
      showCategoryList();
    };

    // click events
    triggerButton.on('click', function() {
      if (categoryList.is(':visible')) {
        hideCategoryList();
      } else {
        showCategoryList();
      }
    })

    // hover
    $('.category-item').hover(function() {
      $(this).find('div.box-tool').toggleClass('hidden');
    })
 });
