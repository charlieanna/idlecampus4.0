# app = app || angular.module("idlecampus", ["ngResource"])
# @TimetableCtrl = ($scope, $resource) ->
  $scope.timeArray = new Array()
  $scope.college = gon.college
  $scope.batch = gon.batch
  $scope.timetableArray = new Array()
  $scope.mondaytimetableArray = new Array()
  $scope.tuesdaytimetableArray = new Array()
  $scope.wednesdaytimetableArray = new Array()
  $scope.thursdaytimetableArray = new Array()
  $scope.fridaytimetableArray = new Array()
  $scope.saturdaytimetableArray = new Array()
  $scope.teachers = new Array()
  $scope.subjects = new Array()
  $scope.rooms = new Array()
  $scope.weedayArray = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  $scope.add = (i) ->
    $("#sub" + i).hide()
    $("#edit" + i).show()
    subject = $("#s" + i).val()
    room = $("#l" + i).val()
    teacher = $("#t" + i).val()
    $("#s" + i).replaceWith "<span id=s" + i + " >" + subject + "</span>"
    $("#l" + i).replaceWith "<span id=l" + i + " >" + room + "</span>"
    $("#t" + i).replaceWith "<span id=t" + i + " >" + teacher + "</span>"
    timetableEntry =
      subject: subject
      teacher: teacher
      room: room
      weekday: weedayArray[Math.floor((i - 1) / 6)]
      from_hours: timetableArray[i - 1].from_hours
      from_minutes: timetableArray[i - 1].from_minutes
      to_minutes: timetableArray[i - 1].to_minutes
      to_hours: timetableArray[i - 1].to_hours

    timetableArray[i - 1] = timetableEntry
    console.log "BBBBB"
    console.log i + " " + Math.floor((i - 1) / 6)
    console.log timetableEntry
  $scope.edit = (i)->
    $select1 = undefined
    $select2 = undefined
    $select3 = undefined
    arr1 = undefined
    arr2 = undefined
    arr3 = undefined
    ii = undefined
    val = undefined
    $("#sub" + i).show()
    $("#edit" + i).hide()
    subject = $("#s" + i).html()
    room = $("#l" + i).html()
    teacher = $("#t" + i).html()
    $("#s" + i).replaceWith "<select class=\"span2\"id = s" + i + "></select"
    $("#l" + i).replaceWith "<select  class=\"span2\"id = l" + i + "></select"
    $("#t" + i).replaceWith "<select class=\"span2\" id = t" + i + "></select"
    arr1 = teachers
    $select1 = $("#t" + i)
    ii = 0
    while ii < arr1.length
      val = arr1[ii]
      $("<option>").val(val).text(val).appendTo $select1
      ii++
    $("#t" + i).val teacher
    arr2 = subjects
    $select2 = $("#s" + i)
    ii = 0
    while ii < arr2.length
      val = arr2[ii]
      $("<option>").val(val).text(val).appendTo $select2
      ii++
    $("#s" + i).val subject
    arr3 = rooms
    $select3 = $("#l" + i)
    ii = 0
    while ii < arr3.length
      val = arr3[ii]
      $("<option>").val(val).text(val).appendTo $select3
      ii++
    $("#l" + i).val room
  $scope.getDisplayTime = (time1) ->
    console.log time1
    from_date_hour = time1[0].from_hours
    from_date_minute = time1[0].from_minutes
    to_date_minute = time1[0].to_minutes
    to_date_hour = time1[0].to_hours
    display_from = undefined
    if from_date_hour >= 12
      display_from = from_date_hour - 12 + ":"
      display_from = display_from + from_date_minute
      display_from = display_from + "PM"
    else
      display_from = from_date_hour + ":"
      display_from = display_from + from_date_minute
      display_from = display_from + "AM"
    display_to = undefined
    if to_date_hour >= 12
      display_to = to_date_hour - 12 + ":"
      display_to = display_to + to_date_minute
      display_to = display_to + "PM"
    else
      display_to = to_date_hour + ":"
      display_to = display_to + to_date_minute
      display_to = display_to + "AM"
    display_from + "-" + display_to

  Timetable = $resource("/timetable/gettcb", {},
    update:
      method: "PUT"
  )
  $scope.data = Timetable.query(
    college: "mpstme"
    batch: "electronics"
  , (rdata) ->
    data = rdata[0]
    a = undefined
    display_from = undefined
    display_to = undefined
    entries = undefined
    from_date_hour = undefined
    from_date_minute = undefined
    from_hours = undefined
    from_minutes = undefined
    i = undefined
    r = undefined
    ro = undefined
    room = undefined
    row = undefined
    rowCount = undefined
    sub = undefined
    subject = undefined
    tea = undefined
    teacher = undefined
    timetableEntry = undefined
    to_date_hour = undefined
    to_date_minute = undefined
    weedayArray = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    to_hours = undefined
    to_minutes = undefined
    x = undefined
    _results = undefined
    console.log data
    $("#timetable").show()
    entries = data.entries
    a = 0
    while a < entries.length
      subject = entries[a].subject.name
      room = entries[a].room.name
      teacher = entries[a].teacher.name
      from_hours = entries[a].from_hours
      from_minutes = entries[a].from_minutes
      to_minutes = entries[a].to_minutes
      to_hours = entries[a].to_hours
      if jQuery.inArray(teacher, window.teachers) is -1
        window.teachers.push teacher
        $("#teachers ul").append "<li>" + teacher + "</li>"
      if jQuery.inArray(subject, window.subjects) is -1
        window.subjects.push subject
        $("#subjects ul").append "<li>" + subject + "</li>"
      if jQuery.inArray(room, window.rooms) is -1
        window.rooms.push room
        $("#rooms ul").append "<li>" + room + "</li>"
      if entries[a].weekday.name is "Monday"
        timetableEntry =
          subject: subject
          teacher: teacher
          room: room
          weekday: entries[a].weekday.name
          from_hours: entries[a].from_hours
          from_minutes: entries[a].from_minutes
          to_minutes: entries[a].to_minutes
          to_hours: entries[a].to_hours

        mondaytimetableArray.push timetableEntry
        timetableArray.push timetableEntry
      if entries[a].weekday.name is "Tuesday"
        timetableEntry =
          subject: subject
          teacher: teacher
          room: room
          weekday: weedayArray[Math.floor((a + 1) / 6)]
          from_hours: entries[a].from_hours
          from_minutes: entries[a].from_minutes
          to_minutes: entries[a].to_minutes
          to_hours: entries[a].to_hours

        tuesdaytimetableArray.push timetableEntry
        timetableArray.push timetableEntry
      if entries[a].weekday.name is "Wednesday"
        timetableEntry =
          subject: subject
          teacher: teacher
          room: room
          weekday: weedayArray[Math.floor((a + 1) / 6)]
          from_hours: entries[a].from_hours
          from_minutes: entries[a].from_minutes
          to_minutes: entries[a].to_minutes
          to_hours: entries[a].to_hours

        wednesdaytimetableArray.push timetableEntry
        timetableArray.push timetableEntry
      if entries[a].weekday.name is "Thursday"
        timetableEntry =
          subject: subject
          teacher: teacher
          room: room
          weekday: weedayArray[Math.floor((a + 1) / 6)]
          from_hours: entries[a].from_hours
          from_minutes: entries[a].from_minutes
          to_minutes: entries[a].to_minutes
          to_hours: entries[a].to_hours

        thursdaytimetableArray.push timetableEntry
        timetableArray.push timetableEntry
      if entries[a].weekday.name is "Friday"
        timetableEntry =
          subject: subject
          teacher: teacher
          room: room
          weekday: weedayArray[Math.floor((a + 1) / 6)]
          from_hours: entries[a].from_hours
          from_minutes: entries[a].from_minutes
          to_minutes: entries[a].to_minutes
          to_hours: entries[a].to_hours

        fridaytimetableArray.push timetableEntry
        timetableArray.push timetableEntry
      if entries[a].weekday.name is "Saturday"
        timetableEntry =
          subject: subject
          teacher: teacher
          room: room
          weekday: weedayArray[Math.floor((a + 1) / 6)]
          from_hours: entries[a].from_hours
          from_minutes: entries[a].from_minutes
          to_minutes: entries[a].to_minutes
          to_hours: entries[a].to_hours

        saturdaytimetableArray.push timetableEntry
        timetableArray.push timetableEntry
      a++
    console.log mondaytimetableArray
    console.log tuesdaytimetableArray
    console.log wednesdaytimetableArray
    console.log thursdaytimetableArray
    console.log fridaytimetableArray
    console.log saturdaytimetableArray

    r = 0
    while r < mondaytimetableArray.length
      $scope.timeArray[r] = new Array()
      $scope.timeArray[r].push mondaytimetableArray[r]
      $scope.timeArray[r].push tuesdaytimetableArray[r]
      $scope.timeArray[r].push wednesdaytimetableArray[r]
      $scope.timeArray[r].push thursdaytimetableArray[r]
      $scope.timeArray[r].push fridaytimetableArray[r]
      $scope.timeArray[r].push saturdaytimetableArray[r]
      r++


    i = 1
    while i <= 30
      ((i) ->
        $("#edit" + i).click ->
          $select1 = undefined
          $select2 = undefined
          $select3 = undefined
          arr1 = undefined
          arr2 = undefined
          arr3 = undefined
          ii = undefined
          val = undefined
          $("#sub" + i).show()
          $("#edit" + i).hide()
          subject = $("#s" + i).html()
          room = $("#l" + i).html()
          teacher = $("#t" + i).html()
          $("#s" + i).replaceWith "<select class=\"span5\"id = s" + i + "></select"
          $("#l" + i).replaceWith "<select  class=\"span5\"id = l" + i + "></select"
          $("#t" + i).replaceWith "<select class=\"span5\" id = t" + i + "></select"
          arr1 = teachers
          $select1 = $("#t" + i)
          ii = 0
          while ii < arr1.length
            val = arr1[ii]
            $("<option>").val(val).text(val).appendTo $select1
            ii++
          $("#t" + i).val teacher
          arr2 = subjects
          $select2 = $("#s" + i)
          ii = 0
          while ii < arr2.length
            val = arr2[ii]
            $("<option>").val(val).text(val).appendTo $select2
            ii++
          $("#s" + i).val subject
          arr3 = rooms
          $select3 = $("#l" + i)
          ii = 0
          while ii < arr3.length
            val = arr3[ii]
            $("<option>").val(val).text(val).appendTo $select3
            ii++
          $("#l" + i).val room

      ) i
      i++
    i = 1
    _results = []
    while i <= 30
      ((i) ->
        $("#sub" + i).click ->
          $("#sub" + i).hide()
          $("#edit" + i).show()
          subject = $("#s" + i).val()
          room = $("#l" + i).val()
          teacher = $("#t" + i).val()
          $("#s" + i).replaceWith "<span id=s" + i + " >" + subject + "</span>"
          $("#l" + i).replaceWith "<span id=l" + i + " >" + room + "</span>"
          $("#t" + i).replaceWith "<span id=t" + i + " >" + teacher + "</span>"
          timetableEntry =
            subject: subject
            teacher: teacher
            room: room
            weekday: weedayArray[Math.floor((i - 1) / 6)]
            from_hours: timetableArray[i - 1].from_hours
            from_minutes: timetableArray[i - 1].from_minutes
            to_minutes: timetableArray[i - 1].to_minutes
            to_hours: timetableArray[i - 1].to_hours

          timetableArray[i - 1] = timetableEntry
          console.log "BBBBB"
          console.log i + " " + Math.floor((i - 1) / 6)
          console.log timetableEntry

      ) i
      _results.push i++
    _results
  )


window.college = gon.college
window.batch = gon.batch
$(document).ready ->
  i = undefined
  url = undefined
  weedayArray = undefined
  $("#timetable").hide()
  $("#collegename").html window.college
  $("#batchname").html window.batch
  window.timetableArray = new Array()
  window.mondaytimetableArray = new Array()
  window.tuesdaytimetableArray = new Array()
  window.wednesdaytimetableArray = new Array()
  window.thursdaytimetableArray = new Array()
  window.fridaytimetableArray = new Array()
  window.saturdaytimetableArray = new Array()
  window.teachers = new Array()
  window.subjects = new Array()
  window.rooms = new Array()
  weedayArray = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  i = 1
  while i <= 30
    $("#edit" + i).toggle()
    i++
  i = 1
  while i <= 30
    ((i) ->
      $("#edit" + i).click ->
        $select1 = undefined
        $select2 = undefined
        $select3 = undefined
        arr1 = undefined
        arr2 = undefined
        arr3 = undefined
        ii = undefined
        room = undefined
        subject = undefined
        teacher = undefined
        val = undefined
        alert "dsf"
        $("#sub" + i).toggle()
        $("#edit" + i).toggle()
        subject = $("#s" + i).html()
        room = $("#l" + i).html()
        teacher = $("#t" + i).html()
        $("#s" + i).replaceWith "<select id = s" + i + "></select"
        $("#l" + i).replaceWith "<select  id = l" + i + "></select"
        $("#t" + i).replaceWith "<select id = t" + i + "></select"
        arr1 = teachers
        $select1 = $("#t" + i)
        ii = 0
        while ii < arr1.length
          val = arr1[ii]
          $("<option>").val(val).text(val).appendTo $select1
          ii++
        $("#t" + i).val teacher
        arr2 = subjects
        $select2 = $("#s" + i)
        ii = 0
        while ii < arr2.length
          val = arr2[ii]
          $("<option>").val(val).text(val).appendTo $select2
          ii++
        $("#s" + i).val subject
        arr3 = rooms
        $select3 = $("#l" + i)
        ii = 0
        while ii < arr3.length
          val = arr3[ii]
          $("<option>").val(val).text(val).appendTo $select3
          ii++
        $("#l" + i).val room

    ) i
    i++
  i = 1
  while i <= 30
    ((i) ->
      $("#sub" + i).click ->
        room = undefined
        subject = undefined
        teacher = undefined
        timetableEntry = undefined
        alert "h"
        $("#sub" + i).hide()
        $("#edit" + i).toggle()
        subject = $("#s" + i).val()
        room = $("#l" + i).val()
        teacher = $("#t" + i).val()
        $("#s" + i).replaceWith "<span id=s" + i + " >" + subject + "</span>"
        $("#l" + i).replaceWith "<span id=l" + i + " >" + room + "</span>"
        $("#t" + i).replaceWith "<span id=t" + i + " >" + teacher + "</span>"
        timetableEntry =
          subject: subject
          teacher: teacher
          room: room
          weekday: weedayArray[(i + 1) % 6]
          from_hours: entries[a].from_hours
          from_minutes: entries[a].from_minutes
          to_minutes: entries[a].to_minutes
          to_hours: entries[a].to_hours

        timetableArray.push timetableEntry

    ) i
    i++
  $("#group").click ->
    window.group = Math.random().toString(36).substring(7)
    console.log window.group

  $("#send1").click ->
    batch = undefined
    college = undefined
    $("#send1").hide()
    college = $("#college").val()
    batch = $("#batch").val()
    $("#college").replaceWith college
    $("#batch").replaceWith batch

  $("#send2").click ->
    values = undefined
    values = JSON.stringify(timetableArray)
    console.log JSON.stringify(timetableArray)
    $.ajax
      type: "POST"
      url: "http://0.0.0.0:8000/timetable/create"
      data:
        timetable:
          entries: values
          college: $("#college").val()
          batch: $("#batch").val()
          group: window.group

      success: ->

      dataType: ""


  $("#addrow").click ->
    $select1 = undefined
    $select2 = undefined
    $select3 = undefined
    arr1 = undefined
    arr2 = undefined
    arr3 = undefined
    display_from = undefined
    display_to = undefined
    from_date_hour = undefined
    from_date_minute = undefined
    ii = undefined
    room = undefined
    rowCount = undefined
    subject = undefined
    teacher = undefined
    to_date_hour = undefined
    to_date_minute = undefined
    val = undefined
    _results = undefined
    from_date_hour = $("#from_date_hour").val()
    from_date_minute = $("#from_date_minute").val()
    to_date_hour = $("#to_date_hour").val()
    to_date_minute = $("#to_date_minute").val()
    rowCount = ($("#timetable tr").length - 1) * 6 + 1
    display_from = undefined
    if from_date_hour > 12
      display_from = from_date_hour - 12 + ":"
      display_from = display_from + from_date_minute
      display_from = display_from + "PM"
    else if from_date_hour is 12
      display_from = from_date_hour + ":"
      display_from = display_from + from_date_minute
      display_from = display_from + "PM"
    else
      display_from = from_date_hour + ":"
      display_from = display_from + from_date_minute
      display_from = display_from + "AM"
    display_to = undefined
    if to_date_hour > 12
      display_to = to_date_hour - 12 + ":"
      display_to = display_to + to_date_minute
      display_to = display_to + "PM"
    else if to_date_hour is 12
      display_to = to_date_hour + ":"
      display_to = display_to + to_date_minute
      display_to = display_to + "PM"
    else
      display_to = to_date_hour + ":"
      display_to = display_to + to_date_minute
      display_to = display_to + "AM"
    $("#timetable tr:last").after "<tr><td>" + display_from + "-" + display_to + "</td><td>Subject <select  name = \"subject\" id = \"s" + rowCount + "\"></select><br/> room:<select  name = \"room\" id = \"l" + rowCount + "\"/></select><br/> Teacher:<select  name = \"teacher\" id =\"t" + rowCount + "\"/></select><br/> <button class=\"btn btn-mini\" id=\"sub" + rowCount + "\">Add</button><button class=\"btn btn-mini\" id=\"edit" + rowCount++ + "\">Edit</button></td><td>Subject <select  name = \"subject\" id = \"s" + rowCount + "\"></select><br/> room:<select  name = \"room\" id = \"l" + rowCount + "\"/></select><br/> Teacher:<select  name = \"teacher\" id =\"t" + rowCount + "\"/></select><br/> <button class=\"btn btn-mini\" id=\"sub" + rowCount + "\">Add</button><button class=\"btn btn-mini\" id=\"edit" + rowCount++ + "\">Edit</button></td><td>Subject <select  name = \"subject\" id = \"s" + rowCount + "\"></select><br/> room:<select  name = \"room\" id = \"l" + rowCount + "\"/></select><br/> Teacher:<select  name = \"teacher\" id =\"t" + rowCount + "\"/></select><br/> <button class=\"btn btn-mini\" id=\"sub" + rowCount + "\">Add</button><button class=\"btn btn-mini\" id=\"edit" + rowCount++ + "\">Edit</button></td><td>Subject <select  name = \"subject\" id = \"s" + rowCount + "\"></select><br/> room:<select  name = \"room\" id = \"l" + rowCount + "\"/></select><br/> Teacher:<select  name = \"teacher\" id =\"t" + rowCount + "\"/></select><br/> <button class=\"btn btn-mini\" id=\"sub" + rowCount + "\">Add</button><button class=\"btn btn-mini\" id=\"edit" + rowCount++ + "\">Edit</button></td><td>Subject <select  name = \"subject\" id = \"s" + rowCount + "\"></select><br/> room:<select  name = \"room\" id = \"l" + rowCount + "\"/></select><br/> Teacher:<select  name = \"teacher\" id =\"t" + rowCount + "\"/></select><br/> <button class=\"btn btn-mini\" id=\"sub" + rowCount + "\">Add</button><button class=\"btn btn-mini\" id=\"edit" + rowCount++ + "\">Edit</button></td><td>Subject <select  name = \"subject\" id = \"s" + rowCount + "\"></select><br/> room:<select  name = \"room\" id = \"l" + rowCount + "\"/></select><br/> Teacher:<select  name = \"teacher\" id =\"t" + rowCount + "\"/></select><br/> <button class=\"btn btn-mini\" id=\"sub" + rowCount + "\">Add</button><button class=\"btn btn-mini\" id=\"edit" + rowCount + "\">Edit</button></td></tr>"
    i = 1
    while i <= 30
      ((i) ->
        $("#edit" + i).click ->
          $select1 = undefined
          $select2 = undefined
          $select3 = undefined
          arr1 = undefined
          arr2 = undefined
          arr3 = undefined
          ii = undefined
          room = undefined
          subject = undefined
          teacher = undefined
          val = undefined
          alert "dsf"
          $("#sub" + i).toggle()
          $("#edit" + i).toggle()
          subject = $("#s" + i).html()
          room = $("#l" + i).html()
          teacher = $("#t" + i).html()
          $("#s" + i).replaceWith "<select id = s" + i + "></select"
          $("#l" + i).replaceWith "<select  id = l" + i + "></select"
          $("#t" + i).replaceWith "<select id = t" + i + "></select"
          arr1 = teachers
          $select1 = $("#t" + i)
          ii = 0
          while ii < arr1.length
            val = arr1[ii]
            $("<option>").val(val).text(val).appendTo $select1
            ii++
          $("#t" + i).val teacher
          arr2 = subjects
          $select2 = $("#s" + i)
          ii = 0
          while ii < arr2.length
            val = arr2[ii]
            $("<option>").val(val).text(val).appendTo $select2
            ii++
          $("#s" + i).val subject
          arr3 = rooms
          $select3 = $("#l" + i)
          ii = 0
          while ii < arr3.length
            val = arr3[ii]
            $("<option>").val(val).text(val).appendTo $select3
            ii++
          $("#l" + i).val room

      ) i
      i++
    i = 1
    while i <= 30
      ((i) ->
        from_date_hour = $("#from_date_hour").val()
        from_date_minute = $("#from_date_minute").val()
        to_date_hour = $("#to_date_hour").val()
        to_date_minute = $("#to_date_minute").val()
        $("#sub" + i).click ->
          room = undefined
          subject = undefined
          teacher = undefined
          timetableEntry = undefined
          $("#sub" + i).hide()
          $("#edit" + i).toggle()
          subject = $("#s" + i).val()
          room = $("#l" + i).val()
          teacher = $("#t" + i).val()
          $("#s" + i).replaceWith "<span id=s" + i + " >" + subject + "</span>"
          $("#l" + i).replaceWith "<span id=l" + i + " >" + room + "</span>"
          $("#t" + i).replaceWith "<span id=t" + i + " >" + teacher + "</span>"
          timetableEntry =
            subject: subject
            teacher: teacher
            room: room
            weekday: weedayArray[(i + 1) % 6]
            from_hours: from_date_hour
            from_minutes: from_date_minute
            to_minutes: to_date_hour
            to_hours: to_date_minute

          timetableArray.push timetableEntry
          console.log timetableArray

      ) i
      i++
    i = 1
    _results = []
    while i <= 30
      $("#sub" + i).show()
      $("#edit" + i).hide()
      subject = $("#s" + i).html()
      room = $("#l" + i).html()
      teacher = $("#t" + i).html()
      $("#s" + i).replaceWith "<select name=\"subject\" id = s" + i + "></select"
      $("#l" + i).replaceWith "<select  name=\"room\" id = l" + i + "></select"
      $("#t" + i).replaceWith "<select name=\"teacher\" id = t" + i + "></select"
      arr1 = teachers
      $select1 = $("#s" + i)
      ii = 0
      while ii < arr1.length
        val = arr1[ii]
        $("<option>").val(val).text(val).appendTo $select1
        ii++
      arr2 = subjects
      $select2 = $("#l" + i)
      ii = 0
      while ii < arr2.length
        val = arr2[ii]
        $("<option>").val(val).text(val).appendTo $select2
        ii++
      arr3 = rooms
      $select3 = $("#t" + i)
      ii = 0
      while ii < arr3.length
        val = arr3[ii]
        $("<option>").val(val).text(val).appendTo $select3
        ii++
      _results.push i++
    _results

  $("#teacherbutton").click ->
    teacher = undefined
    teacher = $("#teacherinput").val()
    if jQuery.inArray(teacher, window.teachers) is -1
      window.teachers.push teacher
      $("#teachers ul").append "<li>" + teacher + "</li>"
    $("#teacherinput").val ""

  $("#subjectbutton").click ->
    subject = undefined
    subject = $("#subjectinput").val()
    if jQuery.inArray(subject, window.subjects) is -1
      window.subjects.push subject
      $("#subjects ul").append "<li>" + subject + "</li>"
    $("#subjectinput").val ""

  $("#roombutton").click ->
    room = undefined
    room = $("#roominput").val()
    if jQuery.inArray(room, window.rooms) is -1
      window.rooms.push room
      $("#rooms ul").append "<li>" + room + "</li>"
    $("#roominput").val ""

  $("#new").click ->
    $select1 = undefined
    $select2 = undefined
    $select3 = undefined
    arr1 = undefined
    arr2 = undefined
    arr3 = undefined
    ii = undefined
    room = undefined
    subject = undefined
    teacher = undefined
    val = undefined
    $("#timetable").show()
    i = 1
    while i <= 30
      $("#sub" + i).show()
      $("#edit" + i).hide()
      subject = $("#s" + i).html()
      room = $("#l" + i).html()
      teacher = $("#t" + i).html()
      $("#s" + i).replaceWith "<select name=\"subject\" id = s" + i + "></select"
      $("#l" + i).replaceWith "<select  name=\"room\" id = l" + i + "></select"
      $("#t" + i).replaceWith "<select name=\"teacher\" id = t" + i + "></select"
      arr1 = teachers
      $select1 = $("#s" + i)
      ii = 0
      while ii < arr1.length
        val = arr1[ii]
        $("<option>").val(val).text(val).appendTo $select1
        ii++
      arr2 = subjects
      $select2 = $("#l" + i)
      ii = 0
      while ii < arr2.length
        val = arr2[ii]
        $("<option>").val(val).text(val).appendTo $select2
        ii++
      arr3 = rooms
      $select3 = $("#t" + i)
      ii = 0
      while ii < arr3.length
        val = arr3[ii]
        $("<option>").val(val).text(val).appendTo $select3
        ii++
      i++
    timetableArray.length = 0

