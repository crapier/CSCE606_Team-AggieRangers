Feature: As a news writer, I want to finalize the list of articles and format of the issue, and then automatically generate the HTML 

Scenario: Generate the entire issue into HTML
    
    Given I have added some issues
    And I have added some articles for Issue 1
    And I am on the Issue 1 generate page
    Then There should be some generated HTML
    