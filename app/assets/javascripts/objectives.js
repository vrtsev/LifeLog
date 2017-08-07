//= require shared
//= require moment 
//= require fullcalendar

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
      changeGoalBlockIcon('fa fa-chevron-down text-primary');

    } else if (goalVisibilityState == 'visible') {
      goalContentBlock.removeClass('hidden');
      changeGoalBlockIcon('fa fa-chevron-up');
    };
  };

  $('#goal-hide-btn').on('click', function(e) {
    e.preventDefault();
    $('#goal-description').slideToggle('fast');
    
    if (goalContentBlock.hasClass('hidden')) {
      changeGoalBlockIcon('fa fa-chevron-up');
      goalContentBlock.removeClass('hidden');
      localStorage.setItem('goalContentVisibility', 'visible')

    } else { 
      changeGoalBlockIcon('fa fa-chevron-down text-primary');
      goalContentBlock.addClass('hidden');
      localStorage.setItem('goalContentVisibility', 'hidden')
    }
  });

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