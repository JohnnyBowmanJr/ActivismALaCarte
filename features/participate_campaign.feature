Feature: Participate in a Campaign

As a potential advocate
I want to participate in existing campaigns on issues I care about

Scenario: Browse existing campaigns
  Given I am already logged in as "user@email.com"
  And I am on the campaign index page
  Then I should see a list of all active campaigns
  And I can sort the campaigns by most popular
  And I can sort the campaigns by tag or issue
  And I can sort the campaigns by expiration date

Scenario: Making a phone call for a campaign
  Given I am already logged in as "user@email.com"
  And I am on the show page for campaign titled "Save the Trees" 
  And the campaign's target phone-number is "555-555-5555"
  Then I should see "Save the Trees" as the campaign title
  And a description of the campaign
  And make a phone call to "555-555-5555"


