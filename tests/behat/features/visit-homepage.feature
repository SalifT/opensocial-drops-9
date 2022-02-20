@no_auth
Feature: Visibility of the "Home" page
  In order to have confidence that build tools works
  As a site administrator
  I want to verify I can visit a valid home page on Pantheon

  Scenario: Verify the Home
    When I am on the Home
    Then I should be on the Home page
    And the response status code should be 200
