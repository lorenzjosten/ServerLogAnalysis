var collapsible = {
  hide : function(div) {
    $(div).collapse('hide');
  },
  show : function(div) {
    $(div).collapse('show');
  }
};

$(document).ready( function() {
  $('.form').submit( function() {
    collapsible.hide($('.show_plot'));
  });
});
