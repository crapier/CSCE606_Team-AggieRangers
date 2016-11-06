Feature: News Writer can Delete Issues

Scenario: Delete Issue

    Given I have added some issues
    And I have added issue Delete Me
    And I am on the nth Degree home page
    Then I should see the issue "Delete Me"
    
    When I follow "deleteDeleteMe"
    
    Then I should be on the nth Degree home page
    And I should see "Issue 'Delete Me' deleted."
    And I should not see the issue "Delete Me"

