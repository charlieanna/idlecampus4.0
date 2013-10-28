# problem is if i open another chat then the msgs go there instead of coming to me.
# console.log gon.names
app = angular.module("idlecampus", ['ngResource','$strap.directives'])
re = /\S+@\S+\.\S+/
# available

app.factory "Data", ->
 
 
   
  currentGroup : ""
  pagetitle: "Latest Posts"
  groupscreated: []
  groupsfollowing: []
  folders: []
  groupMessages: []
  user: ""
  isVisible: false
  entries: []
  teacher: []
  subjects:[]
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







  





 