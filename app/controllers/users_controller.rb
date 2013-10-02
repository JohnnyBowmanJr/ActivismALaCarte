class UsersController < ApplicationController
  def mycampaigns
    @backbone = true
    @mycampaigns = true
    @user_id = current_user.id
    @campaigns = current_user.organized_campaigns
    render :mycampaigns
  end

  # this gets called on myRecordingsList.fetch() in Router.js in order to render the
  # charts for each campaign in /mycampaigns
  def my_recordings_list
    campaigns = current_user.organized_campaigns
    Campaign.calls_per_day(campaigns)
    render :json => campaigns
  end

  # checks to see if user is logged in when user clicks "Call" button.
  # if so, returns user's id via JSON
  def is_logged_in
    user = User.new
    if current_user
      user.id = current_user.id
    else
      # must put integer here, string not allowed
      user.id = 0
    end
    render :json => user
  end

  def my_representatives
    sunlight_base_url = 'http://congress.api.sunlightfoundation.com/legislators/locate?zip='
    zip = current_user.zipcode
    response = HTTParty.get(sunlight_base_url + zip + '&apikey=' + SUNLIGHT_API_KEY)
    @representatives = response["results"]
    render :myrepresentatives
  end
end
