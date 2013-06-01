class Call < ActiveRecord::Base
  attr_accessible :user_id, :campaign_id

  # belongs_to :supporter, :class_name => 'User', :foreign_key => :caller_id
  # belongs_to :called_campaign, :class_name => "Campaign", :foreign_key => :called_campaign_id

  belongs_to :user
  belongs_to :campaign

end
