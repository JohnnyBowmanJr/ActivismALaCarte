class Call < ActiveRecord::Base
  attr_accessible :campaign_id, :caller_id

  belongs_to :caller, :class_name => 'User', :foreign_key => :caller_id
  belongs_to :participated_campaign, :class_name => "Campaign"
end
