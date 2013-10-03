class Call < ActiveRecord::Base

  attr_accessible :user_id, :campaign_id, :twilio_id, :recording, :duration, :recording_url

  attr_accessor :token, :number, :target_name

  belongs_to :user
  belongs_to :campaign

  # This gets called in campaigns_controller#get_call_info
  def as_json(options={})
    { 'token' => token, 'target_name' => target_name }
  end

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

  # this gets hit from campaigns#callback (aka after a user hangs up and Twilio 
    # sends the callback request)
  def get_recording_info(twilio_id, call_duration, answered_by)
    self.duration = call_duration
    client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    recordings_info = client.account.calls.get(twilio_id).recordings
    self.recording_url = recordings_info.list.first.mp3
    self.recording = recordings_info.list.first.sid
    self.answered_by = answered_by
    self.save
  end

  # grabs Twilio token via Twilio API
  def twilio_token
    capability = Twilio::Util::Capability.new ACCOUNT_SID, AUTH_TOKEN
    capability.allow_client_outgoing APP_SID
    capability.allow_client_incoming DEFAULT_CLIENT
    self.token = capability.generate
  end

end