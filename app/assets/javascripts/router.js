app.Router = Backbone.Router.extend({

  routes: {
    'campaigns/:id' : 'callShow',
    'mycampaigns' : 'myCampaigns'
  },

  callShow: function(campaign_id) {
    var token = new app.models.Campaign({ campaign_id : campaign_id});
    token.url = '/campaigns/' + campaign_id + '/get_token';
    token.fetch({
      success: function(call) {
        var view = new app.views.CallView({ model : call.attributes });
        $('#call-campaign-show').html(view.render().el);
      }
    });
  },

  myCampaigns: function() {
    $('body').addClass("white-background");
    var myRecordingsList = new app.collections.MyRecordingsList();
    myRecordingsList.fetch({
      success: function(campaigns) {
        campaigns.forEach(function(campaign){
          var view = new app.views.CampaignChartView({ model : campaign });
          view.render();
        });
      }
    });
  }
});