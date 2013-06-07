class CallsController < ApplicationController

  # call from call.fetch() in router.js. This gives back Twilio token and db data 
  # (phone number, user_id, and campaign_id)
  def index
    call = Call.new 
    call.campaign_id = params[:campaign_id]
    call.number = call.campaign.phone_number
    call.user_id = current_user.id
    default_client = "johnny"
    # Find these values at twilio.com/user/account
    account_sid = 'AC3ecb799e792404580fe5e903b88d3929'
    auth_token = 'd5ee548232ded22642dfe296d46df3af'
  
    capability = Twilio::Util::Capability.new account_sid, auth_token
    # Create an application sid at twilio.com/user/account/apps and use it here
    capability.allow_client_outgoing "APc47ff3822652f09502959b08335d24a7"
    capability.allow_client_incoming default_client
    token = capability.generate
    call.token = token
    render :json => call
  end


end
