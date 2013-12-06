@TimetableCtrl = ["$scope", "$resource", "Data", ($scope, $resource, Data) ->
  Timetable = undefined
  $scope.data = Data
  $scope.entries = []
  $scope.from_date_hour = [
    display: "00 AM"
    value: "00"
  ,
    display: "01 AM"
    value: "01"
  ,
    display: "02 AM"
    value: "02"
  ,
    display: "03 AM"
    value: "03"
  ,
    display: "04 AM"
    value: "04"
  ,
    display: "05 AM"
    value: "05"
  ,
    display: "06 AM"
    value: "06"
  ,
    display: "07 AM"
    value: "07"
  ,
    display: "08 AM"
    value: "08"
  ,
    display: "09 AM"
    value: "09"
  ,
    display: "10 AM"
    value: "10"
  ,
    display: "11 AM"
    value: "11"
  ,
    display: "12 AM"
    value: "12"
  ,
    display: "01 PM"
    value: "13"
  ,
    display: "02 PM"
    value: "14"
  ,
    display: "03 PM"
    value: "15"
  ,
    display: "04 PM"
    value: "16"
  ,
    display: "05 PM"
    value: "17"
  ,
    display: "06 PM"
    value: "18"
  ,
    display: "07 PM"
    value: "19"
  ,
    display: "08 PM"
    value: "20"
  ,
    display: "09 PM"
    value: "21"
  ,
    display: "10 PM"
    value: "22"
  ,
    display: "11 PM"
    value: "23"
  ]
  $scope.from_date_minute = [
    display: "00"
    value: "00"
  ,
    display: "05"
    value: "05"
  ,
    display: "10"
    value: "10"
  ,
    display: "15"
    value: "15"
  ,
    display: "20"
    value: "20"
  ,
    display: "25"
    value: "25"
  ,
    display: "30"
    value: "30"
  ,
    display: "35"
    value: "35"
  ,
    display: "40"
    value: "40"
  ,
    display: "45"
    value: "45"
  ,
    display: "50"
    value: "50"
  ,
    display: "55"
    value: "55"
  ]
  $scope.to_date_hour = [
    display: "00 AM"
    value: "00"
  ,
    display: "01 AM"
    value: "01"
  ,
    display: "02 AM"
    value: "02"
  ,
    display: "03 AM"
    value: "03"
  ,
    display: "04 AM"
    value: "04"
  ,
    display: "05 AM"
    value: "05"
  ,
    display: "06 AM"
    value: "06"
  ,
    display: "07 AM"
    value: "07"
  ,
    display: "08 AM"
    value: "08"
  ,
    display: "09 AM"
    value: "09"
  ,
    display: "10 AM"
    value: "10"
  ,
    display: "11 AM"
    value: "11"
  ,
    display: "12 AM"
    value: "12"
  ,
    display: "01 PM"
    value: "13"
  ,
    display: "02 PM"
    value: "14"
  ,
    display: "03 PM"
    value: "15"
  ,
    display: "04 PM"
    value: "16"
  ,
    display: "05 PM"
    value: "17"
  ,
    display: "06 PM"
    value: "18"
  ,
    display: "07 PM"
    value: "19"
  ,
    display: "08 PM"
    value: "20"
  ,
    display: "09 PM"
    value: "21"
  ,
    display: "10 PM"
    value: "22"
  ,
    display: "11 PM"
    value: "23"
  ]
  $scope.to_date_minute = [
    display: "00"
    value: "00"
  ,
    display: "05"
    value: "05"
  ,
    display: "10"
    value: "10"
  ,
    display: "15"
    value: "15"
  ,
    display: "20"
    value: "20"
  ,
    display: "25"
    value: "25"
  ,
    display: "30"
    value: "30"
  ,
    display: "35"
    value: "35"
  ,
    display: "40"
    value: "40"
  ,
    display: "45"
    value: "45"
  ,
    display: "50"
    value: "50"
  ,
    display: "55"
    value: "55"
  ]
  $scope.from_date_hour_value = $scope.from_date_hour[9]
  $scope.from_date_minute_value = $scope.from_date_minute[0]
  $scope.to_date_hour_value = $scope.to_date_hour[10]
  $scope.to_date_minute_value = $scope.to_date_minute[0]
  $scope.$watch "data.timeArray", (newValue, oldValue) ->
    
    # console.log newValue

  $scope.$watch "data.timetable", (newValue, oldValue) ->
   
    # console.log newValue

  $scope.$watch "data", (newValue, oldValue) ->
 
    # console.log newValue

  $scope.weedayArray = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  $scope.addsmallgroup = (i) ->
    $scope.smallGroups.push i
    
  $scope.edit1hbhjb = ->
    console.log "working"
    $("#calendar .fc-header").first().remove()
    $("#calendar .fc-content").first().remove()
    $scope.setUpCalendar true, $scope.entries
    return
    
  $scope.addEntry = ->
    entry =
      title: "ASdasd"
      start: new Date($("#apptStartTime").val())
      end: new Date($("#apptEndTime").val())
      allDay: ($("#apptAllDay").val() is "true")
      teacher: $('#addtimetableentry #teacher option:selected').text(),
      room: $('#addtimetableentry #room option:selected').text(),
      subject: $('#addtimetableentry #subject option:selected').text()
    

    $scope.entries.push entry
    $("#calendar").fullCalendar "renderEvent",
      title: ""
      start: new Date($("#apptStartTime").val())
      end: new Date($("#apptEndTime").val())
      allDay: ($("#apptAllDay").val() is "true")
      teacher: $("#addtimetableentry #teacher option:selected").text()
      room: $("#addtimetableentry #room option:selected").text()
      subject: $("#addtimetableentry #subject option:selected").text()
    , true
    return
    
  $scope.get = ->
    date = new Date()
    d = date.getDate()
    m = date.getMonth()
    y = date.getFullYear()
    $.get window.location.pathname, (data) ->
      $scope.data.currentGroupCode = data.timetable.group_code
      entries = data.timetable.entries
      $scope.data.timeArray = []
      $scope.data.timetable.weekdays = []
      $scope.data.timetable.batches = []
      $scope.data.timetable.entries = [
        name: "teacher"
        values: []
      ,
        name: "subject"
        values: []
      ,
        name: "room"
        values: []
      ]
      if entries?
        
        $scope.data.timetable.batches = data.timetable.batches
        $scope.data.checked = true  if $scope.data.timetable.batches.length > 0
        $scope.data.timetable.entries = data.timetable.field_entries
        $scope.data.timeArray = entries
     
      weekday = new Array(7)
      weekday[0] = "Sunday"
      weekday[1] = "Monday"
      weekday[2] = "Tuesday"
      weekday[3] = "Wednesday"
      weekday[4] = "Thursday"
      weekday[5] = "Friday"
      weekday[6] = "Saturday"
      if data.timetable.entries?
        i = 0

        while i < data.timetable.entries.length
          obj = data.timetable.entries[i][0][0]
          start = new Date(y, m, d, obj.from_hours, obj.from_minutes)
          end = new Date(y, m, d, obj.to_hours, obj.to_minutes)
          currentDay = start.getDay()
          distance = weekday.indexOf(obj.weekday) - currentDay
          start.setDate start.getDate() + distance
          end.setDate end.getDate() + distance
          endtime = $.fullCalendar.formatDate(end, "h:mm tt")
          starttime = $.fullCalendar.formatDate(start, "ddd, h:mm tt")
          mywhen = starttime + " - " + endtime
          entry =
            start: start
            end: end
            title: ""
            teacher: obj.teacher
            subject: obj.subject
            room: obj.room
            allDay: false

          $scope.entries.push entry
          i++
        $scope.setUpCalendar false, $scope.entries
      else
        $scope.setUpCalendar false, []
     
        
        
  $scope.setUpCalendar = (editable, entries) ->
    calendar = $("#calendar").fullCalendar(
      events: entries
      defaultView: "agendaWeek"
      header:
        left: ""
        center: ""
        right: ""

      selectable: editable
      editable: editable
      allDaySlot: false
      select: (start, end, allDay) ->
        endtime = $.fullCalendar.formatDate(end, "h:mm tt")
        starttime = $.fullCalendar.formatDate(start, "ddd, h:mm tt")
        mywhen = starttime + " - " + endtime
        $("#addtimetableentry #apptStartTime").val start
        $("#addtimetableentry #apptEndTime").val end
        $("#addtimetableentry #when").text mywhen
        a = $.fullCalendar.formatDate(start, "MM-dd-yyyy")
        weekday = new Array(7)
        weekday[0] = "Sunday"
        weekday[1] = "Monday"
        weekday[2] = "Tuesday"
        weekday[3] = "Wednesday"
        weekday[4] = "Thursday"
        weekday[5] = "Friday"
        weekday[6] = "Saturday"
        console.log a
        console.log weekday[start.getDay()]
        console.log start.getHours()
        console.log start.getMinutes()
        console.log weekday[end.getDay()]
        console.log end.getHours()
        console.log end.getMinutes()
        $("#addtimetableentry").modal "show"
        $("#start1").text start.getDay()
        $("#end1").text end
        calendar.fullCalendar "unselect"

      eventRender: (event, element) ->
        text = "Teacher: " + event.teacher + "</br>Subject: " + event.subject + " </br>Room: " + event.room
        element.find(".fc-event-title").append "<br/>" + text
        element.find(".fc-event-title").css "margin-top", "-18px"
        element.qtip
          content: text
          position:
              target: "mouse" # Position it where the click was...
              adjust: # ...but don't follow the mouse
                mouse: false
        return

    )


  $scope.getDisplayTime = (time1) ->
    display_from = undefined
    display_to = undefined
    from_date_hour = undefined
    from_date_minute = undefined
    to_date_hour = undefined
    to_date_minute = undefined
    if time1.length > 0
      from_date_hour = time1[0][0].from_hours
      from_date_minute = time1[0][0].from_minutes
      to_date_minute = time1[0][0].to_minutes
      to_date_hour = time1[0][0].to_hours
      if from_date_hour >= 12
        display_from = from_date_hour - 12 + ":"
        display_from = display_from + from_date_minute
        display_from = display_from + "PM"
      else
        display_from = from_date_hour + ":"
        display_from = display_from + from_date_minute
        display_from = display_from + "AM"
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
      display_from + "-" + display_to

  Timetable = $resource("/timetable/gettcb", {},
    update:
      method: "PUT"
  )
  $scope.addrow = ->
    a = undefined
    m = undefined
    r = undefined
    timetableEntry = undefined
    _results = undefined
    m = 0
    r = $scope.data.timeArray.length
    $scope.data.timeArray[r] = new Array()
    _results = []
    while m < $scope.data.timetable.weekdays.length
      timetableEntry =
        from_hours: $scope.from_date_hour_value.value
        from_minutes: $scope.from_date_minute_value.value
        to_minutes: $scope.to_date_minute_value.value
        to_hours: $scope.to_date_hour_value.value

      timetableEntry.weekday = $scope.data.timetable.weekdays[m]
      a = []
      a.push timetableEntry
      $scope.data.timeArray[r].push a
      _results.push m++
    _results

  $scope["new"] = ->
    $("#timetable").show()

  $scope.addBatchToEntry = (entry) ->
    e = undefined
    i = undefined
    r = undefined
    timetableEntry = undefined
    v = undefined
    w = undefined
    weekday = undefined
    _results = undefined
    weekday = entry.weekday
    r = 0
    e = new Array()
    i = 0
    console.log $scope.data.timetable.batches.length
    while i < $scope.data.timetable.batches.length
      timetableEntry =
        from_hours: $scope.from_date_hour_value.value
        from_minutes: $scope.from_date_minute_value.value
        to_minutes: $scope.to_date_minute_value.value
        to_hours: $scope.to_date_hour_value.value
        batch: $scope.data.timetable.batches[i]
        weekday: weekday

      e.push timetableEntry
      i++
    console.log e
    _results = []
    while r < $scope.data.timeArray.length
      v = 0
      while v < $scope.data.timeArray[r].length
        console.log $scope.data.timeArray[r][v]
        w = 0
        while w < $scope.data.timeArray[r][v].length
          $scope.data.timeArray[r][v] = e  if $scope.data.timeArray[r][v][w] is entry
          w++
        v++
      _results.push r++
    _results

  $scope.send = ->
    weekday = new Array(7)
    weekday[0] = "Sunday"
    weekday[1] = "Monday"
    weekday[2] = "Tuesday"
    weekday[3] = "Wednesday"
    weekday[4] = "Thursday"
    weekday[5] = "Friday"
    weekday[6] = "Saturday"
    $("#calendar .fc-header").first().remove()
    $("#calendar .fc-content").first().remove()
    a = $("#calendar").fullCalendar("clientEvents")
    entries = []
    i = 0

    while i < a.length
      console.log a
      entry =
        to_hours: a[i].end.getHours()
        to_minutes: a[i].end.getMinutes()
        from_hours: a[i].start.getHours()
        from_minutes: a[i].start.getMinutes()
        teacher: a[i].teacher
        subject: a[i].subject
        room: a[i].room
        weekday: weekday[a[i].start.getDay()]

      entries.push entry
      i++
    values = JSON.stringify([[entries]])
    v = timetable:
      entries: JSON.stringify([[entries]])
    # $.post window.location.pathname, v
    entries = a
    $scope.setUpCalendar false, entries
    group = $scope.data.currentGroupCode
    $scope.XMPP.connection.pubsub.getNodeSubscriptions group, (iq) ->
      members = []
      $(iq).find("subscription").each ->
        
        jid = $(this).attr("jid")
        jid = jid.substring(0, jid.indexOf("/")) if jid.indexOf("/") != -1
        console.log jid if gon.global.debug
        members.push jid
      
      v = timetable:
        entries: values 
        members: members 
      $.post window.location.pathname, v
        # success: ->
#           alert("Timetable Saved")
#           # $("#result").show()
# 
#         dataType: ""
    
   
     

  $scope.timeArray = new Array()
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
    room = undefined
    subject = undefined
    teacher = undefined
    timetableEntry = undefined
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

  $scope.edit = (i) ->
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

  Timetable = $resource("/timetable/gettcb", {},
    update:
      method: "PUT"
  )
]
$(document).ready ->
  i = undefined
  url = undefined
  weedayArray = undefined
  i = undefined
  url = undefined
  weedayArray = undefined
  # $("#timetable").hide()
 #  $("#collegename").html window.college
 #  $("#batchname").html window.batch
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
    batch = undefined
    college = undefined
    $("#send1").hide()
    college = $("#college").val()
    batch = $("#batch").val()
    $("#college").replaceWith college
    $("#batch").replaceWith batch

  $("#send2").click ->
    values = undefined
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
          timetableEntry = undefined
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
    teacher = undefined
    teacher = $("#teacherinput").val()
    if jQuery.inArray(teacher, window.teachers) is -1
      window.teachers.push teacher
      $("#teachers ul").append "<li>" + teacher + "</li>"
    $("#teacherinput").val ""

  $("#subjectbutton").click ->
    subject = undefined
    subject = undefined
    subject = $("#subjectinput").val()
    if jQuery.inArray(subject, window.subjects) is -1
      window.subjects.push subject
      $("#subjects ul").append "<li>" + subject + "</li>"
    $("#subjectinput").val ""

  $("#roombutton").click ->
    room = undefined
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
