class CampaignsController < ApplicationController

  def index
    @current_user = current_user
    render :index
  end

  def show
    @campaign = Campaign.find(params[:id])
    @title = @campaign.target_name + ": " + @campaign.action
    @backbone = true
    render :show
  end

  # this post request to campaigns#voice runs when people click "call" and the Twilio.Device.connect(params);
  # runs in call_view.js
  def voice
    default_client = 'johnny'
    caller_id = '+13109075542'
    number = params[:PhoneNumber]
    binding.pry
    Call.create(:campaign_id => params[:campaign_id], :user_id => current_user.id, :twilio_id => params[:callsid])
    response = Twilio::TwiML::Response.new do |r|
      # Should be your Twilio Number or a verified Caller ID
      r.Dial :callerId => caller_id, :record => true do |d|
        # Test to see if the PhoneNumber is a number, or a Client ID. In
        # this case, we detect a Client ID by the presence of non-numbers
        # in the PhoneNumber parameter.
        if /^[\d\+\-\(\) ]+$/.match(number)
            d.Number(CGI::escapeHTML number)
        else
            d.Client default_client
        end
        render :xml => response.text
      end
    end
  end

  def callback
    binding.pry
    # get call_sid
    # get recording
    # need campaign_id 
    call.user_id = current_user.id
    render :json => call
  end


  def new
    @campaign = Campaign.new
    render :new
  end

  def create
    campaign = Campaign.new(params[:campaign])
    campaign.organizer_id = current_user.id
    campaign.save

    redirect_to campaign_path(campaign)
  end


end
