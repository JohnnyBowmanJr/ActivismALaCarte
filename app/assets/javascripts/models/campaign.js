app.models.Campaign = Backbone.Model.extend({

  url: function(){
    return '/campaigns/' + this.attributes.campaign_id + '/get_info';
  },

  initialize: function() {
    this.calls = new app.collections.CallList();
    this.calls.url = '/campaigns/' + this.attributes.campaign_id + '/calls';
    this.calls.on("reset", this.updateCounts);
  }
});