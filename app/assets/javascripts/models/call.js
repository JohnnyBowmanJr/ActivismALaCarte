app.models.Call = Backbone.Model.extend({

  url: function(){
    var url = '/campaigns/' + this.attributes.campaign_id + '/calls';
    if(!this.isNew()) {
      url += '/' + this.id;
    }
    return url;
  },

  parse: function(response){
    return response.caller_id;
  }
});