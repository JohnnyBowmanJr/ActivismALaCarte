Feature: Organizer

As an advocacy organization
I want to create campaigns
And monitor their progress

Scenario: An organizer signs up with valid information
  Given I am on the sign up page
  When I sign up as a user with email "save@trees.com"
  Then I should have an account

Scenario: A user logs in with valid information
  Given I am on the login page
  And I have already registered as "save@trees.com"
  When I login with email "save@trees.com"
  Then I should be redirected to the home page
  And I should see my name in the nav bar

Scenario: Create a campaign
  Given I am logged in with email "save@trees.com"
  And I am on the create a campaign page
  When I fill in campaign details and click submit
  Then I should have a new campaign

Scenario: Monitor a campaign
  Given I am logged in as organizer "Save the Trees"
  And I am on my campaign index page
  Then I should see the number of phone calls the first campaign has had
  And I should see the number of calls per day for the last week
  And I should see a feed of all users who have recently made phone calls for my campaigns.
  And I should what percentage of my goal I've reached



