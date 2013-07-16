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

    @twilio_params_to_voice = {
      "AccountSid"=>"AC3ecb799e792404580fe5e903b88d3929",
      "ToZip"=>"90404",
      "FromState"=>"CA",
      "Called"=>"+13108041305",
      "FromCountry"=>"US",
      "CallerCountry"=>"US",
      "CalledZip"=>"90404",
      "Direction"=>"outbound-api",
      "FromCity"=>"SANTA MONICA",
      "CalledCountry"=>"US",
      "CallerState"=>"CA",
      "CallSid"=>"CAa8b5c2a048d06f9fb65d21b9288b5749",
      "CalledState"=>"CA",
      "From"=>"+13109075542",
      "CallerZip"=>"90405",
      "FromZip"=>"90405",
      "CallStatus"=>"in-progress",
      "ToCity"=>"SANTA MONICA",
      "ToState"=>"CA",
      "To"=>"+13108041305",
      "ToCountry"=>"US",
      "CallerCity"=>"SANTA MONICA",
      "ApiVersion"=>"2010-04-01",
      "Caller"=>"+13109075542",
      "CalledCity"=>"SANTA MONICA",
      "action"=>"voice",
      "controller"=>"campaigns",
      "campaign_id"=>@campaign.id
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
       "Duration"=>"3",
       "CallerState"=>"CA",
       "CallSid"=>"CA8ee569b1430620a8415b2b491c487cf3",
       "CalledState"=>"CA",
       "From"=>"+13109075542",
       "CallerZip"=>"90405",
       "FromZip"=>"90405",
       "CallStatus"=>"completed",
       "ToCity"=>"SANTA MONICA",
       "ToState"=>"CA",
       "To"=>"+13108041305",
       "CallDuration"=>"131",
       "ToCountry"=>"US",
       "CallerCity"=>"SANTA MONICA",
       "ApiVersion"=>"2010-04-01",
       "Caller"=>"+13109075542",
       "CalledCity"=>"SANTA MONICA",
       "action"=>"callback",
       "controller"=>"campaigns"
    }
  end

  describe "Twilio's RESTful API" do

    it 'should make a successful POST request to calls#create' do
      post 'create', {:campaign_id => @campaign.id.to_s, :phone_number => "+13108041305"}
      expect(response).to be_success
    end

    it 'should make a successful POST request to calls#receive_inbound_call' do 
      post 'receive_inbound_call', @twilio_params_to_voice
      expect(response).to eq('<?xml version="1.0" encoding="UTF-8"?><Response><Say voice="woman">Please hold while we connect your call. This call may be recorded for quality assurance</Say><Dial record="false"><Number>+13105929048</Number></Dial></Response>')
    end

  end

end
