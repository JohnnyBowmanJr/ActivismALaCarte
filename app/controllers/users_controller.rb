class UsersController < ApplicationController
  def mycampaigns
    @backbone = true
    @user_id = current_user.id
    @campaigns = current_user.organized_campaigns
    render :mycampaigns
  end

  def my_recordings_list
    # calls = current_user.organized_calls
    # render :json => calls
    campaigns = current_user.organized_campaigns
    campaigns.each do |campaign|
      campaign.today_calls = campaign.calls.from_today.length
      campaign.one_day_calls = campaign.calls.from_one_day.length
      campaign.two_days_calls = campaign.calls.from_two_days.length
      campaign.three_days_calls = campaign.calls.from_three_days.length
      campaign.four_days_calls = campaign.calls.from_four_days.length
      campaign.five_days_calls = campaign.calls.from_five_days.length
    end
    render :json => campaigns
  end

  # this is the route for the MyRecordingList collection in backbone
  def my_recordings
    campaigns = current_user.organized_campaigns
    render :json => campaigns
  end

end
