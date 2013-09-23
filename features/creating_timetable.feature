Feature: Creating a timetable
In order to send timetable to students
As a user
I should be able to create new timetable

Background:
Given there is a group:
|name|group_code|
|Electronics|ABCDEF|
And there is a user:
|name|email|
|ankur|ankothari@gmail.com|
And I am signed in as them
And I am on the profile page


Scenario: Creating timetable 
Given I am on my profile page
And I click "New Timetable"
And I have created the following timetable entries:

And when I click "Create Timetable" 
Then I should see "Timetable has been created."

And then the timetable should be send to all the students who have registered to this group.


Scenario: Creating new timetable by clicking new timetable even though there was existing timetable created.
Given there is a timetable created with the following entries
When I click "New Timetable"
Then I should be asked "Doo you really want to delete the existing timetable"
When I click "YES" the timetable should become empty
And then I should be able create a new timetable by initializing it to empty timetable for the said group