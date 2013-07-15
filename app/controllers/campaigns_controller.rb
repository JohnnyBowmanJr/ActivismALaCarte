class CampaignsController < ApplicationController

  def index
    case params[:order]
    when "popularity"
      @campaigns = Campaign.find(:all, :include => 'calls')
      @campaigns = @campaigns.sort { |a,b| b.calls.count <=> a.calls.count }

    when "most_recent"
      @campaigns = Campaign.find(:all, :order => :created_at, :limit => 9).reverse
    else
      @campaigns = Campaign.find(:all, :order => :created_at, :limit => 9)
    end
    render :index
  end

  def show
    @campaign = Campaign.find(params[:id])
    @title = @campaign.target_name + ": " + @campaign.action
    @backbone = true
    render :show
  end

  def get_token
    call = Call.new
    call.twilio_token(params[:id])
    render :json => call
  end

  # this post request to campaigns#voice runs when people click "call" and 
  # the Twilio.Device.connect(params); runs in call_view.js
  def voice
    #Should I save call here or in the callback? Depends on whether current_user is available on #callback
    #Call.create(:campaign_id => params[:campaign_id], :user_id => params[:user_id], :twilio_id => params[:CallSid])
    campaign_id = params[:campaign_id]
    outbound_call = Campaign.outbound_call_instructions(campaign_id)
    render :xml => outbound_call.text
  end

  def callback
    binding.pry
    twilio_id = params[:CallSid]
    call = Call.where("twilio_id = ?", twilio_id).first
    call.get_recording_info(twilio_id, params[:CallDuration])
    render :json => "callback success"
  end


  def new
    @campaign = Campaign.new
    render :new
  end

  def create
    campaign = Campaign.new(params[:campaign])
    campaign.organizer_id = current_user.id
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
