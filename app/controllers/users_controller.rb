class UsersController < ApplicationController
  def mycampaigns
    @backbone = true
    @user_id = current_user.id
    @campaigns = Campaign.where("organizer_id = ?", current_user.id)
    render :mycampaigns
  end

  def my_recordings_list
    binding.pry
    calls = current_user.organized_calls
    render :json => calls
  end

  # this is the route for the MyRecording model in backbone
  def my_recording
  end

end
