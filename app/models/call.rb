class Call < ActiveRecord::Base
  include ActiveModel::Serializers::JSON
  attr_accessible :user_id, :campaign_id, :twilio_id, :recording, :duration, :recording_url

  attr_accessor :token, :number, :target_name

  belongs_to :user
  belongs_to :campaign
  
  # scope :today, where(:created_at => Date.today)

  #take user_id out of this and call#index when implementing log-in system so that non-logged
  #in users don't get an error when rendering show page. Instead user_id should append to DOM
  #on login screen through modal instead of being passed this way.
  def attributes
    {'token' => token, 
      'campaign_id' => campaign_id, 
      'id' => id, 
      'user_id' => user_id, 
      'number' => number, 
      'created_at' => created_at, 
      'target_name' => target_name
    }
  end

  # def as_json(options={})
  #   {'token' => token, 
  #     'campaign_id' => campaign_id, 
  #     'id' => id, 
  #     'user_id' => user_id, 
  #     'number' => number, 
  #     'created_at' => created_at, 
  #     'target_name' => target_name
  #   }
  # end
  # this is hit from CallsController#create to make initial phone call to user before connecting them
  def self.make_inbound_call(caller_phone, campaign_id)
    client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    inbound_call = client.account.calls.create(
      :from => "+13109075542",   # From your Twilio number
      :to => caller_phone,     # To any number
      :url => TWILIO_APP_URL + 'campaigns/' + campaign_id.to_s + '/calls/receive_inbound_call',
      :method => "POST",
      :record => 'false',
      :IfMachine => "Continue",
      :status_callback => TWILIO_APP_URL + 'campaigns/callback/',
      :status_callback_method => "POST"
    )
    inbound_call
  end

  def get_recording_info(twilio_id, call_duration, answered_by)
    self.duration = call_duration
    client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    recordings_info = client.account.calls.get(twilio_id).recordings
    self.recording_url = recordings_info.list.first.mp3
    self.recording = recordings_info.list.first.sid
    self.answered_by = answered_by
    self.save
  end

  def twilio_token(id)
    self.campaign_id = id
    # if we changed the Call model so that it had a slug instead of a Campaign.id in its table
    # we could avoid doing the Campaign.find in campaigns#get_token. Not sure if that's best practice through
    self.target_name = self.campaign.target_name
    capability = Twilio::Util::Capability.new ACCOUNT_SID, AUTH_TOKEN
    capability.allow_client_outgoing APP_SID
    capability.allow_client_incoming DEFAULT_CLIENT
    self.token = capability.generate
  end

end