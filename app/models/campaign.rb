class Campaign < ActiveRecord::Base
  attr_accessible :description, :image_url, :organizer_id, :title

  belongs_to :organizer
  has_many :calls

end
