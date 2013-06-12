class CallsController < ApplicationController

  # call from call.fetch() in router.js. This gives back Twilio token and db data 
  # (phone number, user_id, and campaign_id)
  def index
  
    call = Call.new 
    call.campaign_id = params[:campaign_id]
    if current_user  
      call.number = call.campaign.phone_number
      call.user_id = current_user.id
    end
    render :json => call
  end


end
