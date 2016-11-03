Feature: News Writer can view the information for an Issue by following the show link 

Scenario: View Issue
  
    Given I have added some issues
    And I am on the nth Degree home page
    
    When I follow "show Test1"
    Then I should be at an Issue page
    And I should see "Test1"