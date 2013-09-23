Feature: Associating Weekdays with the group or the timetable
 In order to build a timetable 
 As a teacher 
 I want to be able to associate weekdays with the timetable

 Background:
Given there is a group:
|name|group_code|
|Electronics|ABCDEF|
And there is a user:
|name|email|
|ankur|ankothari@gmail.com|
And I am signed in as them
And I am on the profile page

Scenario: Checking weekday to add them to the timetable
Given I check "Monday","Tuesday","Wednesday"
Then the new timetable should have values "Monday","Tuesday","Wednesday"

Scenario: Unchecking weekdays to remove them from the timetable
Given I uncheck "Monday"
Then the new timetable should not value "Monday"