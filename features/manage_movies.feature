#Haidan Parajuli csci 457

Feature: add, remove and come back to movies

  As a movie buff
  So that I can keep the list up to date
  I want to add and delete movies and have the list remember how I sorted it

  #each scenario builds its own data so it runs fine on its own
  Background:
    Given the following movies exist:
      | title        | rating | director     | release_date |
      | Star Wars    | PG     | George Lucas | 1977-05-25   |
      | Blade Runner | PG     | Ridley Scott | 1982-06-25   |

  Scenario: add a new movie through the form
    Given I am on the RottenPotatoes home page
    When I follow "New movie"
    And I fill in "Title" with "Inception"
    And I fill in "Rating" with "PG-13"
    And I fill in "Director" with "Christopher Nolan"
    And I fill in "Release date" with "2010-07-16"
    And I press "Create Movie"
    Then I should see "Movie was successfully created."
    And I should see "Christopher Nolan"
    When I follow "Back to movies"
    Then I should see the following movies: Inception, Star Wars, Blade Runner

  Scenario: delete a movie
    Given I am on the details page for "Blade Runner"
    When I press "Destroy this movie"
    Then I should be on the home page
    And I should see "Movie was successfully destroyed."
    And I should not see the following movies: Blade Runner
    But I should see the following movies: Star Wars

  #leaving the list and coming back should bring the saved sort back from the session
  Scenario: remember the sort order after visiting a movie
    Given I am on the RottenPotatoes home page
    When I select "Title" from "sort_by"
    And I press "Refresh"
    And I go to the details page for "Star Wars"
    And I follow "Back to movies"
    Then the "sort_by" field should contain "title"
    And I should see "Blade Runner" before "Star Wars" in the movie list
