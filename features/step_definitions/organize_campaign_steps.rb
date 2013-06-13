Given(/^I am already logged in as "(.*?)"$/) do |email|
  User.create(:email => email, :password => "password", :password_confirmation => "password")
  visit destroy_user_session_path
  visit '/'
  click_link('Login')
  fill_in 'sign-in-email', :with => email 
  fill_in 'sign-in-password', :with => "password"
  click_button 'sign-in-button'
end

Given(/^I am on the create a campaign page$/) do
  visit '/campaigns/new'
end

Given "everythings fine" do
  step "I am on the create a campaign page"
  step "I fill in campaign details and click submit"
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

Given(/^I am on the My Campaigns page$/) do
  visit '/mycampaigns'
end

Then(/^I should see the number of phone calls the first campaign has had$/) do
  page.should have_content("Total Calls:")
end