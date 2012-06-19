Feature: Edit an Item
  Scenario: Edit an Item
    Given there is a User
    And an item exists with description "Water the plants"
    And I am on the list all items page 
    When I click the item number 
    Then I should see "Water the plants"