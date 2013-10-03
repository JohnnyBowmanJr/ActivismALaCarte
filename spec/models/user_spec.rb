require 'spec_helper'

describe User do

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

end