Given(/^the user signs out$/) do
  visit destroy_user_session_path
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
  visit campaign_path(Campaign.first.id)
end

Then(/^I should see the campaign with "(.*?)" as the target and "(.*?)" as the number$/) do |target, number|
  page.should have_content(target)
end



Given(/^I am on the campaign index page$/) do
  visit '/'
end

Then(/^a description of the campaign$/) do
  page.should have_content(Campaign.first.description)
end

Then(/^make a phone call to "(.*?)"$/) do |number|
  pending # express the regexp above with the code you wish you had
end