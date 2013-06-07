class UsersController < ApplicationController
  def mycampaigns
    @backbone = true
    @campaigns = Campaign.where("organizer_id = ?", current_user.id)
    render :mycampaigns
  end


  def my_recording
    binding.pry
    #grab all the calls for a user
    calls = Call.where("user_id => ?", current_user.id)
    recordings = []
    # iterate through all the calls and send a Twilio GET request for their recording file.
    calls.each do |call|
      client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
      recordings = client.account.recordings.get(call.recording)
    end
    render :json => recordings
  end

end
