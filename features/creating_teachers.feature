Feature: Creating Subjects for a particular group
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

Scenario: Creating or associating subjects with electronis group

And I click "New Subjects"
And I fill in subjects with these values:
|Subject|
|Maths|
|Engish|
|Chemistry|
|Physics|
When I click "Create Subjects"
Then I should see these subjects within a list:
|Subject|
|Maths|
|Engish|
|Chemistry|
|Physics|

Scenario: Add new Subject
Given I click "Add new Subject"
And I fill in "Name" with "Seminar"
Then I should see "Seminar" within the subjects list

Scenario:Delete old subject
Given I click "Delete Subject"
Then I should not see "Maths" in the subjects list