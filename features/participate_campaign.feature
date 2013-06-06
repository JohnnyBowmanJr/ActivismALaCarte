Feature: Participate in a Campaign

As a potential advocate
I want to participate in existing campaigns on issues I care about

Background:
  Given an organizer is registered with email "save@trees.com"
  And creates a campaign with target "Barack Obama" and phonenumber "5555555555"
  And the user signs out

Scenario: Browse existing campaigns
  And I am already logged in as "user@email.com"
  And I am on the campaign index page
  Then I should see a list of all active campaigns
  And I can sort the campaigns by most popular
  And I can sort the campaigns by tag or issue
  And I can sort the campaigns by expiration date

@javascript @wip
Scenario: Making a phone call for a campaign
  Given I am already logged in as "user@email.com"
  And I am on the show page for campaign with target "Barack Obama" 
  Then I should see "Barack Obama" as the campaign target and "5555555555" as the number
  And a description of the campaign
  And make a phone call to "555-555-5555"


