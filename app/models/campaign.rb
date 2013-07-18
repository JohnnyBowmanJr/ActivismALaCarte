class Campaign < ActiveRecord::Base

  #FriendlyID code- turn target_name and action into slug
  extend FriendlyId
  friendly_id :title, :use => :slugged

  attr_accessible :description, :image_url, :organizer_id, :title, :target_name, :phone_number
  attr_accessible :action, :start_date, :end_date, :image

  attr_accessor :today_calls, :one_day_calls, :two_days_calls, :three_days_calls, :four_days_calls, :five_days_calls
  
  mount_uploader :image, CampaignImageUploader
  
  has_many :users, :through => :calls
  
  belongs_to :organizer, :class_name => 'User', :foreign_key => :organizer_id 
  
  # this should get optimized
  has_many :calls do
    def from_today
      where("calls.created_at > ? and calls.created_at < ?", Date.today, Date.tomorrow)
    end

    def from_one_day
      where("calls.created_at > ? and calls.created_at < ?", Date.today - 1, Date.today)
    end

    def from_two_days
      where("calls.created_at > ? and calls.created_at < ?", Date.today - 2, Date.today - 1)
    end

    def from_three_days
      where("calls.created_at > ? and calls.created_at < ?", Date.today - 3, Date.today - 2)
    end

    def from_four_days
      where("calls.created_at > ? and calls.created_at < ?", Date.today - 4, Date.today - 3)
    end

    def from_five_days
      where("calls.created_at > ? and calls.created_at < ?", Date.today - 5, Date.today - 4)
    end
  end
  
  # this gets called from users#my_recordings_list and returns info for the 
  # campaign call charts for /mycampaigns
  def as_json(options={})
    {'id' => id, 
      'today_calls' => today_calls, 
      'one_day_calls' => one_day_calls, 
      'two_days_calls' => two_days_calls, 
      'three_days_calls' => three_days_calls, 
      'four_days_calls' => four_days_calls, 
      'five_days_calls' => five_days_calls
    }
  end

  def self.outbound_call_instructions(campaign_id)
    target_phone = Campaign.find(campaign_id).phone_number
    outbound_call = Twilio::TwiML::Response.new do |r|
      r.Say 'Please hold while we connect your call. This call may be recorded for quality assurance', :voice => 'woman'
      r.Dial :callerId => "+13109075542", :record => false do |d|
        #change this for target_phone when target_phone format validation has been implemented
        d.Number '+13365753860'
      end
    end
    outbound_call
  end

  def self.calls_per_day(campaigns)
    campaigns.each do |campaign|
      campaign.today_calls = campaign.calls.from_today.length
      campaign.one_day_calls = campaign.calls.from_one_day.length
      campaign.two_days_calls = campaign.calls.from_two_days.length
      campaign.three_days_calls = campaign.calls.from_three_days.length
      campaign.four_days_calls = campaign.calls.from_four_days.length
      campaign.five_days_calls = campaign.calls.from_five_days.length
    end
    campaigns
  end

  
end
