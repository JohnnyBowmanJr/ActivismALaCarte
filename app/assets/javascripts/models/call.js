app.models.Call = Backbone.Model.extend({

  url: function(){
    var url = '/campaigns/' + this.attributes.campaign_id + '/calls';
    if(!this.isNew()) {
      url += '/' + this.id;
    }
    // else{
    //   url += '/create'
    // }
    return url;
  },

  initialize: function() {
  }
});