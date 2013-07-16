Feature: Participate in a Campaign

As a potential advocate
I want to participate in existing campaigns on issues I care about

Background:
  Given I am already logged in as "save@trees.com"
  And creates a campaign with target "Barack Obama" and phonenumber "5555555555"
  And the user signs out

Scenario: Browse existing campaigns
  And I am already logged in as "user@email.com"
  And I am on the campaign index page
  Then I should see the campaign with "Barack Obama" as the target

Scenario: Choose a campaign
  Given I am already logged in as "user@email.com"
  And I am on the show page for campaign with target "Barack Obama" 
  Then I should see the campaign with "Barack Obama" as the target and a description of the campaign

@javascript @api
Scenario: Making a campaign call by typing a phone number
  Given I am already logged in as "user@email.com"
  And I am on the show page for campaign with target "Barack Obama" 
  And I enter in my phone number
  And I click the "Call Barack Obama" button
  Then I should receive an initial call from Twilio
  And then be connected to phone number '+15555555555'

@javascript @wip @api
Scenario: Making a campaign call by typing a phone number
  Given I am already logged in as "user@email.com"
  And I am on the show page for campaign with target "Barack Obama" 
  And I click the "Call Barack Obama" button
  Then I should be connected to the phone number '+15555555555' through the browser

  


