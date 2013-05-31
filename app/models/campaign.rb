class Campaign < ActiveRecord::Base
  attr_accessible :description, :image_url, :user_id, :title

  belongs_to :user
  has_many :calls
  has_many :callers, :through => :calls, :class_name => 'User'

end
