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
    | mail             | name      | pass         | status | role     |
    | test@example.com | Test User | _8UserTest8_ | 1      | verified |
    When I am logged in as "Test User"
    And I click "Profile of Test User"
    Then I should see "My profile"
    And I should see "Test User"

  @api
  Scenario: Successfully login with e-mail
    Given users:
      | name             | status | pass             | mail                         | role     |
      | test_email_login |      1 | test_email_login | test_email_login@example.com | verified |
    And I am on the homepage
    When I click "Log in"
    And I fill in the following:
      | Username or email address | test_email_login@example.com |
      | Password                  | test_email_login             |
    And I press "Log in"
    And I click "Profile of test_email_login"
    Then I should see "My profile"
    And I should see "test_email_login"

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
    And I am on the homepage
    Then I should see "Event by Joe"

  @api
  Scenario: Successfully create event
    Given I am logged in as an "verified"
    And I am on "user"
    And I click "Events"
    And I click "Create Event"
    When I fill in the following:
      | Title                                  | This is a test event |
      | edit-field-event-date-0-value-date     | 2025-01-01           |
      | edit-field-event-date-end-0-value-date | 2025-01-01           |
      | edit-field-event-date-0-value-time     | 11:00:00             |
      | edit-field-event-date-end-0-value-time | 11:00:00             |
      | Location name                          | Technopark           |
    And I fill in the "edit-body-0-value" WYSIWYG editor with "Body description text."
    And I select "UA" from "Country"
    And I wait for AJAX to finish
    Then I should see "City"
    And I fill in the following:
      | City           | Lviv           |
      | Street address | Fedkovycha 60a |
      | Postal code    | 79000          |
      | Oblast         | Lviv oblast    |
    And I press "Create event"
    Then I should see "This is a test event has been created."
    And I should see "THIS IS A TEST EVENT"
    And I should see "Technopark" in the "Main content"
    And I should see "Body description text" in the "Main content"
    And I should see "Fedkovycha 60a" in the "Main content"
    And I should see "79000" in the "Main content"
    And I should see "Lviv" in the "Main content"
    And I should see "Lviv oblast" in the "Main content"
    And I should see "1 Jan '25 11:00" in the "Main content"
