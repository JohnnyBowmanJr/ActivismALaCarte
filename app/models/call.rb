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
    {'token' => token, 'campaign_id' => campaign_id, 'id' => id, 'user_id' => user_id, 'number' => number, 'created_at' => created_at, 'target_name' => target_name}
  end

  # def as_json(options={})
  #   {'token' => token, 'campaign_id' => campaign_id, 'id' => id, 'user_id' => user_id, 'number' => number, 'created_at' => created_at, 'target_name' => target_name}

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

  def get_recording_info(twilio_id, call_duration)
    self.duration = call_duration
    client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    recordings_info = client.account.calls.get(twilio_id).recordings
    self.recording_url = recordings_info.list.first.mp3
    self.recording = recordings_info.list.first.sid
    self.save
  end

  def twilio_token(id)
    self.campaign_id = id
    self.target_name = self.campaign.target_name
    capability = Twilio::Util::Capability.new ACCOUNT_SID, AUTH_TOKEN
    capability.allow_client_outgoing "APc47ff3822652f09502959b08335d24a7"
    capability.allow_client_incoming DEFAULT_CLIENT
    self.token = capability.generate
  end

end