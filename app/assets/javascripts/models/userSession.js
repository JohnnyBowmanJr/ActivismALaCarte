app.models.UserSession = Backbone.Model.extend({

  url: function(){
    return '/users/is_logged_in';
  },

  initialize: function() {
  }
});