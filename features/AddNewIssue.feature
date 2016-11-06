Feature: News Writer can manually add issue

Scenario: Create an Issue

    Given I am on the nth Degree home page
    When I follow "Add Issue"
    Then I should be on the Create New Issue page
    When I fill in "issue[title]" with "Cucum_test_issue"
    And I fill in "issue[volume]" with "1"
    And fill in "issue[issue_number]" with "1"
    And select "2016" from "issue[date(1i)]"
    And select "October" from "issue[date(2i)]" 
    And select "27" from "issue[date(3i)]"
    And I press "Save Changes"
    
    Then I should be on the nth Degree home page
    And I should see the issue "Cucum_test_issue" 
