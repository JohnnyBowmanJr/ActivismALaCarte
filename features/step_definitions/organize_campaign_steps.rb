Given(/^I am on the create a campaign page$/) do
  visit '/campaigns/new'
end

When(/^I fill in campaign details and click submit$/) do
  fill_in 'campaign_target_name', :with => "Barack Obama" 
  fill_in 'campaign_phone_number', :with => "5555555555"
  fill_in 'campaign_action', :with => "Stop fracking"
  fill_in 'campaign_description', :with => "Because dirt is dying"
  fill_in 'campaign_start_date', :with => "07/01/2013"
  fill_in 'campaign_end_date', :with => "07/03/2013"
  click_button 'Done'
end
  
Then(/^I should have a new campaign$/) do
  assert_equal 1, Campaign.count
end

Given(/^I am logged in with email address "(.*?)"$/) do |email|
  visit '/users/sign_up'
  fill_in 'Email', :with => email 
  fill_in 'Password', :with => "password"
  fill_in 'Password confirmation', :with => "password"
  click_button 'Sign up'
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