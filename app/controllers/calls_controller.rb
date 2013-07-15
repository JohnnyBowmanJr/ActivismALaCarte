class CallsController < ApplicationController

  #skip_before_action :verify_authenticity_token, except: [:callback]
  # call from call.fetch() in router.js. This gives back Twilio token and db data 
  # (phone number, user_id, and campaign_id)

  #twilio calls the user's phone to verify the phone

  def create
    user = User.find(current_user.id)
    campaign = Campaign.find(params[:campaign_id])
    phone_number = campaign.phone_number
    client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    inbound_call = client.account.calls.create(
      :from => "+13109075542",   # From your Twilio number
      :to => params[:phone_number],     # To any number
      :url => TWILIO_APP_URL + 'campaigns/' + campaign.id.to_s + '/calls/voice/',
      :method => "POST",
      :headers => {'X-CSRF-Token' => session["_csrf_token"]},
      :record => 'false',
      :status_callback => TWILIO_APP_URL + 'campaigns/' + campaign.id.to_s + '/calls/callback/',
      :status_callback_method => "POST"
    )
    render :json => inbound_call.status
  end

  def voice
    #find the campaign with params[campaign_id], grab its phone number, and make that the d.Number
    #mess around with caller_id to see if we can make it the user's phone number
    outbound_call = Twilio::TwiML::Response.new do |r|
      # Should be your Twilio Number or a verified Caller ID
      #caller_id = '+13109075542'
      r.Say 'Please hold while we connect your call. This call may be recorded for quality assurance', :voice => 'woman'
      r.Dial :record => false do |d|
        d.Number '+16467732534'
      end
    end
    render :xml => outbound_call.text
  end

  def callback
    user = User.find(current_user.id)
    binding.pry

    twilio_id = params[:CallSid]
    
    Call.create(:campaign_id => params[:campaign_id], :user_id => current_user.id, :twilio_id => params[:CallSid])
    call = Call.where("twilio_id = ?", twilio_id).first
    call.get_recording_info(twilio_id, params[:Duration] )
    render :json => "callback success"
  end

end
