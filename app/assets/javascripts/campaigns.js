// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  $("#campaign_start_date").datepicker();
  $("#campaign_end_date").datepicker();

  $('body').on("click", "button.call", function() {
    $.ajax({
      url: "/campaigns/:id/calls/new",
      type: "POST",
      data: {results : results}
    });
  });
});