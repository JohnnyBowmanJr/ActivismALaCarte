class Sharelink < ActiveRecord::Base
  attr_accessible :short_key, :referrer_id, :campaign_id

  belongs_to :referrer, :class_name => 'User'
  belongs_to :campaign

  has_many :referrals
  has_many :clickers, :class_name => 'User', :through => :referrals 

  def generate_short_code(campaign, current_user)
    self.short_key = Array.new(4){rand(36).to_s(36)}.join
    self.referrer_id = current_user.id
    self.campaign_id = campaign.id
    self.save!
  end

  def self.add_clicker(campaign_id, referrer_id, user)
    share_link = Sharelink.where('campaign_id = ? AND referrer_id =?', campaign_id, referrer_id).first
    share_link.referrals.create(:clicker_id => user.id, :call_conversion => true)
    share_link.clickers << user
    binding.pry
  end
end
