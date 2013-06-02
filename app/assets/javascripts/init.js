$(document).ready(function() {

  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });

  //what's going on here?
  var router = new app.Router();
  Backbone.history.start({pushState: false});
  router.navigate('');
});