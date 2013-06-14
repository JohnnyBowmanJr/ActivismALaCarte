app.views.NextStepsView = Backbone.View.extend({

  tagName: 'div',
  id: 'hello',
  template: JST['templates/next_steps'],
  events: {
    'click #fb-share' : 'share'
  },

  render: function() {
    var fbPrefix = "https://www.facebook.com/sharer/sharer.php?u=";
    var share_url = fbPrefix + String(location.href);
    var html = this.template({
      currentURL: share_url
    });
    this.$el.html(html);
    return this;
  },

  share: function(){
    var fbPrefix = "https://www.facebook.com/sharer/sharer.php?u=";
    var shareUrl = fbPrefix + String(location.href);
    window.open(shareUrl, 'sharer', 'width=626,height=436');
  }
});