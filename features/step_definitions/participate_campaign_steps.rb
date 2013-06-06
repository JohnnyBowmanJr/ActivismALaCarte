Given(/^I am already logged in as "(.*?)"$/) do |email|
  User.create(:email => email, :password => "password", :password_confirmation => "password")
  visit '/users/sign_in'
  fill_in 'user_email', :with => email 
  fill_in 'user_password', :with => "password"
  click_button 'Sign in'
end

Given(/^an organizer is registered with email "(.*?)"$/) do |email|
  visit '/users/sign_up'
  fill_in 'Email', :with => email 
  fill_in 'Password', :with => "password"
  fill_in 'Password confirmation', :with => "password"
  click_button 'Sign up'
end

Given(/^the user signs out$/) do
  visit '/'
  click_link('Sign Out')
end

Given(/^creates a campaign with target "(.*?)" and phonenumber "(.*?)"$/) do |target, phone|
  visit '/campaigns/new'
  fill_in 'campaign_target_name', :with => target 
  fill_in 'campaign_phone_number', :with => phone
  fill_in 'campaign_action', :with => "Stop fracking"
  fill_in 'campaign_description', :with => "Because dirt is dying"
  fill_in 'campaign_start_date', :with => "07/01/2013"
  fill_in 'campaign_end_date', :with => "07/03/2013"
  click_button 'Done'
end

Given(/^I am on the show page for campaign with target "(.*?)"$/) do |target|
  id = Campaign.first.id
  visit '/campaigns/' + id.to_s
end

Then(/^I should see "(.*?)" as the campaign target and "(.*?)" as the number$/) do |target, number|
  save_and_open_page
  # page.should have_content(target)
  # page.should have_content(number)
end

Given(/^I am on the campaign index page$/) do
  visit '/'
end

Then(/^I should see a list of all active campaigns$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I can sort the campaigns by most popular$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I can sort the campaigns by tag or issue$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I can sort the campaigns by expiration date$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I am on the show page for campaign titled "(.*?)"$/) do |title|
  visit ''
end

Then(/^I should see "(.*?)" as the campaign title$/) do |title|
  pending # express the regexp above with the code you wish you had
end

Then(/^a description of the campaign$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^make a phone call to "(.*?)"$/) do |number|
  pending # express the regexp above with the code you wish you had
end