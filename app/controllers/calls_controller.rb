class CallsController < ApplicationController

  # call from call.fetch() in router.js. This gives back Twilio token and db data 
  # (phone number, user_id, and campaign_id)

  #twilio calls the user's phone to verify the phone
  def create
    if current_user
      user = User.find(current_user.id)
      user.phone_number = params[:phone_number]
      user.save

      Call.check_verified(current_user)

      @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN

      #add new caller ID for Twilio to verify
      binding.pry
      caller_id = @client.account.outgoing_caller_ids.create(
        :friendly_name => "Johnny",
        :phone_number => params[:phone_number], 
        :status_callback => TWILIO_APP_URL + 'campaigns/' + params[:campaign_id] + '/calls/inbound_call/',
        :status_callback_method => 'POST'
      )
    end
    
    render :json => {:caller_id => {:validation_code => caller_id.validation_code, :phone_number => caller_id.phone_number}}
  end

  def inbound_call
    campaign = Campaign.find(params[:campaign_id])
    phone_number = campaign.phone_number
    client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    inbound_call = client.account.calls.create(
      :from => "+13109075542",   # From your Twilio number
      :to => '+13108041305',     # To any number
      :url => TWILIO_APP_URL + 'campaigns/' + campaign.id.to_s + '/calls/voice/',
      :method => "POST",
      #:headers => {'X-CSRF-Token' => session["_csrf_token"]},
      :record => 'false',
      :status_callback => TWILIO_APP_URL + 'campaigns/callback/',
      :status_callback_method => "GET"
    )
    render :json => inbound_call.status
  end

  def voice
    outbound_call = Twilio::TwiML::Response.new do |r|
      # Should be your Twilio Number or a verified Caller ID
      #caller_id = '+13109075542'
      r.Say 'Please hold while we connect your call. This call may be recorded for quality assurance', :voice => 'woman'
      r.Dial :record => true do |d|
        d.Number '+13476221301'
      end
    end
    render :xml => outbound_call.text
  end

  def callback
    binding.pry
    twilio_id = params[:CallSid]
    
    Call.create(:campaign_id => params[:campaign_id], :user_id => current_user.id, :twilio_id => params[:CallSid])
    call = Call.where("twilio_id = ?", twilio_id).first
    call.get_recording_info(twilio_id, params[:CallDuration] )
    render :json => "callback success"
  end

end
