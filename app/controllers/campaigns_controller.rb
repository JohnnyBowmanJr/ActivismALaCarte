class CampaignsController < ApplicationController

  def index
    @current_user = current_user
    render :index
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

  def show
    @campaign = Campaign.find(params[:id])
    @title = @campaign.target_name + ": " + @campaign.action
    @backbone = true
    # default_client = "johnny"
    # # Find these values at twilio.com/user/account
    # account_sid = 'AC3ecb799e792404580fe5e903b88d3929'
    # auth_token = 'd5ee548232ded22642dfe296d46df3af'
  
    # capability = Twilio::Util::Capability.new account_sid, auth_token
    # # Create an application sid at twilio.com/user/account/apps and use it here
    # capability.allow_client_outgoing "APc47ff3822652f09502959b08335d24a7"
    # capability.allow_client_incoming default_client
    # @token = capability.generate

    render :show
  end

  def voice
    default_client = 'johnny'
    caller_id = '+13109075542'
    number = params[:PhoneNumber]
    binding.pry
    response = Twilio::TwiML::Response.new do |r|
      # Should be your Twilio Number or a verified Caller ID
      r.Dial :callerId => caller_id do |d|
        # Test to see if the PhoneNumber is a number, or a Client ID. In
        # this case, we detect a Client ID by the presence of non-numbers
        # in the PhoneNumber parameter.
        if /^[\d\+\-\(\) ]+$/.match(number)
            d.Number(CGI::escapeHTML number)
        else
            d.Client default_client
        end
      end
    end
    render :xml => response.text
  end


end
