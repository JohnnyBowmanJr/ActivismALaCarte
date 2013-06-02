app.Router = Backbone.Router.extend({

  routes: {
    '' : 'callShow'
  },

  callShow: function(campaign_id) {
    var call = new app.models.Call({id: campaign_id});
    call.fetch({
      success: function(call) {
        var view = new app.views.CampaignView({ model : call });
        $('#call-campaign-show').html(view.render().el);
      }
    });
  }
});