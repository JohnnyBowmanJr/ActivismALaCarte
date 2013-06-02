app.collections.CallList = Backbone.Collection.extend({

  model: app.models.Call,
  url: "/calls/"

});