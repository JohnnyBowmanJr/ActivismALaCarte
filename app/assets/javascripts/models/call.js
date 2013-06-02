app.models.Call = Backbone.Model.extend({

  url: function(){
    return '/campaigns/' + this.id + '/calls/new';
  },

  initialize: function() {
  }
});