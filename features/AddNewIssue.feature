Feature: User can manually add issue

Scenario: Add an issue

    Given I am on the nth Degree home page
    When I follow "New Issue"
    Then I should be on the Create New Issue page
    When I fill in "Title" with "Cucum_test_issue"
    And I fill in "Volume" with "1"
    And fill in "Issue" with "1"
    And select "Date" with "2016,October,24"
    When I press "Save Changes"
    # Then I should be on the nth Degree home page
    # And I should see “Cucum_test_issue”

    # When I fill out the form with the following attributes:
    #  | Title | acds       |
    #  | Volume    | 1 |
    #  | Issue           | 1   |
    # #And select "Date" with "2016,October,24"
    # Then I should be on the nth Degree home page
    # And I should see “Cucum_test_issue”
