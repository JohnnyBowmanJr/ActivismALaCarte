Feature: User

As a progressive
I want to become a part of a digital action community

Scenario: A user signs up with valid information
  Given I am on the sign up page
  When I sign up as a user with email "save@trees.com"
  Then I should have an account

Scenario: A user logs in with valid information
  Given I am on the login page
  And I have already registered as "save@trees.com"
  When I login with email "save@trees.com"
  Then I should be redirected to the home page
  And I should see my name "Save the Trees" in the nav bar


