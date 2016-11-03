Feature: News Writer can manually add articles

Scenario: New Article
    
    Given I have added some issues
    And I am on the Issue 1 page
    When I follow "New Article"
    Then I should be on the Create New Article page for Issue 1
    When I fill in "article[title]" with "Cucum_test_article"
    And I fill in "article[order_number]" with "1"
    And fill in "article[image_url]" with "image.jpg"
    And fill in "article[content]" with "test content"
    And I press "Save Changes"
    
    Then I should be on the Issue 1 page
    And I should see the article "Cucum_test_article" 