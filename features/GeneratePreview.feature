Feature: As a news writer, I want to preview the HTML on the generate page

Scenario: Preview the HTML on the Generate Page
    
    Given I have added some issues
    And I have added some articles for Issue 1
    And I am on the Issue 1 generate page
    Then There should be some preview