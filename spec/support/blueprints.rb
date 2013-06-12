require 'machinist/active_record'

Campaign.blueprint do
  target_name { Faker::Name.name }
  action { Faker::Company.catch_phrase }
  description { Faker::Lorem.paragraphs(2).join(" ")}
  phone_number { Faker::PhoneNumber.phone_number }
  organizer_id { User.make!.id}

end

User.blueprint do
  email { Faker::Internet.email }
  password { "password"}
  password_confirmation { "password"}
end

Call.blueprint do
  user = User.make!
  campaign = user.organized_campaigns.make!
  user_id {user.id}
  campaign_id {campaign.id}
end



