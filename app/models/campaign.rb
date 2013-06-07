class Campaign < ActiveRecord::Base
  attr_accessible :description, :image_url, :organizer_id, :title, :target_name, :phone_number
  attr_accessible :action, :start_date, :end_date
  

  # belongs_to :user
  # has_many :calls,  :source => :called_campaign
  # has_many :callers, :through => :calls, :class_name => 'User'

  
  has_many :calls
  has_many :users, :through => :calls
  
  belongs_to :organizer, :class_name => 'User', :foreign_key => :organizer_id
end
