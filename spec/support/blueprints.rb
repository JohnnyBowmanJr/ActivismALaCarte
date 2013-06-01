require 'machinist/active_record'

Campaign.blueprint do
  title { Faker::Company.catch_phrase }
  description { Faker::Lorem.paragraphs(2).join(" ")}
end

User.blueprint do
  email { Faker::Internet.email }
  password { "password"}
  password_confirmation { "password"}
end

Call.blueprint do
  user { User.make! }
  campaign { Campaign.make! }
end


