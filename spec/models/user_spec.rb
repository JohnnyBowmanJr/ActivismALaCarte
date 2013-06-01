require 'spec_helper'

describe User do
  # before do
  #   @user = User.make!
  #   2.times { @user.campaigns.make! }
  #   2.times { @user.campaigns.first.organizers.make! }
  # end

  #testing User/Campaign associations

  it { should have_many(:calls)}
  it { should have_many(:campaigns).through(:calls) }
  it { should have_many(:organized_campaigns) }
  it { should have_many(:users).through(:organized_campaigns) }
  # it "should know how many campaigns it has" do
  #   binding.pry
  #   @user.campaigns.length.should eq(2)
  #   @user.campaigns.first.class.should eq(Campaign)
  # end

  # it "should know how many callers he has in his campaign" do
  #   binding.pry
  #   @user.campaigns.first.callers.should eq(2)
  

end