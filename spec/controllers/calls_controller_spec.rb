require 'spec_helper'

describe CallsController do

  before do
    restful_api_call_params_after_verification = {
    "AccountSid"=>"AC3ecb799e792404580fe5e903b88d3929",
     "FromState"=>"CA",
     "ToZip"=>"90404",
     "OutgoingCallerIdSid"=>"PNaabbd58d59edad29d26ba77fe069125e",
     "Called"=>"+13108041305",
     "VerificationStatus"=>"success",
     "FromCountry"=>"US",
     "CallerCountry"=>"US",
     "CalledZip"=>"90404",
     "Direction"=>"outbound-api",
     "FromCity"=>"POINT REYES STATION",
     "CalledCountry"=>"US",
     "Duration"=>"1",
     "CallerState"=>"CA",
     "CallSid"=>"CA721e4ecc49608f1114f424e3d41fea6c",
     "CalledState"=>"CA",
     "From"=>"+14157234000",
     "CallerZip"=>"94956",
     "FromZip"=>"94956",
     "CallStatus"=>"completed",
     "ToCity"=>"SANTA MONICA",
     "ToState"=>"CA",
     "To"=>"+13108041305",
     "ToCountry"=>"US",
     "CallDuration"=>"23",
     "ApiVersion"=>"2010-04-01",
     "CallerCity"=>"POINT REYES STATION",
     "Caller"=>"+14157234000",
     "CalledCity"=>"SANTA MONICA",
     "action"=>"callback",
     "controller"=>"calls",
     "campaign_id"=>"3"
    }
  end

  it 'should make a POST request to calls#voice' do
    post 'voice', :campaign_id => '3'
    expect(response).to be_success
    expect(Call.count).to eq(1)
  end

  
  it "should make a successful POST request to campaigns/callback" do
    #enter code here to make a post request make sure new call is persisted
  end
  

end
