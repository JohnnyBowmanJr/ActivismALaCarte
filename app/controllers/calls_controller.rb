class CallsController < ApplicationController

  # this is hit when user inputs a phone number and clicks call
  def create
    campaign_id = Campaign.find(params[:campaign_id]).id
    caller_phone = params[:phone_number]
    inbound_call = Call.make_inbound_call(caller_phone, campaign_id)
    Call.create(:campaign_id => campaign_id, :user_id => current_user.id, :twilio_id => inbound_call.sid)
    render :json => inbound_call.status
  end

  # this is hit from Call.make_inbound_call in order to generate XML instructions for Twilio
  def receive_inbound_call
    campaign_id = params[:campaign_id]
    outbound_call = Campaign.outbound_call_instructions(campaign_id)
    render :xml => outbound_call.text
  end

end
