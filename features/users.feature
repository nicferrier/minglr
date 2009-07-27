Feature: Users
  
  Scenario: Print list of users on the project
    Given the project "xp"
    When I issue the "users" action
    Then the result should have "schubert - Michael Schubert - michael@schubert.cx" in it
