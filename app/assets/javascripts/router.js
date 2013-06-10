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
        var view = new app.views.CallView({ token : call.attributes.token });
        $('#call-campaign-show').html(view.render().el);
      }
    });
  },

  myCampaigns: function() {
    var myRecordingsList = new app.collections.MyRecordingsList();
    var userId = $('#recordings-panel').attr('data-user');
    //get user_id from DOM?
    myRecordingsList.fetch({
      success: function(recording) {
        // how should I append a soundmanager player to each recording?
        // will the soundmanager player play a Twilio URL?
        var view = new app.views.myRecordingsView({ model : myRecording });
        $('#recordings-panel').html(view.render().el);
      }
    });
  }
});