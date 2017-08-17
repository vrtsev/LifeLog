//= require shared

$(document).on('turbolinks:load', function() {
  $('pre').each(function(i, block) {
    hljs.highlightBlock(block);
  });

  // Autohide search params block
  var filterBlockState = localStorage.getItem('filterBlockVisibility')
  var filterBlock      = $('#filter-block')
  var buttonIcon       = $('#hide-filter-icon')

  filterBlockVisibility();

  function changeFilterBlockIcon(icon_class) {
    buttonIcon.removeClass();
    buttonIcon.addClass(icon_class);
  }

  function filterBlockVisibility() {
    if (filterBlockState == 'hidden') {
      filterBlock.addClass('hidden');
      changeFilterBlockIcon('fa fa-chevron-down');
    } else if (filterBlockState == 'visible') {
      filterBlock.removeClass('hidden');
      changeFilterBlockIcon('fa fa-chevron-up');
    };
  };

  $('#hide-filter-btn').on('click', function(e) {
    e.preventDefault();
    $('#filter-block').slideToggle('fast');
    
    if (filterBlock.hasClass('hidden')) {
      changeFilterBlockIcon('fa fa-chevron-up');
      filterBlock.removeClass('hidden');
      localStorage.setItem('filterBlockVisibility', 'visible')
    } else { 
      changeFilterBlockIcon('fa fa-chevron-down');
      filterBlock.addClass('hidden');
      localStorage.setItem('filterBlockVisibility', 'hidden')
    }
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

    // New category form
    $('#new-category-btn').click(function(e) {
      // e.preventDefault();
      // $('#new-category-block').toggleClass('hidden');
    })

    

    // Search and filters
    var filtersBlockState    = localStorage.getItem('diaryFiltersBlock')
    var filtersBlock         = $('#filters-block')
    var filtersTriggerButton = $('#hide-post-filters-btn')

    function hideFiltersBlock() {
      filtersBlock.addClass('hidden')
      filtersTriggerButton.html('<i class="fa fa-chevron-down">')
      localStorage.setItem('diaryFiltersBlock', 'hidden')
    }

    function showFiltersBlock() {
      filtersBlock.removeClass('hidden')
      filtersTriggerButton.html('<i class="fa fa-chevron-up">')
      localStorage.removeItem('diaryFiltersBlock')
    }

    // Autohide filters block
    if (filtersBlockState == 'hidden') {
      hideFiltersBlock();
    } else {
      showFiltersBlock();
    };

    // click events
    filtersTriggerButton.on('click', function() {
      if (filtersBlock.is(':visible')) {
        hideFiltersBlock();
      } else {
        showFiltersBlock();
      }
    })
 });
