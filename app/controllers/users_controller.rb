class UsersController < ApplicationController
  def mycampaigns
    @backbone = true
    @user_id = current_user.id
    @campaigns = current_user.organized_campaigns
    render :mycampaigns
  end

  def my_recordings_list
    campaigns = current_user.organized_campaigns
    Campaign.calls_per_day(campaigns)
    render :json => campaigns
  end

  # this is the route for the MyRecordingList collection in backbone
  def my_recordings
    campaigns = current_user.organized_campaigns
    render :json => campaigns
  end

  def is_logged_in
    user = User.new
    if current_user
      user.id = current_user.id
    else
      user.id = "not logged in"
    end
    render :json => user
  end
end
