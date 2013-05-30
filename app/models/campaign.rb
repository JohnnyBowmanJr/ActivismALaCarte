class Campaign < ActiveRecord::Base
  attr_accessible :description, :image_url, :organizer_id, :title
end
