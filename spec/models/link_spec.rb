require 'spec_helper'

describe Link do
  
  before do
  	@campaign = Campaign.make!
  	@user = User.make!
  end

  it { should belong_to(:user) }
  it { should belong_to(:campaign)}

  it "should generate a new Link with a shortcode and associated user and campaign" do
  	share_link = Link.new
  	share_link.generate_short_code(@campaign, @user)
  	expect(Link.count).to eq(1)
  	share_link.key.length.should eq(4)
  	share_link.user = @user
    share_link.campaign = @campaign
    share_link.full_path = @campaign.slug
  end
end
