Feature:  News Writer can eidt the information for an Article
  
  Scenario: Edit an Article
    
    Given I have added some issues 
    And I have added some articles for Issue 1
    When I am on the Article 1 page for Issue 1 
    When I follow "Edit"
    Then I should be on the edit Article 1 page for Issue 1
    
    When I fill in "article[title]" with "EditAnArticle"
    And fill in "article[image_url]" with "image1.jpg"
    And fill in "article[content]" with "test content1"
    And I press "Save Changes"
    
    Then I should be on the Article 1 page for Issue 1
    And I should see "EditAnArticle" 