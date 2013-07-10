class CallsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  # call from call.fetch() in router.js. This gives back Twilio token and db data 
  # (phone number, user_id, and campaign_id)

  def create
    if current_user
      user = User.find(current_user.id)
      user.phone_number = params[:phone_number]
      user.save

      @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN

      #add new caller ID for Twilio to verify
   
      caller_id = @client.account.outgoing_caller_ids.create(
        :friendly_name => "Johnny",
        :phone_number => params[:phone_number], 
        :status_callback => TWILIO_APP_URL + 'campaigns/' + params[:campaign_id] + '/calls/callback/',
        :status_callback_method => 'POST'
      )
    end
    
    render :json => {:caller_id => {:validation_code => caller_id.validation_code, :phone_number => caller_id.phone_number}}
  end

  def callback
    binding.pry
    campaign = Campaign.find(params[:campaign_id])
    phone_number = campaign.phone_number
    binding.pry
    unless params[:VerificationStatus] == nil
      client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
      
      outbound_call = client.account.calls.create(
        :from => params[:Called],   # From your Twilio number
        :to => '+15184748390',     # To any number
        # Fetch instructions from this URL when the call connects
        :url => TWILIO_APP_URL + 'campaigns/' + params[:campaign_id] + '/calls/voice/',
        #:headers => {'X-CSRF-Token' => session["_csrf_token"]},
        :record => 'false',
        :status_callback => TWILIO_APP_URL + 'campaigns/callback/',
        :status_callback_method => 'POST'
      )
      render :json => "call success"
    end
  end

  def voice
    response = Campaign.create_twilio_response(params[:To])
    render :xml => response.text
  end

end
