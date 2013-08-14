class CampaignsController < ApplicationController

  def index
    case params[:order]
    when 'popularity'
      Campaign.find_in_batches(:include => :calls, :batch_size => 500) do |campaign_batch|
        @campaigns = campaign_batch.sort { |a,b| b.calls.count <=> a.calls.count }
      end
    when 'most_recent'
      @campaigns = Campaign.order('created_at').limit(9).reverse
    else
      @campaigns = Campaign.order('created_at').limit(9)
    end
    render :index
  end

  def show
    @campaign = Campaign.find(params[:id])
    @title = @campaign.target_name + ": " + @campaign.action
    @backbone = true
    if current_user
      if current_user.shared_links.where('campaign_id = ?', @campaign.id).any? 
        @short_code = current_user.shared_links.where(:campaign_id => @campaign.id).first.short_key  
      else
        share_link = Sharelink.new
        share_link.generate_short_code(@campaign, current_user)
        @short_code = share_link.short_key
      end
    end
    binding.pry    
    render :show
  end

  def key_redirect
    share_link = Sharelink.find_by_short_key!(params[:short_code])
    cookies.signed[:referrer_id] = {
       :value => share_link.referrer_id,
       :expires => 1.day.from_now,
    }
    redirect_to campaign_path(share_link.campaign)
  end

  def get_token
    # if we changed the Call model so that it had a slug instead of a Campaign.id in its table
    # we could avoid doing the Campaign.find here. Not sure if that's best practice through
    campaign_id = Campaign.find(params[:id]).id 
    call = Call.new
    call.campaign_id = campaign_id
    call.target_name = call.campaign.target_name
    call.twilio_token
    render :json => call
  end

  # this post request to campaigns#voice runs when people click "call" and 
  # the Twilio.Device.connect(params); runs in call_view.js
  def receive_browser_call
    campaign_id = params[:campaign_id].to_i
    Sharelink.add_clicker(campaign_id, session[:referrer_id], current_user) if session[:referrer_id]
    Call.create(:campaign_id => campaign_id, :user_id => params[:id], :twilio_id => params[:CallSid])
    outbound_call = Campaign.outbound_call_instructions(campaign_id)
    render :xml => outbound_call.text
  end

  def callback
    twilio_id = params[:CallSid]
    call = Call.where('twilio_id = ?', twilio_id).first
    call.get_recording_info(twilio_id, params[:CallDuration], params[:AnsweredBy])
    render :json => 'callback success'
  end


  def new
    @campaign = Campaign.new
    render :new
  end

  def create
    campaign = Campaign.new(params[:campaign])
    campaign.organizer_id = current_user.id
    campaign.title = campaign.target_name + " " + campaign.action
    campaign.save!
    redirect_to campaign_path(campaign)
  end

  def edit
    @campaign = Campaign.find(params[:id])
    render :edit
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update_attributes(params[:campaign])
      redirect_to @campaign, notice: 'Success! Your campaign is updated.'
    else
      render action: "edit", notice: 'Oops, your campaign was not able to be updated. Check for funny characters in your description and please try again'
    end
  end

end
