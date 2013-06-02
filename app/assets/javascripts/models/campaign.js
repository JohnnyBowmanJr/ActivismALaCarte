app.models.Campaign = Backbone.Model.extend({

  url: function(){
    return '/campaigns/' + this.id;
  },

  initialize: function() {
    this.calls = new app.collections.CallList();
  }
});