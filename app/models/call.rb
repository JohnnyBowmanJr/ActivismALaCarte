class Call < ActiveRecord::Base
  include ActiveModel::Serializers::JSON
  attr_accessible :user_id, :campaign_id

  attr_accessor :token, :number

  belongs_to :user
  belongs_to :campaign

  def attributes
    {'token' => token, 'campaign_id' => campaign_id, 'id' => id, 'user_id' => user_id, 'number' => number}
  end

end