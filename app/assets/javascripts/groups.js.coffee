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
    url = "/groups/" + $scope.data.currentGroup.group_code + "/timetable.json"
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
        $scope.XMPP.connection.pubsub.getNodeSubscriptions $scope.data.currentGroup.group_code, (iq) ->
          $(iq).find("subscription").each ->
           
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
      group_code= data.substring(data.length-8,data.length-2);
      $scope.XMPP.connection.pubsub.createNode group_code,
        "pubsub#notification_type": "normal"
      , ->

      # grouptoadd =
#         name: group
#         group_code: group_code
# 
#       console.log grouptoadd
      console.log "node created"
      # $scope.data.groupscreated.push grouptoadd
#       $scope.$digest()


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
    $("#message").hide()
    $("#note_file_button").text "Sending..."
    formData = new FormData()
    $input = $("#note_file")
    formData.append "note[file]", $input[0].files[0]
    formData.append "note_text", $("#note_message").val()
    
    $scope.XMPP.connection.pubsub.publish $("#note_group_code").val(), $("#note_message").val(), (data) ->
      console.log data
    $scope.XMPP.connection.pubsub.getNodeSubscriptions $("#note_group_code").val(), (iq) ->
      members = []
      $(iq).find("subscription").each ->
        
        jid = $(this).attr("jid")
        # jid = jid.substring(0, jid.indexOf("/"))
        console.log jid
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
        $("#message").show()
        $("a, button").toggleClass "active"
        $("#note_file_button").text "Send"


    
    
      
    console.log("ajax")


  $scope.publishgroupalert = ->
    $scope.XMPP.connection.pubsub.publish $("#note_group_code").val(), $("#createalertinput").val(), (data) ->
      console.log data
   
    $.post("/alerts",
      alert:
        message: $("#createalertinput").val()
        group: $("#note_group_code").val()
    ).done (data) ->
		
   


  $scope.publishgroupassignment = ->
   
    message = $scope.assignment
    console.log group
    $scope.XMPP.connection.pubsub.publish currentgroup, message, (data) ->
      console.log data

]