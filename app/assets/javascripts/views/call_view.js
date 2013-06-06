app.views.CallView = Backbone.View.extend({

  tagName: 'div',
  id: 'call-box',
  template: JST['templates/call'],
  events: {
    'click button.hangup' : 'hangup',
    'click button.call' : 'call'
  },

  render: function() {
    var html = this.template({call : this.model});
    this.$el.html(html);
     /* Create the Client with a Capability Token */
    Twilio.Device.setup(this.model.attributes.token, {debug: true});
    /* Let us know when the client is ready. */
    Twilio.Device.ready(function (device) {
        $("#log").text("Ready");
    });
    /* Report any errors on the screen */
    Twilio.Device.error(function (error) {
        $("#log").text("Error: " + error.message);
    });
    Twilio.Device.connect(function (conn) {
        $("#log").text("Successfully established call");
    });
     /* Log a message when a call disconnects. */
    Twilio.Device.disconnect(function (conn) {
        $("#log").text("Call ended");
    });
   /* Listen for incoming connections */
    Twilio.Device.incoming(function (conn) {
      $("#log").text("Incoming connection from " + conn.parameters.From);
      // accept the incoming connection and start two-way audio
      conn.accept();
    });
    return this;
  },

  /* Connect to Twilio when we call this function. */
  call: function() {
    // get the phone number to connect the call to
    this.model.save();
    params = {"PhoneNumber": $("#number").val(), "campaign_id": this.model.attributes.campaign_id};
    Twilio.Device.connect(params);

  },

  /* A function to end a connection to Twilio. */
  hangup: function() {
    Twilio.Device.disconnectAll();
    //find call sid for call that just happened
    //search for recording by call sid
    //save recording to database
  }
});