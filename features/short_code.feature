Feature: Share a short_coded link

  As a campaign supporter
  I want to share links to campaigns with my friends and track my links' popularity

  Background:
    Given I am already logged in as "save@trees.com"
    And creates a campaign with target "Barack Obama" and phonenumber "5555555555"
    And the user signs out

  @wip
  Scenario: See a short-coded link to share
    Given I am already logged in as "user@email.com"
    And I am on the show page for campaign with target "Barack Obama"
    Then I should see a short coded link for me to share
