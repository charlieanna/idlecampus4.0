Feature: Signing up
  In order to create a group and create a timetable 
  As a teacher 
  I want to be able to first create an account on IdleCampus

  Scenario Outline: Creating an account on IdleCampus
    Given I am on the homepage
    And I follow "<link>"
    Then I am on the Signup page
    And after I fill in "Name" with "Ankur Kothari"
    And I fill in "<field>" with "<value>"
    And I fill in "<field1>" with "<value1>"
    Then I click on "Create my Account"
    Then I should see that account has been created.
  Examples:
    | link    | field | value               | field1   | value1 |
    | Sign up | Email | ankothari@gmail.com | Password | akk322 |


  Scenario: Signup when email is already taken
    Given there is a user already registered on IdleCampus
    |name|email|
    |Ankur Kothari|ankothari@gmail.com|
    Given I am on the homepage
    And I follow "Sign up"
    Then I should be on the Signup page
    And after I fill in "Name" with "Ankur Kothari"
    And I fill in "Email" with "ankothari@gmail.com" 
    And I fill in "Password" with "akk322"
    Then I click on "Create my Account"
    Then I should see "Email has already been taken. Did you forget your password?"

 Scenario: Recovering Password because I have forgotten my password
   Given I am on the homepage
   And I follow "Forget Password"
   Then I fill in "Email" with "ankothari@gmail.com"
   Then I get an email to reset my password
   When I click on the email link I am taken to a page for reset my password
   Then I fill in "Password" with "123456"
   And I fill in "Confirm Password" with "123456"
   And I click "Reset Password"
   Then I should be taken to the signin page for a login


 Scenario: Signin automatically after signup
  Given I am on the homepage
    And I click "Sign up"
    Then I should be on the Signup page
    And after I fill in "Name" with "Ankur Kothari"
    And I fill in "Email" with "ankothari@gmail.com" 
    And I fill in "Password" with "akk322"
    Then I click on "Create my Account"
    Then I should be on the users page
    And I should see "Welcome to IdleCampus"
	
	
Scenario: 




