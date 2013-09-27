# problem is if i open another chat then the msgs go there instead of coming to me.
console.log gon.names
app = angular.module("idlecampus", ['ngResource','$strap.directives'])
re = /\S+@\S+\.\S+/
# available

app.factory "Data", ->
  pagetitle: "Latest Posts"
  groupscreated: []
  groupsfollowing: []
  folders: []
  groupMessages: []
  user: ""
  isVisible: false
  entries: []
  smallGroups: []
  weekdays: [
    "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
  ];
  batches: []
  timeArray : []
  timetable:
    weekdays: []
    batches: []
    entries: []




@EntryCtrl = ($scope, $http, Data) ->
  $scope.Monday = false
  $scope.Tuesday = false
  $scope.Wednesday = false
  $scope.Thursday = false
  $scope.Friday = false
  $scope.Saturday = false
  $scope.Sunday = false
  $scope.data = Data

  $scope.addEntry = (entry) ->

    $scope.entry = ""
    entry =
        name: entry
        values: []

    $scope.data.timetable.entries.push entry

    console.log $scope.data.timetable

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


#  $scope.create = ->
#    if $scope.Monday is true
#      $scope.data.timetable.weekdays.push "Monday"
#    if $scope.Tuesday is true
#      $scope.data.timetable.weekdays.push "Tuesday"
#    if $scope.Wednesday is true
#      $scope.data.timetable.weekdays.push "Wednesday"
#    if $scope.Thursday is true
#      $scope.data.timetable.weekdays.push "Thursday"
#    if $scope.Friday is true
#      $scope.data.timetable.weekdays.push "Friday"
#    if $scope.Saturday is true
#      $scope.data.timetable.weekdays.push "Saturday"
#    if $scope.Sunday is true
#      $scope.data.timetable.weekdays.push "Sunday"
#
#    #      m = 0
#    #      while m < $scope.data.timetable.weekdays.length
#    #       $scope.data.timeArray[m] = new Array()
#    #       m++
#    #      console.log "ZZZZZZZZZZ"
#    #      console.log $scope.data.timeArray
#
#
#




  $scope.currentEntry = (entry) ->
    $scope.data.entry = entry

  $scope.addValueToEntry = (value, entry) ->
    console.log "entry"
    $scope.value = ""
    console.log $scope.data.timetable


    i = 0

    while i < $scope.data.timetable.entries.length
      $scope.data.timetable.entries[i].values.push value  if $scope.data.timetable.entries[i].name is entry
      i++
      console.log $scope.data.timetable


@GroupsCtrl = ($scope, Group, Folder, FilesForFolder, Timetable, Data,$http) ->
  $scope.changeVisibility = ->
    $scope.data.isVisible = !$scope.data.isVisible
  $scope.data = Data
  $scope.$watch "groupscreated", (newValue, oldValue) ->
    console.log "watch"
    console.log newValue

  $scope.$watch "currentGroup", (newValue, oldValue) ->
    console.log "currentGroup"
    console.log newValue

  $scope.$watch "folders", (newValue, oldValue) ->
    console.log "folders"
    console.log newValue

  $scope.$watch "groupMessages", (newValue, oldValue) ->
    console.log "groupMessages"
    console.log newValue



  $scope.$watch "data.timeArray", (newValue, oldValue) ->
    console.log "timearray"
    console.log newValue


  $scope.$watch "data.timetable", (newValue, oldValue) ->
    console.log "timetable"
    console.log newValue


  $scope.$watch "data", (newValue, oldValue) ->
    console.log "data"


    console.log newValue






  $scope.get = ->
    $http(
      method: "GET"
      url: "/timetable/get_timetable_for_group"
      params:
        group: $scope.data.currentGroup.group_code
    ).success((rdata, status, headers, config) ->


      console.log "DDDDDDAAAAAATTTTTTTTAAAAAAA"
      console.log rdata
      $("#timetable").show()
      $scope.data.currentGroupCode = rdata.timetable.group_code
      entries = rdata.timetable.entries

      $scope.data.timetable.weekdays = rdata.timetable.weekdays
      $scope.data.timetable.batches = rdata.timetable.batches
      $scope.data.timetable.entries = rdata.timetable.field_entries
      $scope.data.timeArray = entries

      console.log "HHHHHHHHHHHHH"
      console.log $scope.data


    ).error (data, status, headers, config) ->




  $scope.groupclick = (group) ->

    $scope.data.isVisible = true
    $scope.data.currentGroup = group
    $("#mygroupposts").show()
    $("#myposts").hide()
    console.log $scope.folders
    $scope.data.folders = Group.query(
      name: group
      verb: "find_by_name"
    )
    console.log $scope.data.folders
    $scope.data.pagetitle = "Groups"
    $scope.get()

  $scope.backtofolders = ->
    console.log "backtofolders"
    $("#files_for_folders").hide()
    $("#folders").show()
    $("#foldername").hide()
    $("#backtofolders").hide()

  $scope.getGroupsFollowing = ->
    console.log $scope.data.folders
    console.log $scope.XMPP.connection.pubsub
    $scope.XMPP.connection.pubsub.getSubscriptions ((iq) ->
      console.log iq
      $(iq).find("subscription").each ->
      
        node = $(this).attr("node")
        console.log "getgroupsfollwoing"
        $scope.data.groupsfollowing.push node
        console.log $scope.data.groupsfollowing
        $scope.$digest()


        oup = "<li id='" + node + "'>" + "" + "<a href=#detail>" + node + "</a></li>"



    ), 0

  $scope.getGroupsCreated = ->
    $scope.XMPP.connection.pubsub.items $scope.XMPP.connection.jid.split("/")[0] + "/groups", (iq) ->
      $(iq).find("item").each ->
      
        node = $(this).children("value").text()
        #        $("#groupfollowers").trigger "click", [node]
        console.log node
        $.post("http://idlecampus.com/groups/get_group_name",
          group_code: node

        ).done (data) ->

          console.log data

          $scope.data.groupscreated.push data
          console.log $scope.data.groupscreated
          $scope.$digest()


  $scope.joinGroup = ->
   
    group = $scope.data.joingroup
    console.log group
    $scope.XMPP.connection.pubsub.subscribe group, "", ((data) ->
    ), ((data) ->
      console.log "joined"
      $scope.data.groupsfollowing.push group
    ), ((data) ->
    ), true

  $scope.createGroup = (group) ->
  
    group = $scope.data.creategroup
    console.log group
    group_code = ""
    $.post("/groups/get_group_code",
      group: group

    ).done (data) ->
     group_code = data
     console.log data


     $scope.XMPP.connection.pubsub.publish $scope.XMPP.connection.jid.split("/")[0] + "/groups", group_code, (data) ->
      console.log data

     $scope.XMPP.connection.pubsub.createNode group_code, {'pubsub#notification_type': 'normal'}, ->
     grouptoadd = {"group_name":group,"group_code":group_code}
     console.log grouptoadd
     console.log "node created"
     $scope.data.groupscreated.push grouptoadd
     g = new Group()
     g.$createGroup name: group,code:group_code

  $scope.createFolder = (group) ->
    group = $scope.creategroup
    console.log group
    $scope.XMPP.connection.pubsub.publish $scope.XMPP.connection.jid.split("/")[0] + "/groups", group, (data) ->
      console.log data

    $scope.XMPP.connection.pubsub.createNode group, "", ->

    console.log "node created"
    $scope.data.groupscreated.push group
    $.post "/groups",
      name: group


  $scope.publishgroupnote = ->
   
    note = $scope.data.groupnoteform
    message = $build("html",
      xmlns: "http://jabber.org/protocol/xhtml-im"
    ).c("a",
      href: note.toString()
    ).t(note)
    currentgroup = $scope.data.currentGroup
    console.log note + " " + currentgroup
    $scope.XMPP.connection.pubsub.publish currentgroup, note, (data) ->
      console.log data


  $scope.publishgroupalert = ->
    console.log "sending group alert"
    message = $scope.data.message
    currentgroup = $scope.data.currentGroup.group_code
    console.log currentgroup
    $scope.XMPP.connection.pubsub.publish currentgroup, message, (data) ->
      console.log data

    $scope.XMPP.connection.pubsub.getNodeSubscriptions $scope.data.currentGroup.group_code, (iq) ->
      console.log "Subscribers"
      console.log iq
      members = []
      $(iq).find("subscription").each ->
    
        jid = $(this).attr("jid")
        jid = jid.substring(0, jid.indexOf("/"))
        members.push jid
        console.log jid

  $scope.publishgroupassignment = ->
   
    message = $scope.data.assignment
    console.log group
    XMPP.connection.pubsub.publish currentgroup, message, (data) ->
      console.log data





    $scope.publishmessage = ->
    message = $scope.data.message
    node = $scope.nodemessage
    console.log node + " " + message
    XMPP.connection.pubsub.publish node, message, (data) ->
      console.log data


  $scope.publishassignment = ->
    message = $scope.data.assignment
    node = $scope.data.nodemessage
    console.log node + " " + message
    XMPP.connection.pubsub.publish node, message, (data) ->
      console.log data


  $scope.publishalert = ->
    message = $scope.data.message
    node = $scope.data.nodemessage
    console.log node + " " + message
    XMPP.connection.pubsub.publish node, message, (data) ->
      console.log data


  $scope.publishnote = ->
    note = $scope.data.noteform

    # alert($("#note").text());
    message = $build("html",
      xmlns: "http://jabber.org/protocol/xhtml-im"
    ).c("a",
      href: note.toString()
    ).t($("#note").text())

    # console.log(message.toString());
    # console.log(note.toString());
    node = $scope.data.grouptosend

    # console.log(note+" "+node);
    XMPP.connection.pubsub.publish node, message.toString(), (data) ->
      console.log data


app.factory "Group", ($resource) ->
  $resource "/groups/:verb",
    verb: ""
  ,
    update:
      method: "PUT"
      isArray: true
      params:
        name: ""
        verb: "find_by_name"

    createGroup:
      method: "POST"
      params:
        name: ""
        code:""


app.factory "Folder", ($resource) ->
  $resource "/groups/find_by_name",
    group: '@group'
  ,
    create:
      method: "POST"

    index:
      method: "GET"
      isArray: true

    show:
      method: "GET"
      isArray: false

    update:
      method: "PUT"

    destroy:
      method: "DELETE"


app.factory "FilesForFolder", ($resource) ->
  "FilesForFolder"

app.factory "Timetable", ($resource) ->
  "FilesForFolder"




app.directive 'latestposts', ->
  (scope, element) ->
    element.bind "click", ->
      $('#myposts').show()
      $('#mygroupposts').hide()
      $('#currentgroup').hide()


app.directive 'groups', ->
  (scope, element) ->
    element.bind "click", ->
    $('#mygroupposts').show()
    $('#myposts').hide()


app.directive 'deletenode', ->
  (scope, element) ->
    element.bind "click", ->
      #delete a new node here.
      newNode = $("#newnode").val()
      XMPP.connection.pubsub.connect "abc@idlecampus.com", "pubsub.idlecampus.com"
      XMPP.connection.pubsub.deleteNode newNode, callb


app.directive 'addf', ->
  (scope, element) ->
    element.bind "click", ->
      subscribe = $pres(
        to: $("#addfriend").val()
        type: "subscribe"
      )
      XMPP.connection.send subscribe


app.directive 'logout', ->
  (scope, element) ->
    element.bind "click", ->
      console.log "logout"
      window.localStorage.setItem "name", ""
      window.localStorage.setItem "password", ""
      $("#loginname").val ""
      $("#loginpassword").val ""

      # $.mobile.changePage("#zero", {
      #     transition: "slideup"
      # });
      XMPP.connection.disconnect "bored"


app.directive 'accept', ->
  (scope, element) ->
    element.bind "click", ->
      XMPP.connection.send $pres(
        to: XMPP.pending_subscriber
        type: "subscribed"
      )
      XMPP.connection.send $pres(
        to: XMPP.pending_subscriber
        type: "subscribe"
      )
      XMPP.pending_subscriber = null


app.directive 'reject', ->
  (scope, element) ->
    element.bind "click", ->
      XMPP.connection.send $pres(
        to: XMPP.pending_subscriber
        type: "unsubscribed"
      )
      XMPP.pending_subscriber = null

app.directive 'folder', ->
  (scope, element) ->
    element.bind "click", ->
      folder = $(this).text()
      $.get "/groups/find_by_name",
        group: node





#    $("#myfriends").delegate "li", "tap", ->
#      name = $(this).find("a div.roster-jid").html()
#      console.log "1 " + name
#      $("#friendname").html name
#
#    $(document).delegate "#takecollege", "click", (event, ui) ->
#      window.college = $("#inputcollege").val()
#      window.batch = $("#inputbatch").val()
#      $("#inputcollege").hide()
#      $("#inputbatch").hide()
#      $("#takecollege").hide()
#      $("#takebatch").hide()
#      $("#collegename").html window.college
#      $("#batchname").html window.batch
#
#    $(document).delegate "#timetablebutton", "click", (event, ui) ->
#      $("#signuppage").hide()
#      $("#timetablecontainer").show()
#      $("#main").hide()
#      $("#groups").hide()
#      $("#posts").show()
#      window.get_timetable()  if window.college and window.batch
#
#    $(document).bind "contact_added", (ev, data) ->
#      iq = $iq(type: "set").c("query",
#        xmlns: "jabber:iq:roster"
#      ).c("item", data)
#      XMPP.connection.sendIQ iq
#      subscribe = $pres(
#        to: data.jid
#        type: "subscribe"
#      )
#      XMPP.connection.send subscribe


@TimetableCtrl = ($scope, $resource, Data) ->






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

  $scope.data = Data

  $scope.$watch "data.timeArray", (newValue, oldValue) ->
    console.log "timearray"
    console.log newValue


  $scope.$watch "data.timetable", (newValue, oldValue) ->
    console.log "timetable"
    console.log newValue


  $scope.$watch "data", (newValue, oldValue) ->
    console.log "data"

    console.log newValue


  $scope.weedayArray = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]


  $scope.addsmallgroup = (i) ->
    $scope.smallGroups.push i





  $scope.getDisplayTime = (time1) ->
    console.log "TTTTTTTTT"
    console.log time1
    console.log time1[0]
    console.log time1[0][0]
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
      else if to_date_hour == 12
        display_to = to_date_hour + ":"
        display_to = display_to + to_date_minute
        display_to = display_to + "PM"

      else
        display_to = to_date_hour + ":"
        display_to = display_to + to_date_minute
        display_to = display_to + "AM"

      console.log display_from + "-" + display_to
      display_from + "-" + display_to

  Timetable = $resource("/timetable/gettcb", {},
    update:
      method: "PUT"
  )
  $scope.addrow = ->


    #this should equal the number of weekdays present and not necessarily 7 or 6.
    m = 0
    r = $scope.data.timeArray.length

    $scope.data.timeArray[r] = new Array();

    while m < $scope.data.timetable.weekdays.length




      timetableEntry =
        from_hours: $scope.from_date_hour_value.value
        from_minutes: $scope.from_date_minute_value.value
        to_minutes: $scope.to_date_minute_value.value
        to_hours: $scope.to_date_hour_value.value
      console.log "AAAAAAAAAAAA"
      console.log $scope.data.timetable.weekdays[m]
      timetableEntry.weekday = $scope.data.timetable.weekdays[m]
      console.log timetableEntry
      a = []
      a.push timetableEntry
      console.log $scope.data.timeArray[m]
      $scope.data.timeArray[r].push a
      console.log $scope.data.timeArray

      m++
    console.log $scope.data.timeArray


  $scope.new = ->

    $("#timetable").show()


  $scope.addBatchToEntry = (entry) ->

    console.log "PPPPPPPPP"
    console.log entry
    weekday = entry.weekday


    r = 0
    e = new Array()
    i = 0
    console.log  $scope.data.timetable.batches.length
    while i < $scope.data.timetable.batches.length
      timetableEntry =
        from_hours: $scope.from_date_hour_value.value
        from_minutes: $scope.from_date_minute_value.value
        to_minutes: $scope.to_date_minute_value.value
        to_hours: $scope.to_date_hour_value.value
        batch :  $scope.data.timetable.batches[i]
        weekday : weekday

      e.push timetableEntry

      i++

    console.log e
    while r < $scope.data.timeArray.length
      console.log "OOOOOOOOOOO"
      console.log $scope.data.timeArray[r]
      v = 0
      while v < $scope.data.timeArray[r].length
        console.log  $scope.data.timeArray[r][v]
        w = 0
        while w < $scope.data.timeArray[r][v].length
          console.log "SSSSSDDDDDDDD"
          console.log r+" "+v
          $scope.data.timeArray[r][v] = e if $scope.data.timeArray[r][v][w] == entry
          w++
        v++
      r++
  #









  $scope.send = ->

    members = []
    values = []
    values = JSON.stringify($scope.data.timeArray)
#    alert $scope.data.currentGroup.group_code
    console.log JSON.stringify(values)
    if $scope.data.currentGroup
      members = []
      $scope.XMPP.connection.pubsub.getNodeSubscriptions $scope.data.currentGroup.group_code, (iq) ->
        console.log "Subscribers"
        console.log iq
        $(iq).find("subscription").each ->
         
          jid = $(this).attr("jid")
          jid = jid.substring(0, jid.indexOf("/"))
          members.push jid
          console.log jid
        $.ajax
          type: "POST"
          url: "/timetable/create"
          data:
            timetable:
              members: members
              entries: values
              group: $scope.data.currentGroup

          success: ->
            alert "timetable saved"

          dataType: ""




    else
      alert "Please select a group"

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

