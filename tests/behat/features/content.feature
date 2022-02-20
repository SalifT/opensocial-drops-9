Feature: Content
  In order to test some basic Behat functionality
  As a website user
  I need to be able to see that the Drupal and Drush drivers are working

  @api
  Scenario: Create many nodes
    Given "event" content:
    | title          | description                |
    | Event test one | Event test one description |
    | Event test two | Event test two description |
    And "topic" content:
    | title             | description                   |
    | First topic test  | Topic test first description  |
    | Second topic test | Topic test second description |
    And I am logged in as a user with the "administrator" role
    When I go to "admin/content"
    Then I should see "Event test one"
    And I should see "Event test two"
    And I should see "First topic test"
    And I should see "Second topic test"

  @api
  Scenario: Create users
    Given users:
    | mail            | name     | password    | status |
    | joe@example.com | Joe User | _8UserJoe8_ | 1      |
    And I am logged in as a user with the "administrator" role
    When I visit "admin/people"
    Then I should see the link "Joe User"

  @api
  Scenario: Login as a user created during this scenario
    Given users:
    | mail             | name      | password     | status |
    | test@example.com | Test User | _8UserTest8_ | 1      |
    When I am logged in as "Test User"
    Then I should see the link "Log out"

  @api
  Scenario: Create many terms
    Given "social_tagging" terms:
    | name           | placement     |
    | Social Tag one | Main category |
    | Social Tag two | Main category |
    And I am logged in as a user with the "administrator" role
    When I go to "admin/structure/taxonomy/manage/social_tagging/overview"
    Then I should see "Social Tag one"
    And I should see "Social Tag two"

  @api
  Scenario: Create nodes with specific authorship
    Given users:
    | name     | mail            | status |
    | Joe User | joe@example.com | 1      |
    And "event" content:
    | title        | author   | promote |
    | Event by Joe | Joe User | 1       |
    When I am logged in as a user with the "administrator" role
    And I am on the "Home" page
    Then I should see the link "Event by Joe"
    When I follow "Event by Joe"
    Then I should see the text "Event by Joe"
