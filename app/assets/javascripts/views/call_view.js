app.views.CallView = Backbone.View.extend({

  tagName: 'div',
  id: 'call-box',
  template: JST['templates/call'],
  events: {
    'click button.hangup' : 'hangup',
    'click button.call' : 'call'
  },

  render: function() {
    var html = this.template({target_name: this.model.target_name});
    this.$el.html(html);
     /* Create the Client with a Capability Token */
    Twilio.Device.setup(this.model.token, {debug: true});
    /* Let us know when the client is ready. */
    Twilio.Device.ready(function (device) {
        $("#log").text("Press the 'Call' button above to start your phone call");
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
    // create if statement here in case user_id doesn't exist (user hasn't logged in yet).
    // GET call data from /campaigns/:id/calls, including user_id, campaign_id and campaign_phone number
    //this should be getting the campaign id through jquery grabbing a data attribute in the dom
    var campaign_id = window.location.pathname.split('/').pop();
    var call = new app.models.Call({campaign_id: campaign_id});

    call.fetch({
      success: function(call) {
        // append phone number to 
        // get the phone number to connect the call to
        if(call.attributes.user_id === null) {
          $('#sign-in-modal').foundation('reveal', 'open');
        }else{
          params = {"PhoneNumber": call.attributes.number, "campaign_id": call.attributes.campaign_id, "user_id": call.attributes.user_id  };
          Twilio.Device.connect(params);
          $('button.call').toggle();
          $('button.hangup').toggle();
        }
      }
    });
  },

  /* A function to end a connection to Twilio. */
  hangup: function() {
    Twilio.Device.disconnectAll();
    //find call sid for call that just happened
    //search for recording by call sid
    //save recording to database
  }
});