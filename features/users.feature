Feature: Users
  
  
  Scenario: Print list of users on the project
  Given the project "agilehybrid"
  When I issue the "users" action
  Then the result should have "schubert - Michael Schubert - michael@schubert.cx" in it
  