Feature: News Writer Navigate to the HTML Generation Pages

Scenario: Navigate to HTML Generation Page for issue from Show Issues Page
    
    Given I have added some issues
    And I have added some articles for Issue 1
    And I am on the nth Degree home page
    And I follow "generateTest1"
    Then I should be at generate page for Issue 1
    
    
Scenario: Navigate to HTML Generation Page for issue from Particular Issue Page
  
    Given I have added some issues
    And I have added some articles for Issue 1
    And I am on the Issue 1 page
    And I follow "generateTest1"
    Then I should be at generate page for Issue 1