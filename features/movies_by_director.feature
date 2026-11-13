Feature: find other movies by the same director
  As a movie buff
  I want to record a movie's director and find other movies by that director

  Background:
    Given the following movies exist:
      | title        | rating | director     | release_date |
      | Star Wars    | PG     | George Lucas | 1977-05-25   |
      | Blade Runner | PG     | Ridley Scott | 1982-06-25   |
      | Alien        | R      |              | 1979-05-25   |
      | THX-1138     | R      | George Lucas | 1971-03-11   |

  Scenario: add director to existing movie
    When I go to the edit page for "Alien"
    And I fill in "Director" with "Ridley Scott"
    And I press "Update Movie"
    Then the director of "Alien" should be "Ridley Scott"
    And I should see "Ridley Scott"

  Scenario: find movies with the same director
    Given I am on the details page for "Star Wars"
    When I follow "Find Movies With Same Director"
    Then I should be on the Similar Movies page for "Star Wars"
    And I should see "Similar Movies"
    And I should see "THX-1138"
    But I should not see "Blade Runner"
    And I should not see "Alien"
    And I should not see "Star Wars"

  Scenario: return to the movie list when the director is unknown
    Given I am on the details page for "Alien"
    When I follow "Find Movies With Same Director"
    Then I should be on the home page
    And I should see "'Alien' has no director info"
