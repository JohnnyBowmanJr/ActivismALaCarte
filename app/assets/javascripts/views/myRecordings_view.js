app.views.CampaignsView = Backbone.View.extend({

  tagName: 'div',
  id: 'recordingButton',
  template: JST['templates/recording'],
  events: {
    'click .play-button' : 'playRecording'
  },

  render: function() {
    var html = this.template();
    this.$el.html(html);
      soundManager.setup({
        url: '/swf/',
        flashVersion: 9, // optional: shiny features (default = 8)
        // optional: ignore Flash where possible, use 100% HTML5 mode
        // preferFlash: false,
        onready: function() {
          soundManager.createSound({
          id: 'showRecording',
          url: 'http://api.twilio.com/2010-04-01/Accounts/AC3ecb799e792404580fe5e903b88d3929/Recordings/RE9e59cc8cef36ae5cf651a5582dac9306',
          autoLoad: true,
          autoPlay: false,
          onload: function() {
            alert('The sound recording loaded!');
          },
          whileplaying: function(){
          },
          volume: 50
          });
        }
      });
    return this;
  },

  playRecording: function() {
    soundManager.play('showRecording');
  }
});