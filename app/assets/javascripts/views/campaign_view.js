app.views.CampaignView = Backbone.View.extend({

  tagName: 'div',
  id: 'call-box',
  template: JST['templates/call'],
  events: {
  },

  render: function() {
    var html = this.template();
    this.$el.html(html);
    return this;
  }
});