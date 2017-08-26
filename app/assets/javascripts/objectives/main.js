// Event Calendar
  function eventCalendar() {
    return $('#calendar').fullCalendar({ events: '/objectives/goals.json' });
  };

  function clearCalendar() {
    $('#calendar').fullCalendar('delete'); // In case delete doesn't work.
    $('#calendar').html('');
  };

  $(document).on('turbolinks:load', eventCalendar);
  $(document).on('turbolinks:before-cache', clearCalendar)



$(document).on('turbolinks:load', function() {

  // Sortable functionality
    sortable('.sortable', {
      placeholderClass: 'task-placeholder'
    });

    var set_positions = function(){
      $('.task-item').each(function(i){
          $(this).attr("data-position",i+1);
      });
    }

    set_positions();

    sortable('.sortable')[0].addEventListener('sortupdate', function(e) {
      var goalId = $('.sortable').data('goal-id')
      updated_order = []
      set_positions();

      $('.task-item').each(function(i){
          updated_order.push({ id: $(this).data("id"), position: i+1 });
      });

      $.ajax({
          type: "PUT",
          url: '/objectives/goals/' + goalId + '/tasks/sort',
          data: { order: updated_order }
      });
    });


  // Hide/Show goal block
  var goalVisibilityState = localStorage.getItem('goalContentVisibility')
  var goalContentBlock    = $('#goal-description')
  var buttonIcon          = $('#hide-btn-icon')

  goalContentVisibility();

  function changeGoalBlockIcon(icon_class) {
    buttonIcon.removeClass();
    buttonIcon.addClass(icon_class);
  }

  function goalContentVisibility() {
    if (goalVisibilityState == 'hidden') {
      goalContentBlock.addClass('hidden');
      changeGoalBlockIcon('fa fa-expand text-primary');

    } else if (goalVisibilityState == 'visible') {
      goalContentBlock.removeClass('hidden');
      changeGoalBlockIcon('fa fa-compress');
    };
  };

  $('#goal-hide-btn').on('click', function(e) {
    e.preventDefault();
    $('#goal-description').slideToggle('fast');
    
    if (goalContentBlock.hasClass('hidden')) {
      changeGoalBlockIcon('fa fa-compress');
      goalContentBlock.removeClass('hidden');
      localStorage.setItem('goalContentVisibility', 'visible')

    } else { 
      changeGoalBlockIcon('fa fa-expand text-primary');
      goalContentBlock.addClass('hidden');
      localStorage.setItem('goalContentVisibility', 'hidden')
    }
  });

  // Actions block
  // $('#new-action-area', '#new-action-box', '#action-cancel-btn').click(function(e) {
  //   e.preventDefault();
  //   $('#new-action-box').toggleClass('hidden');
  //   $('#new-action-form').toggleClass('hidden');
  //   $('.new-action-input').focus();
  // });

  // Tasks block
  setActiveTab();

  function setActiveTab() {
    var goalActionsTab  = $('#goal-actions-tab')
    var goalTasksTab    = $('#goal-tasks-tab')
    var storageTabState = localStorage.getItem('goalActiveTab')

    if (storageTabState == 'goal-actions-tab') {
      goalActionsTab.click();
    } else if (storageTabState == 'goal-tasks-tab') {
      goalTasksTab.click();
    };
  };

  $('.goal-content-tab').on('click', function() {
    localStorage.setItem('goalActiveTab', this.id)
  });


});