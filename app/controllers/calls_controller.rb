class CallsController < ApplicationController

  # call from call.fetch() in router.js. This gives back Twilio token and db data 
  # (phone number, user_id, and campaign_id)
  def index
    

    # call = Call.new 
    # call.campaign_id = params[:campaign_id]
    # if current_user  
    #   call.number = call.campaign.phone_number
    #   call.user_id = current_user.id
    # end
    # render :json => call
     
    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN

    #add new caller ID for Twilio to verify
 
    caller_id = @client.account.outgoing_caller_ids.create(
      :friendly_name => "Johnny",
      :phone_number => "+13108041305", 
      :status_callback => TWILIO_APP_URL + 'campaigns/' + params[:campaign_id] + '/calls/callback/',
      :status_callback_method => 'POST'
    )
    Call.create(:campaign_id => params[:campaign_id], :user_id => current_user.id, :twilio_id => caller_id.call_sid)
    render :json => {validation_code: caller_id.validation_code, phone_number: caller_id.phone_number}
    #render :json => {caller_id: {validation_code: "595792", phone_number: "+13108041305"}}
  end

  def callback
    binding.pry
    unless params[:verification_status] == nil
      Call.create(:campaign_id => params[:campaign_id], :user_id => current_user.id, :twilio_id => params[:CallSid])
      @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
      
      @call = @client.account.calls.create(
        :from => '+13108041305',   # From your Twilio number
        :to => '+15184748390',     # To any number
        # Fetch instructions from this URL when the call connects
        :url => 'http://3n4y.localtunnel.com/campaigns/voice/',
        :record => 'true',
        :status_callback => 'http://3n4y.localtunnel.com/campaigns/callback/',
        :status_callback_method => 'POST'
      ) 
    end
  end

end
