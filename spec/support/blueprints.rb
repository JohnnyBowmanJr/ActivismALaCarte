require 'machinist/active_record'

Campaign.blueprint do
  target_name { Faker::Name.name }
  action { Faker::Company.catch_phrase }
  description { Faker::Lorem.paragraphs(2).join(" ") }
  phone_number { Faker::PhoneNumber.phone_number }
  organizer_id { User.make!.id}

end

User.blueprint do
  email { Faker::Internet.email }
  password { 'password' }
  password_confirmation { 'password' }
  phone_number { Faker::PhoneNumber.phone_number }
end

Call.blueprint do
  campaign { user.organized_campaigns.make! }
  user_id { User.make!.id }
  campaign_id { campaign.id }
  twilio_id { 'CA07b2de807d1f5cb049b61fb4a4d776c3' }
end

Sharelink.blueprint do
  referrer_id { User.make!.id }
  campaign_id { Campaign.make!.id }
  short_key { Array.new(4){rand(36).to_s(36)}.join.to_s } 
end




