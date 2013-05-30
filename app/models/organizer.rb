class Organizer < ActiveRecord::Base
  attr_accessible :name

  has_many :campaigns
end
