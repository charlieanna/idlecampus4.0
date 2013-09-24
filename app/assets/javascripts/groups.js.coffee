@GroupsCtrl = ($scope) ->
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

  $scope.groupclick = (group) ->
    $scope.currentGroup = group
    $("#mygroupposts").show()
    $("#myposts").hide()
    console.log $scope.folders
    $scope.folders = Group.query(
      name: group
      verb: "find_by_name"
    )
    console.log $scope.folders
    $scope.pagetitle = "Groups"

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
    $scope.XMPP.connection.pubsub.items $scope.XMPP.connection.jid.split("/")[0] + "/groups", (iq) ->
      $(iq).find("item").each ->
        node = undefined
        node = $(this).children("value").text()
        $("#groupfollowers").trigger "click", [node]
        $scope.groupscreated.push node
        console.log $scope.groupscreated



  $scope.joinGroup = ->
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
    g = undefined
    group = $scope.creategroup
    console.log group
    $scope.XMPP.connection.pubsub.publish $scope.XMPP.connection.jid.split("/")[0] + "/groups", group, (data) ->
      console.log data

    $scope.XMPP.connection.pubsub.createNode group, "", ->

    console.log "node created"
    $scope.groupscreated.push group
    g = new Group()
    g.$createGroup name: group

  $scope.createFolder = (group) ->
    group = $scope.creategroup
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
    note = $scope.groupnoteform
    message = $build("html",
      xmlns: "http://jabber.org/protocol/xhtml-im"
    ).c("a",
      href: note.toString()
    ).t(note)
    currentgroup = $scope.currentGroup
    console.log note + " " + currentgroup
    $scope.XMPP.connection.pubsub.publish currentgroup, note, (data) ->
      console.log data


  $scope.publishgroupalert = ->
    currentgroup = undefined
    message = undefined
    message = $scope.groupalertform
    currentgroup = $scope.currentGroup
    console.log currentgroup
    XMPP.connection.pubsub.publish currentgroup, message, (data) ->
      console.log data


  $scope.publishgroupassignment = ->
    message = undefined
    message = $scope.assignment
    console.log group
    XMPP.connection.pubsub.publish currentgroup, message, (data) ->
      console.log data


  $scope.publishgroupalert = ->
    message = undefined
    message = $scope.message
    console.log group
    XMPP.connection.pubsub.publish currentgroup, message, (data) ->
      console.log data


  $scope.user = ""