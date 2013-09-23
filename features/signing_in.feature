Feature: Signin
  In order to be able to create a timetable for a group 
  As a teacher 
  I should be able to login to IdleCampus after I have signup on the application

  Background:
    Given there is a user:
    |name|email|
    |ankur|ankothari@gmail.com|

  Scenario: Signin
    Given I am on the homepage
    And I follow "Sign in"
    Then I fill in "Email" with "ankothari@gmail.com"
    And I fill in "Password" with "akk322"
    Then I press "Login"
    Then I should be signed in 
    And I should be on the users page

  Scenario: Unsuccessful Signup
   Given I am on the homepage
    And I follow "Sign in"
    Then I fill in "Email" with "ankothari1@gmail.com"
    And I fill in "Password" with "akk322"
    Then I press "Login"
    Then I should not be signed in 
    And I should be on the homepage
    And I should see "User and Password do not match."

  Scenario: Signin with empty fields
   Given I am on the homepage
   And I follow "Sign in"
   And I press "Login"
   Then I should see "Can not have empty fields."

