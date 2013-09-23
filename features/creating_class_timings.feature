Feature: Creating the class timings for the timetable 
In order to create the class timmings for the timetable
As a user
I should be able to create class timings as a limit for creating the rows in the timetableFeature: Creating Subjects for a particular group
In order to create subjects so that I can create a timetable
As a teacher
I should be able create new subjects or use existing subjects with a group

Background:
Given there is a group:
|name|group_code|
|Electronics|ABCDEF|
And there is a user:
|name|email|
|ankur|ankothari@gmail.com|
And I am signed in as them
And I am on the profile page

Scenario: Creating Class Timings
Given I am on the profile page
And I select "9" from "from hours"
And I select "00" from "from minutes"
And I select "6" from "to hours"
And I select "30" from "to minutes"
Then the timetable should have a class timing associated from "9:00" to "6.30"