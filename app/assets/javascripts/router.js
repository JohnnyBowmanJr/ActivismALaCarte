app.Router = Backbone.Router.extend({

  routes: {
    'campaigns/:id' : 'callShow',
    'my-campaigns' : 'myCampaigns'
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
    var myRecording = new app.models.MyRecording();
    myRecording.fetch({
      success: function(recording) {
        var view = new app.views.myRecordingsView({ model : myRecording });
        $('#recordings-panel').html(view.render().el);
      }
    });
  }
});