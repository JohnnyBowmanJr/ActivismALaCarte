app.views.CampaignsView = Backbone.View.extend({

  tagName: 'div',
  id: 'recordings-list',
  template: JST['templates/recordingsList'],
  events: {
  },

  render: function() {
    var html = this.template();
    this.$el.html(html);
    return this;
  }
});