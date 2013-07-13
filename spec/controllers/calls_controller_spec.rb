require 'spec_helper'

describe CallsController do

  before do
    @campaign = Campaign.make!
    @twilio_callback_after_after_verification = {"AccountSid"=>"AC3ecb799e792404580fe5e903b88d3929",
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
     "campaign_id"=> @campaign.id
    }

    @twilio_callback_after_call_is_made = {"AccountSid"=>"AC3ecb799e792404580fe5e903b88d3929",
      "ToZip"=>"90404",
      "FromState"=>"CA",
      "Called"=>"+13108041305",
      "FromCountry"=>"US",
      "CallerCountry"=>"US",
      "CalledZip"=>"90404",
      "Direction"=>"outbound-api",
      "FromCity"=>"SANTA MONICA",
      "CalledCountry"=>"US",
      "Duration"=>"1",
      "CallerState"=>"CA",
      "CallSid"=>"CAb896fe2cab4aefb5a09d89be4a87c3c8",
      "CalledState"=>"CA",
      "From"=>"+13109075542",
      "CallerZip"=>"90405",
      "FromZip"=>"90405",
      "CallStatus"=>"completed",
      "ToCity"=>"SANTA MONICA",
      "ToState"=>"CA",
      "To"=>"+13108041305",
      "CallDuration"=>"19",
      "ToCountry"=>"US",
      "CallerCity"=>"SANTA MONICA",
      "ApiVersion"=>"2010-04-01",
      "Caller"=>"+13109075542",
      "CalledCity"=>"SANTA MONICA",
      "action"=>"callback",
      "controller"=>"campaigns"
    }
  end

  # it 'should make a successful POST request to calls#inbound_call' do
  #   post 'inbound_call', @twilio_callback_after_after_verification
  #   expect(response).to be_success
  #   response.body.should eq('call success')
  # end

  it 'should make a successful POST request to campaigns#voice' do
    post 'voice', :campaign_id => @campaign.id
    expect(response).to be_success
    response.body.should eq('<?xml version="1.0" encoding="UTF-8"?><Response><Say voice="woman">Please hold while we connect your call</Say><Dial><Number>+13365753850</Number></Dial></Response>')
  end

end
