Feature: Takeover a user
  As a staff user
  I want to pretend to be a customer

  Scenario: Normal user cannot takeover other users
    Given I am a normal user "Normal User"
    When I visit the home page
    Then I do not see "are impersonating"
    
    When I visit the takeover page
    Then I am told that page does not exist
  
  Scenario: Staff user finds, takes over and exist
    Given I am a staff user "Dr Nic Williams"
    When I visit the home page
    Then I do not see "are impersonating"

    When I visit the takeover page
    And I search for a user "Normal User"
    And I click link "Takeover"
    Then I see "You ( Dr Nic Williams ) are impersonating Bob ( User id: 1 )"
    When I click link "Revert to admin"

    Then I do not see "are impersonating"
  
