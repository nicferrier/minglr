Feature: Cards
  
  Scenario: Print list of cards in the project
    Given the project "xp"
    When I issue the "cards" action
    Then the result should have "119 - Task      - Build PDF Export Widget on UI" in it
    And the result should have "105 - Epic      - Find people, projects and documents" in it

  Scenario: Print list of cards in the project with a filter
    Given the project "xp"
    And a keyword of "Project"
    When I issue the "cards" action
    Then the result should not have "119 - Task      - Build PDF Export Widget on UI" in it
    Then the result should have "113 - Feature - Update Project" in it
    And the result should have "112 - Feature - Create Project" in it
    And the result should have "105 - Epic    - Find people, projects and documents" in it

  Scenario: Print the details of a card in the project
    Given the project "xp"
    And the card number "112"
    When I issue the "card" action
    Then the result should have "Number: 112" in it
    And the result should have "Name: Create Project" in it
    And the result should have "Type: Feature" in it
    And the result should have "Status:" in it
    And the result should have "Description: N/A" in it
    And the result should have "Attachments:" in it
