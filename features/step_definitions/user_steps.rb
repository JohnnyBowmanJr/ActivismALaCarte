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
  click_button 'Sign in'
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