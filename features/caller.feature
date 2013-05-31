Feature: Caller

As a potential advocate
I want to find campaigns I care about
And take action on them

Scenario: A potential advocate signs up with valid information
  Given I am on the sign up page
  When I sign up as a user with email "user@email.com"
  Then I should have an account