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
    //var userId = $('#recordings-panel').attr('data-user');
    //get user_id from DOM?
    myRecordingsList.fetch({
      success: function(campaigns) {
        // how should I append a soundmanager player to each recording?
        // will the soundmanager player play a Twilio URL?
        campaigns.forEach(function(campaign){
          var view = new app.views.CampaignChartView({ model : campaign });
          //$('#call-chart-' + String(campaign.attributes.id)).html(view.render().el);
          view.render();
        });
      }
    });
  }
});