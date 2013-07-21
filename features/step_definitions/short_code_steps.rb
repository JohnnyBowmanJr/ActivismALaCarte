Then(/^I should see a short coded link for me to share$/) do
  page.should have_content(http://localhost:3000/)
end

Given(/^I have a shortcoded link$/) do
  Link.make(:key => '12xy', :full_path => 3) }
end

Given(/^I use it to go to a campaign page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see the associated campaign show page$/) do
  pending # express the regexp above with the code you wish you had
end