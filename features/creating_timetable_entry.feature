Feature: Add entry to a timetable
In order to add rows to the timetable so that I can create the timetable
As a user
I should be able to use exsiting subjects, teachers, weekdays,classtimitngs values to a new row

Background:
Given there is a group:
|name|group_code|
|Electronics|ABCDEF|
And there is a user:
|name|email|
|ankur|ankothari@gmail.com|
And I am signed in as them
And I am on the profile page

Scenario: Adding a new entry
  Given I select the classtimings
  And click Add Row
  And I select Maths for subject,Ankur for teacher, check batch, select batch c1
  Then the entry should get added to the timetable

  