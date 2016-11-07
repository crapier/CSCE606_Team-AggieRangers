Feature: News Writer can view the information for an article by following the show link 

Scenario: View Article
    
    Given I have added some issues
    And I have added some articles for Issue 1
    And I am on the Issue 1 page
    
    When I follow "showart_test1"
    Then I should be at an article page for Issue 1
    And I should see /art_test1/