app.views.CallView = Backbone.View.extend({

  tagName: 'div',
  id: 'call-box',
  template: JST['templates/call'],
  events: {
    'click a#phone-instead' : 'showPhone',
    'click button.hangup' : 'hangup',
    'click button#call' : 'call'
  },

  render: function() {
    var html = this.template({target_name: this.model.target_name});
    this.$el.html(html);
     /* Create the Client with a Capability Token */
    Twilio.Device.setup(this.model.token, {debug: true});
    /* Let us know when the client is ready. */
    Twilio.Device.ready(function (device) {
        $("#log").html("<p>Press the 'Call' button above to start your phone call</p>");
    });
    /* Report any errors on the screen */
    Twilio.Device.error(function (error) {
        $("#log").html("<p>'Error: '' + error.message</p>");
    });
    Twilio.Device.connect(function (conn) {
        $("#log").html("<p>Successfully established call</p>");
    });
     /* Log a message when a call disconnects. */
    Twilio.Device.disconnect(function (conn) {
        $("#log").html("<p>Call ended</p>");

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
  showPhone: function(){
    $('input#phone-field').toggle();
    if($('input#phone-field').css("display") == "none"){
      $("#log").html("<p>Press the 'Call' button above to start your phone call</p>");
    }else{
      $("#log").html("<p>Type your phone number above and hit the call button. We'll connect you!</p>");
    }
  },

  call: function() {
    // create if statement here in case user_id doesn't exist (user hasn't logged in yet).
    // GET call data from /campaigns/:id/calls, including user_id, campaign_id and campaign_phone number
    //this should be getting the campaign id through jquery grabbing a data attribute in the dom
    var userNumber = $('input#phone-field').val();
    var campaign_id = window.location.pathname.split('/').pop();
    var call = new app.models.Call({
      campaign_id: campaign_id,
      phone_number: userNumber
    });


    //on clicking submit, check to see if call is through Twilio connect or REST API
    //then either do call.save or call.fetch (or something else)
    call.save({},{
      success: function(caller_id) {
        var view = new app.views.ValidationView({
          validation_code: caller_id.attributes.validation_code,
          phone_number: caller_id.attributes.phone_number
        });

        $('#validation').html(view.render().el);
        $('#validation').foundation('reveal', 'open');
      }
    });
  },

  /* A function to end a connection to Twilio. */
  hangup: function() {
    Twilio.Device.disconnectAll();
    $('button.hangup').toggle();
    $('button.call').toggle();
    var view = new app.views.NextStepsView();
    $('#next-steps').html(view.render().el);
    $('#next-steps').foundation('reveal', 'open');
  }
});