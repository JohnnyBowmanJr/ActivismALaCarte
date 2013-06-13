require 'spec_helper'

describe Campaign do
  before do
    @campaign = Campaign.make!
  end

  it { should have_many(:calls) }
  it { should have_many(:users).through(:calls)}
  it { should belong_to(:organizer)}

  describe "method self.create_twilio_response" do
    it "should give twilio response when given a number" do
      response = Campaign.create_twilio_response(@campaign.phone_number)
      expect(response.class).to eq(Twilio::TwiML::Response)
      expect(response.text).to include("johnny")
    end
  end

end
