class Call < ActiveRecord::Base
  attr_accessible :campaign_id, :user_id

  belongs_to :user_id
  belongs_to :campaign_id
end
