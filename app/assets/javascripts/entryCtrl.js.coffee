
@EntryCtrl = ($scope, $http,Data) ->
  $scope.data = Data
  $scope.Monday = false
  $scope.Tuesday = false
  $scope.Wednesday = false
  $scope.Thursday = false
  $scope.Friday = false
  $scope.Saturday = false
  $scope.Sunday = false
 

  $scope.addEntry = (entry) ->

    $scope.entry = ""
    entry =
        name: entry
        values: []
		
		


    $scope.currentEntry = (entry) ->
      $scope.data.entry = entry

    $scope.addValueToEntry = (value, entry) ->
	  # $("#entryvalue").val("")
      console.log "entry"
      $scope.value = ""
      console.log $scope.data.timetable


      i = 0

      while i < $scope.data.timetable.entries.length
        $scope.data.timetable.entries[i].values.push value  if $scope.data.timetable.entries[i].name is entry
        i++
        console.log $scope.data.timetable

    $scope.data.timetable.entries.push entry

    console.log $scope.data.timetable

  $scope.checked = false

  $scope.steps = ['one', 'two', 'three','four','five'];
  $scope.step = 0;
  $scope.wizard = { tacos: 2 };


  $scope.changechecked = ->
    console.log $scope.checked
    $scope.checked = !$scope.checked
	
    $scope.data.timetable.batches.length = 0

  $scope.isFirstStep = ->
    $scope.step is 0



  $scope.isLastStep = ->
    $scope.step is ($scope.steps.length - 1)

  $scope.isCurrentStep = (step) ->
    $scope.step is step

  $scope.setCurrentStep = (step) ->
    $scope.step = step

  $scope.getCurrentStep = ->
    $scope.steps[$scope.step]

  $scope.getNextLabel = ->
    (if ($scope.isLastStep()) then "Submit" else "Next")

  $scope.handlePrevious = ->
    $scope.step -= (if ($scope.isFirstStep()) then 0 else 1)

  $scope.handleNext = (dismiss) ->
    if $scope.isLastStep()
      dismiss()
    else
      $scope.step += 1

  $scope.addBatch = (batch) ->
    $scope.data.timetable.batches.push batch
    $scope.batch = ""

  $scope.checkWeekday = (weekday) ->
    console.log weekday
    $scope.Monday = !$scope.Monday if weekday == "Monday"
    $scope.Tuesday = !$scope.Tuesday if weekday == "Tuesday"
    $scope.Wednesday = !$scope.Wednesday if weekday == "Wednesday"
    $scope.Thursday = !$scope.Thursday if weekday == "Thursday"
    $scope.Friday = !$scope.Friday if weekday == "Friday"
    $scope.Saturday = !$scope.Saturday if weekday == "Saturday"
    $scope.Sunday = !$scope.Sunday if weekday == "Sunday"
    console.log $scope.Monday
    console.log $scope.data.timetable.weekdays.indexOf(weekday)

    if $scope.Monday is true and $scope.data.timetable.weekdays.indexOf("Monday") == -1
      $scope.data.timetable.weekdays.push "Monday"
    if $scope.Tuesday is true and $scope.data.timetable.weekdays.indexOf("Tuesday") == -1
      $scope.data.timetable.weekdays.push "Tuesday"
    if $scope.Wednesday is true and $scope.data.timetable.weekdays.indexOf("Wednesday") == -1
      $scope.data.timetable.weekdays.push "Wednesday"
    if $scope.Thursday is true and $scope.data.timetable.weekdays.indexOf("Thursday") == -1
      $scope.data.timetable.weekdays.push "Thursday"
    if $scope.Friday is true and $scope.data.timetable.weekdays.indexOf("Friday") == -1
      $scope.data.timetable.weekdays.push "Friday"
    if $scope.Saturday is true and $scope.data.timetable.weekdays.indexOf("Saturday") == -1
      $scope.data.timetable.weekdays.push "Saturday"
    if $scope.Sunday is true and $scope.data.timetable.weekdays.indexOf("Sunday") == -1
      $scope.data.timetable.weekdays.push "Sunday"

    console.log $scope.data.timetable.weekdays
    console.log $scope.Monday
    console.log index
    if weekday == "Monday" and $scope.Monday is false
      index = $scope.data.timetable.weekdays.indexOf("Monday")
      $scope.data.timetable.weekdays.splice(index, 1)
    if weekday == "Tuesday" and $scope.Tuesday is false
      console.log "inside tueday"
      index = $scope.data.timetable.weekdays.indexOf("Tuesday")
      console.log index
      console.log $scope.data.timetable.weekdays
      $scope.data.timetable.weekdays.splice(index, 1)
      console.log $scope.data.timetable.weekdays
    if weekday == "Wednesday" and $scope.Wednesday is false
      index = $scope.data.timetable.weekdays.indexOf("Wednesday")
      $scope.data.timetable.weekdays.splice(index, 1)
    if weekday == "Thursday" and $scope.Thursday is false
      index = $scope.data.timetable.weekdays.indexOf("Thursday")
      $scope.data.timetable.weekdays.splice(index, 1)
    if weekday == "Friday" and $scope.Friday is false
      index = $scope.data.timetable.weekdays.indexOf("Friday")
      $scope.data.timetable.weekdays.splice(index, 1)
    if weekday == "Saturday" and $scope.Saturday is false
      index = $scope.data.timetable.weekdays.indexOf("Saturday")
      $scope.data.timetable.weekdays.splice(index, 1)
    if weekday == "Sunday" and $scope.Sunday is false
      index = $scope.data.timetable.weekdays.indexOf("Sunday")
      $scope.data.timetable.weekdays.splice(index, 1)

    console.log $scope.data.timetable.weekdays

