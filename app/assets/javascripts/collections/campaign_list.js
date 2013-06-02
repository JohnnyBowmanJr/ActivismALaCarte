app.collections.CampaignList = Backbone.Collection.extend({

  model: app.models.Campaign,
  url: "/campaigns/"

});