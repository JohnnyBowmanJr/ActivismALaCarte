class Campaign < ActiveRecord::Base
  attr_accessible :description, :image_url, :organizer_id, :title, :target_name, :phone_number
  attr_accessible :action, :start_date, :end_date, :image
  
  mount_uploader :image, CampaignImageUploader
  
  has_many :calls
  has_many :users, :through => :calls
  
  belongs_to :organizer, :class_name => 'User', :foreign_key => :organizer_id
end
