app.Router = Backbone.Router.extend({

  routes: {
    'campaigns/:id' : 'callShow',
    'mycampaigns' : 'myCampaigns'
  },

  callShow: function(campaign_id) {
    var callInfo = new app.models.Campaign({ campaign_id : campaign_id});
    callInfo.url = '/campaigns/' + campaign_id + '/get_call_info';
    callInfo.fetch({
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