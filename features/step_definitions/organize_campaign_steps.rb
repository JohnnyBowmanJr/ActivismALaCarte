Given(/^I am on the create a campaign page$/) do
  visit '/campaigns/new'
end

When(/^I fill in campaign details and click submit$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should have a new campaign$/) do
  assert_equal 1, Campaign.count
end

Given(/^I am logged in as user "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given(/^I am on my campaign index page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see the number of phone calls the first campaign has had$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see the number of calls per day for the last week$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see a feed of all users who have recently made phone calls for my campaigns\.$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see what percentage of my goal I've reached$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see the average call time per campaign$/) do
  pending # express the regexp above with the code you wish you had
end