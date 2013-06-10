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
  it { should have_many(:organized_calls).through(:organized_campaigns)}
 
  it "should have many organized calls" do
    Call.make!
    User.first.organized_calls.first.class.should eq(Call)
  end

  # it "should know how many callers he has in his campaign" do
  #   binding.pry
  #   @user.campaigns.first.callers.should eq(2)
  

end