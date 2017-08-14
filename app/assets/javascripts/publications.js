//= require shared

$(document).on('turbolinks:load', function() {
  // $('#filter-btn').click(function(e) {
  //   e.preventDefault();
  //   $('#filter-block').toggleClass('hidden')
  // });

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
});

