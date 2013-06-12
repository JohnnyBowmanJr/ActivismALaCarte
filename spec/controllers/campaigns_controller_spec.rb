require 'spec_helper'

describe CampaignsController do

  before do 
    @campaign = Campaign.make!
  end

  describe 'show page' do

    it "should retrieve a Twilio token before loading a call on the show page" do
      get 'get_token', :id => @campaign.id
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

  describe 'initiating a call action' do

    it 'should POST to #voice and render XML instructions for Twilio' do
      params = { :PhoneNumber => @campaign.phone_number, :campaign_id => @campaign.id, :user_id => @campaign.organizer_id}
      post 'voice', params
      expect(Call.count).to eq(1)
      expect(response).to be_success
    end

    it 'should callback to campaigns#callback and save a new call' do
      params = {"AccountSid"=>"AC3ecb799e792404580fe5e903b88d3929",
       "ApplicationSid"=>"APc47ff3822652f09502959b08335d24a7",
       "Caller"=>"client:johnny",
       "CallStatus"=>"completed",
       "Duration"=>"1",
       "Called"=>"",
       "To"=>"",
       "CallDuration"=>"20",
       "CallSid"=>"CA8d2f5d4c42986b27da60ffe1846a8c9b",
       "From"=>"client:johnny",
       "Direction"=>"inbound",
       "ApiVersion"=>"2010-04-01",
       "action"=>"callback",
       "controller"=>"campaigns"}
      #call = Call.make!(:twilio_id => params["CallSid"])
      post 'callback', params
      call = Call.new
      call.stubs(:get_recording_info).with(:twilio_id, :params[:CallDuration]).returns(Call.make!)
      #Twilio::REST::Call.any_instance.stubs(:recordings).returns(r)
      post 'callback', params
      expect(Call.count).to eq(1)
      response = JSON.parse(response.body)
      expect(response).to eq("callback success")
    end  
  end
end


