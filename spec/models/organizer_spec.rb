require 'spec_helper'

describe Organizer do
  before do
    @organizer = Organizer.make!
    2.times { @organizer.campaigns.make! }
  end

  it "should know how many followers it has" do
    @organizer.campaigns.length.should eq(2)
    @organizer.campaigns.first.class.should eq(Campaign)
  end
end
