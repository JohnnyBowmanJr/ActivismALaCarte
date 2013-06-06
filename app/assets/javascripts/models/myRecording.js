app.models.MyRecording = Backbone.Model.extend({

  url: function(){
    return '/users/my_recording';
  },

  initialize: function() {
  }
});