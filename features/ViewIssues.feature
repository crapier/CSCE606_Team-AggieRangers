Feature: News Writer can View Issues List

Scenario: View Issues
    
    Given I have added some issues
    And I am on the nth Degree home page
    
    Then I should see the list of issues
