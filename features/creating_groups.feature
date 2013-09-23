Feature: Creating Groups
 In order to create specific timetables for specific groups
 As a teacher
 I should be able to create many groups which should be then associated with my name.

 Background: 
  Given there is a user:
  |name|email|
  |ankur|ankothari@gmail.com|
  And I am signed in as them

  Scenario: Creating a group
   Given I am on the users page
   And I click on "New Group"
   And I fill in "Name" with "Electronics"
   And I press "Create Group"
   Then I should see "Group Code: ABCDEF" within an unorderlist

  

