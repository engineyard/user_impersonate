Feature: Takeover a user
  As a staff user
  I want to pretend to be a customer

  Scenario: Normal user cannot takeover other users
    Given I am a normal user "Bob"
    When I visit the takeover page
    Then I told that page does not exist
  
  Scenario: Staff user finds, takes over and exist
    Given I am a staff user "Dr Nic Williams"
    When I visit the takeover page
    And I search for a user "Bob"
    And I click "Takeover"
    Then I see "You ( Dr Nic Williams ) are impersonating Bob ( User id: 1 )"
    When I click "Revert to admin"
    Then I do not see "You ( Dr Nic Williams ) are impersonating Bob ( User id: 1 )"
  
