require 'spec_helper'

describe Sharelink do

  before do
    @campaign = Campaign.make!
    @current_user = User.make!

  end

  it 'should generate a unique shortcode for a logged in user' do
	  share_link = Sharelink.new
	  share_link.generate_short_code(@campaign, @current_user)
	  share_link.short_key.length.should eq(4)
	 	Sharelink.count.should eq(1)
	end

	it 'should add those who have clicked on it as a clicker' do
		referrer_id = User.make!.id
		share_link = Sharelink.make!(:referrer_id => referrer_id)
		Sharelink.add_clicker(share_link.campaign_id, referrer_id, @current_user)
	end
end
