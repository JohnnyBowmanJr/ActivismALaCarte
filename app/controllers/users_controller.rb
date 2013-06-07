class UsersController < ApplicationController
  def mycampaigns
    @backbone = true
    @campaigns = Campaign.where("organizer_id = ?", current_user.id)
    render :mycampaigns
  end


  def my_recording
    binding.pry
    @calls = Call.where("user_id => ?", current_user.id)
    @calls.each do |call|
      client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
      @recording = client.account.recordings.get(call.recording)
    render :json => @list
  end

end
