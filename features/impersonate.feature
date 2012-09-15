Feature: Impersonate a user
  As a staff user
  I want to pretend to be a customer

  Scenario: Normal user cannot impersonate other users
    Given I am a normal user "Normal User"
    When I visit the home page
    Then I do not see "are impersonating"
    
    When I visit the impersonate page
    Then I am told that page does not exist
  
  Scenario: Staff user finds, takes over and exist
    Given I am a staff user "Dr Nic Williams"
    When I visit the home page
    Then I do not see "are impersonating"

    When I visit the impersonate page
    And I search for a user "Normal User"
    And I click link "Impersonate"
    Then I see "You ( Dr Nic Williams ) are impersonating Normal User ( User id: 2 )"
    When I click link "Revert to admin"

    Then I do not see "are impersonating"
    Then I see "No longer impersonating Normal User"
  
