@GroupsCtrl = ["$scope", "Group", "Data", "$http", ($scope, Group, Data, $http) ->
  $scope.data = Data
  $scope.pagetitle = "Latest Posts"
  $scope.groupscreated = []
  $scope.groupsfollowing = []
  $scope.folders = []
  $scope.groupMessages = []
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

  $scope.get = ->
    $scope.data.checked = false
    url = "/groups/" + $scope.data.currentGroup.group_code + "/timetable.json"
    $http(
      method: "GET"
      url: url
    ).success((rdata, status, headers, config) ->
      entries = undefined
      entries = undefined
      entries = undefined
      $("#timetable").show()
      $scope.data.currentGroupCode = rdata.timetable.group_code
      entries = rdata.timetable.entries
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
        
        $scope.data.timetable.weekdays = rdata.timetable.weekdays
        $scope.data.timetable.batches = rdata.timetable.batches
        $scope.data.checked = true  if $scope.data.timetable.batches.length > 0
        $scope.data.timetable.entries = rdata.timetable.field_entries
        $scope.data.timeArray = entries
        $scope.XMPP.connection.pubsub.getNodeSubscriptions $scope.data.currentGroup.group_code, (iq) ->
          $(iq).find("subscription").each ->
            jid = undefined
            jid = undefined
            jid = undefined
            jid = $(this).attr("jid")
            jid = jid.substring(0, jid.indexOf("/"))
            console.log jid
            $scope.data.currentGroup.members.push jid


    ).error (data, status, headers, config) ->


  $scope.groupclick = (group) ->
    $scope.data.isVisible = true
    $scope.data.currentGroup = group
    $scope.data.currentGroup.members = []
    $scope.data.pagetitle = "Groups"
    $scope.get()

  $scope.backtofolders = ->
    console.log "backtofolders"
    $("#files_for_folders").hide()
    $("#folders").show()
    $("#foldername").hide()
    $("#backtofolders").hide()

  $scope.getGroupsFollowing = ->
    console.log $scope.folders
    console.log $scope.XMPP.connection.pubsub
    $scope.XMPP.connection.pubsub.getSubscriptions ((iq) ->
      console.log iq
      $(iq).find("subscription").each ->
        group = undefined
        node = undefined
        group = undefined
        node = undefined
        group = undefined
        node = undefined
        node = $(this).attr("node")
        console.log "getgroupsfollwoing"
        $scope.groupsfollowing.push node
        console.log $scope.groupsfollowing
        $scope.$digest()
        group = "<li id='" + node + "'>" + "" + "<a href=#detail>" + node + "</a></li>"
        $(document).on "click", "#" + node, ->
          $("#mygroupposts").show()
          $("#currentgroup").text node
          $("#myposts").hide()


    ), 0

  $scope.getGroupsCreated = ->
    $.get("/groups").done (data) ->
      group_code = undefined
      group_code = undefined
      group_code = undefined
      group_code = data.group_code
      console.log data

    $scope.data.groupscreated = data
    console.log $scope.data.groupscreated
    $scope.$digest()

  $scope.joinGroup = ->
    group = undefined
    group = undefined
    group = undefined
    group = $scope.joingroup
    console.log group
    $scope.XMPP.connection.pubsub.subscribe group, "", ((data) ->
    ), ((data) ->
      console.log "joined"
      $scope.groupsfollowing.push group
    ), ((data) ->
    ), true

  $scope.createGroup = (group) ->
    group_code = undefined
    group_code = undefined
    group_code = undefined
    group = $scope.data.creategroup
    console.log group
    group_code = ""
    $.post("/groups",
      group:
        name: group
    ).done (data) ->
      grouptoadd = undefined
      grouptoadd = undefined
      grouptoadd = undefined
      group_code = data.group_code
      console.log data
      $scope.XMPP.connection.pubsub.publish $scope.XMPP.connection.jid.split("/")[0] + "/groups", group_code, (data) ->
        console.log data

      $scope.XMPP.connection.pubsub.createNode group_code,
        "pubsub#notification_type": "normal"
      , ->

      grouptoadd =
        name: group
        group_code: group_code

      console.log grouptoadd
      console.log "node created"
      $scope.data.groupscreated.push grouptoadd
      $scope.$digest()


  $scope.createFolder = (group) ->
    group = $scope.data.creategroup
    console.log group
    $scope.XMPP.connection.pubsub.publish $scope.XMPP.connection.jid.split("/")[0] + "/groups", group, (data) ->
      console.log data

    $scope.XMPP.connection.pubsub.createNode group, "", ->

    console.log "node created"
    $scope.groupscreated.push group
    $.post "/groups",
      name: group


  $scope.publishgroupnote = ->
    currentgroup = undefined
    message = undefined
    note = undefined
    currentgroup = undefined
    message = undefined
    note = undefined
    currentgroup = undefined
    message = undefined
    note = undefined
    note = $scope.groupnoteform
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
    currentgroup = undefined
    message = undefined
    currentgroup = undefined
    message = undefined
    currentgroup = undefined
    message = undefined
    message = $scope.groupalertform
    currentgroup = $scope.data.currentGroup
    console.log currentgroup
    $scope.XMPP.connection.pubsub.publish currentgroup, message, (data) ->
      console.log data


  $scope.publishgroupassignment = ->
    message = undefined
    message = undefined
    message = undefined
    message = $scope.assignment
    console.log group
    $scope.XMPP.connection.pubsub.publish currentgroup, message, (data) ->
      console.log data

]