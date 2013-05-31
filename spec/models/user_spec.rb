require 'spec_helper'

describe User do
  before do
    @user = User.make!
    2.times { @user.campaigns.make! }
    2.times { @user.campaigns.first.callers.make! }
  end

  #testing User/Campaign associations
  it "should know how many campaigns it has" do
    @user.campaigns.length.should eq(2)
    @user.campaigns.first.class.should eq(Campaign)
  end

  it "should know how many callers he has in his campaign" do
    binding.pry
    @user.campaigns.first.callers.should eq(2)
  end

end