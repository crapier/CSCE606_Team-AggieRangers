Feature: News Writer can Edit the Information for an Issue 

Scenario: Edit an Issue

    Given I have added some issues 
    And I am on the Issue 1 page
    And I follow "Edit"
    Then I should be on the Issue 1 edit page
    
    When I fill in "issue[title]" with "NewIssue"
    And I fill in "issue[volume]" with "10"
    And I fill in "issue[issue_number]" with "15"
    And I press "Save Changes"
    
    Then I should be on the Issue 1 page
    And I should see "NewIssue Volume 10 Issue 15"