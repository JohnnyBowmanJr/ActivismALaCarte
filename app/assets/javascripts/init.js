$(document).ready(function() {

  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });

  var router = new app.Router();
  Backbone.history.start({pushState: true});
});