class CallsController < ApplicationController

  #skip_before_action :verify_authenticity_token, except: [:callback]
  # call from call.fetch() in router.js. This gives back Twilio token and db data 
  # (phone number, user_id, and campaign_id)

  #twilio calls the user's phone to verify the phone

  def create
    campaign_id = Campaign.find(params[:campaign_id]).id
    caller_phone = params[:phone_number]
    inbound_call = Call.make_inbound_call(caller_phone, campaign_id)
    Call.create(:campaign_id => campaign_id, :user_id => current_user.id, :twilio_id => inbound_call.sid)
    render :json => inbound_call.status
  end

  def receive_inbound_call
    #Should I save call here or in the callback? Depends on whether current_user is available on #callback
    #Call.create(:campaign_id => params[:campaign_id], :user_id => params[:user_id], :twilio_id => params[:CallSid])
    campaign_id = params[:campaign_id]
    outbound_call = Campaign.outbound_call_instructions(campaign_id)
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
