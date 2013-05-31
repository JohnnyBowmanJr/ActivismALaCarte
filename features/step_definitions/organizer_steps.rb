Given(/^I am on the sign up page$/) do
  visit '/users/sign_up'
end

When(/^I sign up as a user with email "(.*?)"$/) do |email|
  fill_in 'Email', :with => email 
  fill_in 'Password', :with => "password"
  fill_in 'Password confirmation', :with => "password"
  click_button 'Sign up'
end

Then(/^I should have an account$/) do
  assert_equal 1, User.count
end

Given(/^I am on the login page$/) do
  visit '/users/sign_in'
end

Given(/^I have already registered as "(.*?)"$/) do |email|
  User.create(:email => "save@trees.com", :password => "password", :password_confirmation => "password")
end

When(/^I login with email "(.*?)"$/) do |email|
  fill_in 'Email', :with => email
  fill_in 'Password', :with => 'password'
  click_button 'Sign up'
end

Then(/^I should be redirected to the home page$/) do
  current_path.should == root_path
end

Then(/^I should see my name "(.*?)" in the nav bar$/) do |name|
  page.should have_content('Save the Trees')
end

Given(/^I am logged in with email "(.*?)"$/) do |email|
  User.create(:email => "save@trees.com", :password => "password", :password_confirmation => "password")
end

Given(/^I am on the create a campaign page$/) do
  visit '/campaigns/new'
end

When(/^I fill in campaign details and click submit$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should have a new campaign$/) do
  assert_equal 1, Campaign.count
end

Given(/^I am logged in as organizer "(.*?)"$/) do |email|
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

Then(/^I should what percentage of my goal I've reached$/) do
  pending # express the regexp above with the code you wish you had
end