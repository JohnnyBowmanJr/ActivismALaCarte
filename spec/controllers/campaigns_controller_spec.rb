require 'spec_helper'

describe CampaignsController do

  before do 
    @campaign = Campaign.make!
  end

  describe 'show page' do

    it "should retrieve a Twilio token before loading a call on the show page" do
      get 'get_token', :id => @campaign
      expect(response).to be_success
      call = JSON.parse(response.body)
      expect(call["token"].class).to eq(String)
    end

    it 'should render static campaign text' do
      get 'show', :id => @campaign
      expect(response).to be_success
      expect(assigns(:campaign).target_name).to eq(@campaign.target_name)
    end 
  end

  describe "Twilio's Connect API" do
      
    it 'should render XML instructions for Twilio' do
      receive_browser_call_params = {:AccountSid=>"AC3ecb799e792404580fe5e903b88d3929",
        :ApplicationSid=>"AP123f795b7efddfd958bde327bc295def",
        :Caller=>"client:johnny",
        :CallStatus=>"ringing",
        :Called=>"",
        :To=>"",
        :user_id=>"undefined",
        :CallSid=>"CA06c78eb8547264d1f512b79c2749f0f9",
        :campaign_id=>"3",
        :From=>"client:johnny",
        :Direction=>"inbound",
        :ApiVersion=>"2010-04-01",
        :action=>"receive_browser_call",
        :controller=>"campaigns"
      }
      post 'receive_browser_call', receive_browser_call_params
      expect(Call.count).to eq(1)
      expect(response).to eq('<?xml version="1.0" encoding="UTF-8"?><Response><Say voice="woman">Please hold while we connect your call. This call may be recorded for quality assurance</Say><Dial record="false"><Number>+13105929048</Number></Dial></Response>')
    end

    it 'should callback to campaigns#callback and save recording info call' do
      Call.make!
      callback_params = {:AccountSid=>"AC3ecb799e792404580fe5e903b88d3929",
        :ApplicationSid=>"AP123f795b7efddfd958bde327bc295def",
        :Caller=>"client:johnny",
        :CallStatus=>"completed",
        :Duration=>"1",
        :Called=>"",
        :To=>"",
        :CallDuration=>"42",
        :CallSid=>"CA07b2de807d1f5cb049b61fb4a4d776c3",
        :From=>"client:johnny",
        :Direction=>"inbound",
        :ApiVersion=>"2010-04-01",
        :action=>"callback",
        :controller => "campaigns"}
      #call = Call.make!(:twilio_id => params["CallSid"])
      post 'callback', callback_params
      Call.any_instance.stubs(:get_recording_info).with(:twilio_id, :params[:CallDuration]).returns(Call.make!)
      #Twilio::REST::Call.any_instance.stubs(:recordings).returns(r)
      post 'callback', params
      expect(Call.count).to eq(1)
      response = JSON.parse(response.body)
      expect(response).to eq("callback success")
    end  
  end

  describe "shortened URL link" do
    
    # it "should direct user to the proper campaign page" do
    #   link = Link.make!
    #   get("#{ APP_ROOT_URL }s/#{ link.key }")
    #   binding.pry
    #   expect(last.response).to eq(302)
    # end

    
  end
end


