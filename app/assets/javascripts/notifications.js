$(document).ready( function() {
  $('.close-notification').on('click', function() {
    collapsible.hide($(this).parents('.collapse'));
  });
  $('#show-error-msg').on('show-error', function() {
    collapsible.show($('#error-alert'));
  });
});
