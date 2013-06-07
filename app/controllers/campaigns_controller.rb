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
    Call.create(:campaign_id => params[:campaign_id], :user_id => params[:user_id], :twilio_id => params[:CallSid])
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
      end
    end
    render :xml => response.text
  end

  def callback
    twilio_id = params[:CallSid]
    
    # using the Twilio CallSid from the callback, do a GET request to twilio
    # to get the RecordingSid associated with the CallSid
    client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    recordings_info = client.account.calls.twilio_id.recordings.json
    recording_sid = recordings_info["recordings"].first["sid"]

    #ideally I could grab the actual file from Twilio and save it with something like this
    #recording_file = client.account.recordings.get(recording_sid)
    #File.open("file path that's create under user's own folder", 'w') do 
    #  |file| file.write(recording_file) }

    Call.where("twilio_id = ?", twilio_id).first.save(:duration => params[:CallDuration], :recording => recording)
    render :json => "callback success"
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
