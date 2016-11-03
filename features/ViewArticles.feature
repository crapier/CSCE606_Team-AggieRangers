Feature: News Writer can View Articles List

Scenario: View Articles
    
    Given I have added some issues
    And I have added some articles for Issue 1
    And I am on the Issue 1 page
    
    Then I should see the list of articles for Issue 1