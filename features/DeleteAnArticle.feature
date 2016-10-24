Feature: News Writer can Delete the infromation for an Article
  
  Scenario: Delete an Article
    
    Given I have added some issues 
    And I have added some articles for Issue 1
    And I have added Delete me for Issue 1
    And I am on the Issue 1 page
    And I should see the article "Delete me"
    
    
    When I follow "delete Delete me"
    Then I should be on the Issue 1 page
    And I should not see the article "Delete me"