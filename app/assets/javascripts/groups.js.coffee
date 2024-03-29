@GroupsCtrl = ["$scope", "Group", "Data", "$http", ($scope, Group, Data, $http) ->
  $scope.data = Data
  $scope.pagetitle = "Latest Posts"
  $scope.groupscreated = []
  $scope.groupsfollowing = []
  $scope.folders = []
  $scope.groupMessages = []
  
  $scope.$watch "groupscreated", (newValue, oldValue) ->
    # console.log "watch"
 #    console.log newValue

  $scope.$watch "currentGroup", (newValue, oldValue) ->
    # console.log "currentGroup"
 #    console.log newValue

  $scope.$watch "folders", (newValue, oldValue) ->
    # console.log "folders"
#     console.log newValue

  $scope.$watch "groupMessages", (newValue, oldValue) ->
    # console.log "groupMessages"
#     console.log newValue

  $scope.get = ->
    
    $scope.data.checked = false
    url = "/groups/" + $("#groupcode").text() + "/timetable.json"
    $http(
      method: "GET"
      url: url
    ).success((rdata, status, headers, config) ->
      
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
        $scope.XMPP.connection.pubsub.getNodeSubscriptions $("#groupcode").text(), (iq) ->
          $(iq).find("subscription").each ->
           
            jid = $(this).attr("jid")
            jid = jid.substring(0, jid.indexOf("/"))
            console.log jid
            # $scope.data.currentGroup.members.push jid


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
      
      group_code = data.group_code
      console.log data

      $scope.data.groupscreated = data
    console.log $scope.data.groupscreated
    # $scope.$digest()

  $scope.joinGroup = ->
   
    group = $scope.joingroup
    console.log group
    $scope.XMPP.connection.pubsub.subscribe group, "", ((data) ->
    ), ((data) ->
      console.log "joined"
      $scope.groupsfollowing.push group
    ), ((data) ->
    ), true

  $scope.createGroup = () ->
    
    group = $scope.new_group
    console.log group
    group_code = ""
    $.post("/groups",
      group:
        name: group
    ).done (data) ->
      group_code= data.substring(data.length-9,data.length-3);
      $scope.XMPP.connection.pubsub.createNode group_code,
        "pubsub#notification_type": "normal"
      , ->
      
      # $scope.XMPP.connection.pubsub.subscribe group_code, "", ((data) ->
#       ), ((data) ->
#         console.log "joined"
#         $scope.groupsfollowing.push group
#       ), ((data) ->
#       ), true

      # grouptoadd =
#         name: group
#         group_code: group_code
# 
#       console.log grouptoadd
      console.log "node created" if gon.global.debug
      # $scope.data.groupscreated.push grouptoadd
#       $scope.$digest()


  $scope.createFolder = (group) ->
    group = $scope.data.creategroup
    console.log group
    $scope.XMPP.connection.pubsub.publish $scope.XMPP.connection.jid.split("/")[0] + "/groups", group, (data) ->
      console.log data

    $scope.XMPP.connection.pubsub.createNode group, "", ->

    console.log "node created" if gon.global.debug
    $scope.groupscreated.push group
    $.post "/groups",
      name: group


  $scope.publishgroupnote = ->
    
    $("#message").hide()
    group = $("#note_group").val()
    formData = new FormData()
    $input = $("#note_file")
    message = $("#note_message").val()
    if message == ""
      alert("Enter the note..")
    else
      $("#note_file_button").button('loading')
      formData.append "note[file]", $input[0].files[0]
      formData.append "note_text", message 
      formData.append "group", group
      # $scope.XMPP.connection.pubsub.publish $("#note_group_code").val(), $("#note_message").val(), (data) ->
  #       console.log data
      $scope.XMPP.connection.pubsub.getNodeSubscriptions group, (iq) ->
        members = []
        $(iq).find("subscription").each ->
        
          jid = $(this).attr("jid")
          jid = jid.substring(0, jid.indexOf("/")) if jid.indexOf("/") != -1
          console.log jid if gon.global.debug
          members.push jid
        formData.append("members", members);
        $.ajax(
          url: "/notes"
          data: formData
          cache: false
          contentType: false
          processData: false
          method: 'POST'
        ).done ->
          $("#note_message").val("")
          $("#note_file_button").button('reset')
          $("#message").show()
          $("a, button").toggleClass "active"
          


    
    
      
    


  $scope.publishgroupalert = ->
    $("abbr.timeago").timeago();
    group = $("#alert_group").val()
    message = $("#alert_message").val()
    if message == ""
      alert("Enter the alert..")
    else
      $scope.XMPP.connection.pubsub.publish group , message, (data) ->
        console.log data if gon.global.debug
   
      $.post("/alerts",
        alert:
          message: message
          group: group 
      ).done (data) ->
        $("#createalertinput").val("")
        $("#alert_message").val("")
   


  $scope.publishgroupassignment = ->
    $("abbr.timeago").timeago();
   
    message = $scope.assignment
    console.log group
    $scope.XMPP.connection.pubsub.publish currentgroup, message, (data) ->
      console.log data

]