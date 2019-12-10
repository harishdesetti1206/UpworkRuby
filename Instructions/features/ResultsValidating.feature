Feature: acceptance test

  @UpworkLogin
  Scenario: LogIn to the Upwork portal and validate the results
    When I LogIn in Upwork
    Then I search with keyword
    Then I click on search button
    Then I search through all profile and compare a random profile in and out
    