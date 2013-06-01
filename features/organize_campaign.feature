Feature: Organize a Campaign

As an organizer
I want to create campaigns
And monitor their progress

Scenario: Create a campaign
  Given I am logged in with email address "save@trees.com"
  And I am on the create a campaign page
  When I fill in campaign details and click submit
  Then I should have a new campaign

@wip
Scenario: Monitor a campaign
  Given I am logged in as user "Save the Trees"
  And I am on my campaign index page
  Then I should see the number of phone calls the first campaign has had
  And I should see the number of calls per day for the last week
  And I should see a feed of all users who have recently made phone calls for my campaigns.
  And I should see what percentage of my goal I've reached
  And I should see the average call time per campaign
