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
  $('#goal-hide-btn').on('click', function(e) {
    var buttonIcon = $('#hide-btn-icon')
    var iconUp     = buttonIcon.hasClass('fa-chevron-up')
    var iconDown   = buttonIcon.hasClass('fa-chevron-down')

    e.preventDefault();
    $('#goal-description').slideToggle('fast');
    
    if (iconUp) {
      buttonIcon.removeClass();
      buttonIcon.addClass('fa fa-chevron-down text-primary');
    } else if (iconDown) { 
      buttonIcon.removeClass();
      buttonIcon.addClass('fa fa-chevron-up');
    }
  });
});