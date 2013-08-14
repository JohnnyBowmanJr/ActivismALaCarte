class Referral < ActiveRecord::Base
  attr_accessible :clicker_id, :sharelink_id, :call_conversion

  belongs_to :clicker, :class_name => 'User'
  belongs_to :sharelink
end
