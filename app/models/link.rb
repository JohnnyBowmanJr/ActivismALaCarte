class Link < ActiveRecord::Base
  attr_accessible :click_total, :full_path, :key, :user_id
end
