Feature: Viewing a group
In order to be see the page for a particular group
As a teacher 
I should be able to click a particular group and se its details

Background:
Given there is a group:
|name|group_code|
|Electronics|ABCDEF|
And there is a user:
|name|email|
|ankur|ankothari@gmail.com|
And I am signed in as them
And i am on the profile page

Scenario: Viewing a group
When I click "Electronics"
Then I should see "Electronics - ABCDEF" with "h2"
And I should see "Create new Timetable" 
