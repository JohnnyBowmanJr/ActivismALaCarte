class Link < ActiveRecord::Base
  attr_accessible :click_total, :full_path, :key, :user_id

  belongs_to :user
  belongs_to :campaign

  def generate_short_code(campaign, current_user)
    self.key = Array.new(4){rand(36).to_s(36)}.join
    self.user_id = current_user.id
    self.campaign_id = campaign.id
    self.full_path = campaign.slug
    self.save!
  end
end
