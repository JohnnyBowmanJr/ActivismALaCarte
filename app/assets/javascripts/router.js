app.Router = Backbone.Router.extend({

  routes: {
    '' : 'callShow'
  },

  callShow: function() {
    var campaign_id =[];
    var campaign_id = window.location.pathname.split('/').pop();
    var call = new app.models.Call({id: campaign_id});
    call.fetch({
      success: function(call) {
        var view = new app.views.CallView({ model : call });
        $('#call-campaign-show').html(view.render().el);
      }
    });
  }
});