class Call < ActiveRecord::Base
  include ActiveModel::Serializers::JSON
  attr_accessible :user_id, :campaign_id, :twilio_id, :recording, :duration, :recording_url

  attr_accessor :token, :number

  belongs_to :user
  belongs_to :campaign

  #take user_id out of this and call#index when implementing log-in system so that non-logged
  #in users don't get an error when rendering show page. Instead user_id should append to DOM
  #on login screen through modal instead of being passed this way.
  def attributes
    {'token' => token, 'campaign_id' => campaign_id, 'id' => id, 'user_id' => user_id, 'number' => number}
  end

end