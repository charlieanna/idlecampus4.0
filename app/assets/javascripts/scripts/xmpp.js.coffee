app = angular.module("idlecampus", ['ngResource','$strap.directives'])
#
#
#re = /\S+@\S+\.\S+/
## available
#app.directive "integer1",($http) ->
#  require: "ngModel"
#  link: (scope, elm, attrs, ctrl) ->
#    ctrl.$parsers.unshift (viewValue) ->
#      if viewValue and re.test(viewValue)
#        $http(
#          method: "GET"
#          url: "/users/checkEmail"
#          params:{email:viewValue}
#        ).success((data, status, headers, config) ->
#          console.log data
#          if  parseInt(data) == 0
#            $("#emailicon").attr('class','icon-check')
#            ctrl.$setValidity "integer1", true
#            viewValue
#          if  parseInt(data) > 0
#            $("#emailicon").attr('class','icon-remove')
#            ctrl.$setValidity "integer1", false
#            viewValue
#
#        ).error (data, status, headers, config) ->
#          console.log "error"
#
#          ctrl.$setValidity "integer1", false
#          `undefined`
#
#        # it is valid
#        ctrl.$setValidity "integer1", true
#        viewValue
##      else
##
##        # it is invalid, return undefined (no model update)
##        ctrl.$setValidity "integer", false
##        `undefined`
#
#
#re = /\S+@\S+\.\S+/
## available
##app.directive "emailavailable", ($http) ->
##  require: "ngModel"
##  link: (scope, elem, attr, ctrl,ngModel) ->
##    ctrl.$parsers.unshift (viewValue) ->
##      console.log viewValue
##      if viewValue and re.test(viewValue)
##        console.log "variable is defined"
##        $http(
##          method: "GET"
##          url: "/users/checkEmail"
##          params:{email:viewValue}
##        ).success((data, status, headers, config) ->
##          console.log data
##          if  parseInt(data) == 0
##            $("#emailicon").attr('class','icon-check')
##            ctrl.$setValidity "emailavailable", true
##            viewValue
##          if  parseInt(data) > 0
##            $("#emailicon").attr('class','icon-remove')
##            ctrl.$setValidity "emailavailable", false
##            #               ngModel.$setValidity('somethingIsBad', false);
##            viewValue
##
##        ).error (data, status, headers, config) ->
##          console.log "error"
##          $("#emailicon").attr('class','icon-remove')
##          ctrl.$setValidity "emailavailable", false
##          `undefined`
##
##
##      else
##        console.log "hi"
##        ctrl.$setValidity "emailavailable", false
##        $("#emailicon").attr('class','icon-remove')
#
#
#
#
#
#app.directive "integer",($http) ->
#  require: "ngModel"
#  link: (scope, elm, attrs, ctrl) ->
#    ctrl.$parsers.unshift (viewValue) ->
##      if (viewValue).length > 0
#      $http(
#        method: "GET"
#        url: "/users/checkName"
#        params:{name:viewValue}
#      ).success((data, status, headers, config) ->
#        console.log data
#        if  parseInt(data) == 0
#          $("#nameicon").attr('class','icon-check')
#          ctrl.$setValidity "integer", true
#          viewValue
#        if  parseInt(data) > 0
#          $("#nameicon").attr('class','icon-remove')
#          ctrl.$setValidity "integer", false
#          viewValue
#
#      ).error (data, status, headers, config) ->
#        console.log "error"
#
#        ctrl.$setValidity "integer", false
#        `undefined`
#
#      # it is valid
#      ctrl.$setValidity "integer", true
#      viewValue
##      else
##
##        # it is invalid, return undefined (no model update)
##        ctrl.$setValidity "integer", false
##        `undefined`
#
#
#
#
#
#
#
#
#app.directive "passworddir", ->
#  require: "ngModel"
#  link: (scope, elm, attrs, ctrl) ->
#    ctrl.$parsers.unshift (viewValue) ->
#      console.log viewValue
#      if viewValue.length >5
#        $("#passwordicon").attr('class','icon-check')
#        # it is valid
#        ctrl.$setValidity "passworddir", true
#        viewValue
#      else
#
## it is invalid, return undefined (no model update)
#        $("#passwordicon").attr('class','icon-remove')
#        ctrl.$setValidity "passworddir", false
#
#
#
#
#
#
#
#
#
#
#
#
#














@xmpp = ($scope) ->

  $scope.$watch "spin", (newValue, oldValue) ->
   console.log "spin"
   console.log newValue

  $scope.changeEmail = ->

    console.log $scope.email
    $.ajax
      type: "GET"
      url: "/users/checkEmail"
      data:
        email:$scope.email

      success: (data) ->
        console.log  parseInt data


        $("#emailicon").attr('class','icon-check') if  parseInt(data) == 0
        $("#emailicon").attr('class','icon-remove') if  parseInt(data) > 0
        console.log $("#emailicon")



      dataType: ""

  $scope.changeName = ->
    console.log "name"
    console.log $scope.user
    $.ajax
      type: "GET"
      url: "/users/checkName"
      data:
        name:$scope.user


      success: (data) ->
        $("#nameicon").attr('class','icon-check')  if  parseInt(data) == 0
        $("#nameicon").attr('class','icon-remove') if  parseInt(data) > 0

      dataType: ""


#
#
#
#
#

  $scope.connected = ->
#    $.get("http://idlecampus.com/timetable/cbj",
#      jabber_id: $scope.XMPP.connection.jid.split("/")[0]
#    ).done (data) ->
#      console.log data
#      window.college = data.jabber_id.college
#      window.batch = data.jabber_id.batch


    $scope.XMPP.connection.pubsub.createNode $scope.XMPP.connection.jid.split("/")[0] + "/groups", "", (data) ->
      console.log data

    iq = $iq(type: "get").c("query",
      xmlns: "jabber:iq:roster"
    )
    $scope.XMPP.connection.sendIQ iq, $scope.XMPP.on_roster
    $scope.XMPP.connection.addHandler $scope.XMPP.on_roster_changed, "jabber:iq:roster", "iq", "set"
    $scope.XMPP.connection.addHandler $scope.XMPP.on_message, null, "message", "chat"
    $scope.XMPP.connection.addHandler $scope.XMPP.on_message, null, "message", "headline"

  # $('#groupsbutton').trigger('click');

#
  $scope.spin = ""
  $scope.disconnected = ->
    XMPP.connection = null
    XMPP.pending_subscriber = null
    $("#roster-area ul").empty()
    $("#chat-area ul").empty()
    $("#chat-area div").remove()
    $("#login_dialog").dialog "open"

  $scope.XMPP =
    NS_DATA_FORMS: "jabber:x:data"
    NS_PUBSUB: "http://jabber.org/protocol/pubsub"
    NS_PUBSUB_OWNER: "http://jabber.org/protocol/pubsub#owner"
    NS_PUBSUB_ERRORS: "http://jabber.org/protocol/pubsub#errors"
    NS_PUBSUB_NODE_CONFIG: "http://jabber.org/protocol/pubsub#node_config"
    connection: null
    start_time: null
    jid_to_id: (jid) ->
      Strophe.getBareJidFromJid(jid).replace(/@/g, "-").replace /\./g, "-"
#
    on_roster: (iq) ->
      $(iq).find("item").each ->
        jid = $(this).attr("jid")
        name = $(this).attr("name") or jid

        # transform jid into an id
        jid_id = $scope.XMPP.jid_to_id(jid)
        contact = $("<li id='" + jid_id + "'>" + "<div class='roster-contact offline'>" + "<a href=#chat><img class='ui-li-icon  ui-li-thumb' alt='' src=''><div class='roster-name'>" + name + "</div><div class='roster-jid'>" + jid + "</div></a></div></li>")
        $scope.XMPP.insert_contact contact


      # set up presence handler and send initial presence
      $scope.XMPP.connection.addHandler $scope.XMPP.on_presence, null, "presence"
      $scope.XMPP.connection.send $pres()


  # $.mobile.changePage("#home", {
  #     transition: "slideup"
  # });

  #$.mobile.changePage( "#chat", { transition: "slideup"} );
    pending_subscriber: null
    on_presence: (presence) ->
      ptype = $(presence).attr("type")
      from = $(presence).attr("from")
      jid_id = $scope.XMPP.jid_to_id(from)
      if ptype is "subscribe"

        # populate pending_subscriber, the approve-jid span, and
        # open the dialog
        $scope.XMPP.pending_subscriber = from
        $("#approve-jid").text Strophe.getBareJidFromJid(from)
        $.mobile.changePage "#approve_dialog",
          transition: "slideup"

      else if ptype isnt "error"
        contact = $("li#" + jid_id + " .roster-contact").removeClass("online").removeClass("away").removeClass("offline")
        if ptype is "unavailable"
          contact.addClass "offline"
        else
          show = $(presence).find("show").text()
          console.log "show " + show
          if show is "" or show is "chat"
            contact.addClass "online"
            $("li#" + jid_id + " a img").attr "src", "green.jpg"
          else
            contact.addClass "away"
            $("li#" + jid_id + " a img").attr "src", "red.png"
        li = contact.parent().parent().parent()
        li.remove()
        $scope.XMPP.insert_contact li

      # reset addressing for user since their presence changed
      jid_id = $scope.XMPP.jid_to_id(from)
      $("#chat-" + jid_id).data "jid", Strophe.getBareJidFromJid(from)
      true
#
    on_roster_changed: (iq) ->
      console.log "roster changed"
      $(iq).find("item").each ->
        sub = $(this).attr("subscription")
        jid = $(this).attr("jid")
        name = $(this).attr("name") or jid
        jid_id = $scope.XMPP.jid_to_id(jid)
        if sub is "remove"

          # contact is being removed
          $("#" + jid_id).remove()
        else

          # contact is being added or modified
          contact = $("<li id='" + jid_id + "'>" + "<div class=" + ($("#" + jid_id).attr("class") or "roster-contact offline") + ">" + "<a href=#chat><img class='ui-li-icon  ui-li-thumb' alt='' src=''><div class='roster-name'>" + name + "</div><div class='roster-jid'>" + jid + "</div></a></div></li>")
          if $("#" + jid_id).length > 0
            console.log 2
            $("#" + jid_id).replaceWith contact
          else
            console.log "1"
            $scope.XMPP.insert_contact contact

      true

    on_message: (message) ->
      console.log message
      type = $(message).attr("type")
      console.log type
      if type is "chat"
        body = $(message).children("body").text()
        from = ""
        console.log body
        messagetodisplay = from + " : " + body
        mess = "<li style='background-color:#ECEFF5; list-style:none;border:1px solid black;margin:5px'>" + messagetodisplay + "</li>"
        $("ul#posts").append $(mess)
      else if type = "headline"
        if $(message).find("value").text()
          body = $(message).find("value").text()
          from = $(message).find("items").attr("node")
          $scope.data.user = from
          console.log body
          messagetodisplay = body

          $scope.data.groupMessages.push messagetodisplay
          $scope.$digest();

      true


    scroll_chat: (jid_id) ->
      div = $("#chat-" + jid_id + " .chat-messages").get(0)
      div.scrollTop = div.scrollHeight
#
    presence_value: (elem) ->
      if elem.hasClass("online")
       return 2
      else return 1  if elem.hasClass("away")
      0
#
    insert_contact: (elem) ->
      jid = elem.find(".roster-jid").text()
      pres = $scope.XMPP.presence_value(elem.find(".roster-contact"))
      contacts = $("ul#myfriends li")
      if contacts.length > 0
        inserted = false
        contacts.each ->
          cmp_pres = $scope.XMPP.presence_value($(this).find(".roster-contact"))
          cmp_jid = $(this).find(".roster-jid").text()
          if pres > cmp_pres
            $(this).before elem
            inserted = true
            false
          else if pres is cmp_pres
            if jid < cmp_jid
              $(this).before elem
              inserted = true
              false

        $("ul#myfriends").append elem  unless inserted
      else
        $("ul#myfriends").append elem
#
    callback: (status) ->
      alert connection
      if status is Strophe.Status.REGISTER
        alert 10
        alert connection
        connection.register.fields.username = "juliet"
        alert "100"
        connection.register.fields.password = "R0m30"
        lert "100"
        alert "before"
        connection.register.submit()
        alert "after"
      else if status is Strophe.Status.REGISTERED
        alert 101
        console.log "registered!"
        connection.authenticate()
      else if status is Strophe.Status.CONNECTED
        alert 102
        console.log "logged in!"
      else
        alert "con"
        alert "con" + connection
#
#
  $scope.getNodeSubscriptions = (group) ->
    $scope.XMPP.connection.pubsub.getNodeSubscriptions group,(data) ->
      console.log "Subscribers"
      console.log data
#
#
#
  $scope.register = () ->


    form = $scope.signupform

    if(form.$valid)
      $scope.spin = "icon-spinner icon-spin icon-large"
      email = $scope.signupform.uEmail.$viewValue
      user = $scope.signupform.size.$viewValue
      password = $scope.signupform.uPassword.$viewValue
      console.log email

      callback = undefined
      connection = undefined
      console.log "" + user + " " + password + " " + email
      connection = new Strophe.Connection("http://idlecampus.com/http-bind")
      console.log connection
      callback = (status) ->
        console.log status
        if status is Strophe.Status.REGISTER
          connection.register.fields.username = user
          connection.register.fields.password = password
          connection.register.submit()
        else if status is Strophe.Status.REGISTERED
          alert "registered!"

#          $scope.signupform.$setPristine();
          $scope.$apply  ->
            $scope.spin = ''



          $('#signup-form').dialog('close')
          $.post("/users",
            email:email
            jabber_id: user + "@idlecampus.com"
            device_identifier: "web"
            password:password).done ->
		  
          connection.authenticate()
		  
#          $scope.signupform.$setPristine()
          $scope.$digest();
        else if status is Strophe.Status.CONNECTED
          console.log "logged in!"
        else

      console.log connection.register
      connection.register.connect "idlecampus.com", callback, 60, 1
      $scope.XMPP.connection = connection
#
# 
  $scope.connect = (user,password) ->
    connection = new Strophe.Connection("http://idlecampus.com/http-bind")
    connection.connect user, password, (status) ->
     

    connection.xmlInput = (body) ->
      console.log body

    connection.xmlOutput = (body) ->
      console.log "XMPP OUTPUT"
      console.log body
      localStorage.setItem "rid", $(body).attr("rid")
      localStorage.setItem "sid", $(body).attr("sid") 
    $scope.XMPP.connection = connection

  $scope.register1 = ->
    form = $scope.signupform
    connection = new Strophe.Connection("http://idlecampus.com/http-bind")
    sid = localStorage.getItem("sid")
    rid = localStorage.getItem("rid")
    jid = $("#currentuser").text()
    console.log "CREDENTIALS"
    if gon? and gon.register?
      user = gon.register.name
      email = gon.register.email
      password = gon.register.password
    if gon? and gon.attacher?
      sid = gon.attacher.SID
      rid = gon.attacher.RID
      jid = gon.regiattacherster.JID
    console.log(sid)
    console.log(rid)
    console.log(jid)
    console.log connection
    callback = (status) ->
      console.log status
      if status is Strophe.Status.REGISTER
        connection.register.fields.username = user
        connection.register.fields.password = password
        connection.register.submit()
      else if status is Strophe.Status.REGISTERED
        
#        connection.authenticate()
        localStorage.set("JID",user+"@idlecampus.com")
        $scope.connect(user+"@idlecampus.com",password)
        $scope.$digest()
      else if status is Strophe.Status.CONNECTED
        console.log "logged in!"
      else

    if jid is not "" and sid is not "" and rid is not ""

      conn.attach jid, sid, rid, (status) ->
        console.log status
        if status is Strophe.Status.CONNECTED or status is Strophe.Status.ATTACHED
          $scope.XMPP.connection = conn
          $scope.XMPP.connection.jid = jid
          console.log "attached"
          $scope.connected()
        else
          $(document).trigger "disconnected"  if status is Strophe.Status.DISCONNECTED
      
     
    
    
    console.log connection.register
    connection.register.connect "idlecampus.com", callback, 60, 1
    $scope.XMPP.connection = connection
	  
	  
  $scope.attach = ->

    conn = new Strophe.Connection("http://idlecampus.com/http-bind")
    console.log conn
    conn.xmlInput = (body) ->
      console.log body

    conn.xmlOutput = (body) ->
      console.log "XMPP OUTPUT"
      console.log body
      localStorage.setItem "rid", $(body).attr("rid")
      localStorage.setItem "sid", $(body).attr("sid")

    sid = localStorage.getItem("sid")
    rid = localStorage.getItem("rid")
    jid = $("#currentuser").text()

    console.log "CREDENTIALS"
    console.log(sid)
    console.log(rid)
    console.log(jid)
    if gon?
      sid = gon.attacher.SID
      rid = gon.attacher.RID
      jid = gon.attacher.JID
    conn.attach jid, sid, rid, (status) ->
      console.log status
      if status is Strophe.Status.CONNECTED or status is Strophe.Status.ATTACHED
        $scope.XMPP.connection = conn
        $scope.XMPP.connection.jid = jid
        console.log "attached"
        $scope.connected()
      else
        $(document).trigger "disconnected"  if status is Strophe.Status.DISCONNECTED


$ ->
  $("#signout").click (event) ->
    $scope.XMPP.connection.disconnect();
    localStorage.clear();