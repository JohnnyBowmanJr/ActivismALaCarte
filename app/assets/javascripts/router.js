app.Router = Backbone.Router.extend({

  routes: {
    'campaigns/:id' : 'callShow',
    'mycampaigns' : 'myCampaigns'
  },

  callShow: function() {
    var campaign_id = [];
    //this should be getting the campaign id through jquery grabbing a data attribute in the dom
    var campaign_id = window.location.pathname.split('/').pop();
    var call = new app.models.Call({campaign_id: campaign_id});
    
    // GET call data from /campaigns/:id/calls
    call.fetch({
      success: function(call) {
        var view = new app.views.CallView({ model : call });
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