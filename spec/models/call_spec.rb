require 'spec_helper'

describe Call do
  before do
    @call = Call.make!
  end

  #testing User/Campaign associations
  it "should know which user it belongs to" do
    @call.user.class.should eq(User)
  end

  it "should know campaign it belongs to" do
    @call.campaign.class.should eq(Campaign)
  end

  it { should belong_to(:user) }
  it { should belong_to(:campaign) }
end
