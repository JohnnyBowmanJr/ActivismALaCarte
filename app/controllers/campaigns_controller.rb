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
    campaign_id = params[:campaign_id]
    response = Twilio::TwiML::Response.new do |r|
      # Should be your Twilio Number or a verified Caller ID
      r.status_callback("http://4pzb.localtunnel.com/campaigns/#{campaign_id}/calls/callback")
      r.Dial :callerId => caller_id, :record => true do |d|
        # Test to see if the PhoneNumber is a number, or a Client ID. In
        # this case, we detect a Client ID by the presence of non-numbers
        # in the PhoneNumber parameter.
        if /^[\d\+\-\(\) ]+$/.match(number)
            d.Number(CGI::escapeHTML number)
        else
            d.Client default_client
        end
      end
      
      account_sid = 'AC3ecb799e792404580fe5e903b88d3929'
      auth_token = 'd5ee548232ded22642dfe296d46df3af'

      @client = Twilio::REST::Client.new account_sid, auth_token
    
      @call = @client.account.calls.create(
        :from => '+13109075542',   # From your Twilio number
        :to => '+13108041305',     # To any number
        # Fetch instructions from this URL when the call connects
        :url => 
        :callback_url => "http://4pzb.localtunnel.com/campaigns/#{campaign_id}/calls/callback"
      )
    end
    render :xml => response.text
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
