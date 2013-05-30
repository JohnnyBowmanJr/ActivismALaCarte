require 'machinist/active_record'

Organizer.blueprint do
  name { Faker::Company.name }
end

Campaign.blueprint do
  title { Faker::Company.catch_phrase }
  description { Faker::Lorem.paragraphs(2).join(" ")}
end

