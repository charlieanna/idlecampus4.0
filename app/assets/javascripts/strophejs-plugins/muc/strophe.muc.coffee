#
# *Plugin to implement the MUC extension.
#   http://xmpp.org/extensions/xep-0045.html
# *Previous Author:
#    Nathan Zorn <nathan.zorn@gmail.com>
# *Complete CoffeeScript rewrite:
#    Andreas Guth <guth@dbis.rwth-aachen.de>
#
Occupant = undefined
RoomConfig = undefined
XmppRoom = undefined
__bind_ = (fn, me) ->
  ->
    fn.apply me, arguments_

Strophe.addConnectionPlugin "muc",
  _connection: null
  rooms: []
  
  #Function
  #  Initialize the MUC plugin. Sets the correct connection object and
  #  extends the namesace.
  #  
  init: (conn) ->
    @_connection = conn
    @_muc_handler = null
    Strophe.addNamespace "MUC_OWNER", Strophe.NS.MUC + "#owner"
    Strophe.addNamespace "MUC_ADMIN", Strophe.NS.MUC + "#admin"
    Strophe.addNamespace "MUC_USER", Strophe.NS.MUC + "#user"
    Strophe.addNamespace "MUC_ROOMCONF", Strophe.NS.MUC + "#roomconfig"

  
  #Function
  #  Join a multi-user chat room
  #  Parameters:
  #  (String) room - The multi-user chat room to join.
  #  (String) nick - The nickname to use in the chat room. Optional
  #  (Function) msg_handler_cb - The function call to handle messages from the
  #  specified chat room.
  #  (Function) pres_handler_cb - The function call back to handle presence
  #  in the chat room.
  #  (String) password - The optional password to use. (password protected
  #  rooms only)
  #  
  join: (room, nick, msg_handler_cb, pres_handler_cb, roster_cb, password, history_attrs) ->
    msg = undefined
    room_nick = undefined
    _base = undefined
    _ref = undefined
    _ref1 = undefined
    _this = this
    room_nick = @test_append_nick(room, nick)
    msg = $pres(
      from: @_connection.jid
      to: room_nick
    ).c("x",
      xmlns: Strophe.NS.MUC
    )
    msg = msg.c("history", history_attrs)  if history_attrs?
    msg.cnode Strophe.xmlElement("password", [], password)  if password?
    unless (_ref = @_muc_handler)?
      @_muc_handler = @_connection.addHandler((stanza) ->
        from = undefined
        handler = undefined
        handlers = undefined
        id = undefined
        roomname = undefined
        x = undefined
        xmlns = undefined
        xquery = undefined
        _i = undefined
        _len = undefined
        from = stanza.getAttribute("from")
        return true  unless from
        roomname = from.split("/")[0]
        return true  unless _this.rooms[roomname]
        room = _this.rooms[roomname]
        handlers = {}
        if stanza.nodeName is "message"
          handlers = room._message_handlers
        else if stanza.nodeName is "presence"
          xquery = stanza.getElementsByTagName("x")
          if xquery.length > 0
            _i = 0
            _len = xquery.length

            while _i < _len
              x = xquery[_i]
              xmlns = x.getAttribute("xmlns")
              if xmlns and xmlns.match(Strophe.NS.MUC)
                handlers = room._presence_handlers
                break
              _i++
        for id of handlers
          handler = handlers[id]
          delete handlers[id]  unless handler(stanza, room)
        true
      )
    _base[room] = new XmppRoom(this, room, nick, password)  unless (_ref1 = (_base = @rooms)[room])?
    @rooms[room].addHandler "presence", pres_handler_cb  if pres_handler_cb
    @rooms[room].addHandler "message", msg_handler_cb  if msg_handler_cb
    @rooms[room].addHandler "roster", roster_cb  if roster_cb
    @_connection.send msg

  
  #Function
  #  Leave a multi-user chat room
  #  Parameters:
  #  (String) room - The multi-user chat room to leave.
  #  (String) nick - The nick name used in the room.
  #  (Function) handler_cb - Optional function to handle the successful leave.
  #  (String) exit_msg - optional exit message.
  #  Returns:
  #  iqid - The unique id for the room leave.
  #  
  leave: (room, nick, handler_cb, exit_msg) ->
    presence = undefined
    presenceid = undefined
    room_nick = undefined
    delete @rooms[room]

    if @rooms.length is 0
      @_connection.deleteHandler @_muc_handler
      @_muc_handler = null
    room_nick = @test_append_nick(room, nick)
    presenceid = @_connection.getUniqueId()
    presence = $pres(
      type: "unavailable"
      id: presenceid
      from: @_connection.jid
      to: room_nick
    )
    presence.c "status", exit_msg  if exit_msg?
    @_connection.addHandler handler_cb, null, "presence", null, presenceid  if handler_cb?
    @_connection.send presence
    presenceid

  
  #Function
  #  Parameters:
  #  (String) room - The multi-user chat room name.
  #  (String) nick - The nick name used in the chat room.
  #  (String) message - The plaintext message to send to the room.
  #  (String) html_message - The message to send to the room with html markup.
  #  (String) type - "groupchat" for group chat messages o
  #                  "chat" for private chat messages
  #  Returns:
  #  msgiq - the unique id used to send the message
  #  
  message: (room, nick, message, html_message, type) ->
    msg = undefined
    msgid = undefined
    parent = undefined
    room_nick = undefined
    room_nick = @test_append_nick(room, nick)
    type = type or ((if nick? then "chat" else "groupchat"))
    msgid = @_connection.getUniqueId()
    msg = $msg(
      to: room_nick
      from: @_connection.jid
      type: type
      id: msgid
    ).c("body",
      xmlns: Strophe.NS.CLIENT
    ).t(message)
    msg.up()
    if html_message?
      msg.c("html",
        xmlns: Strophe.NS.XHTML_IM
      ).c("body",
        xmlns: Strophe.NS.XHTML
      ).t html_message
      if msg.node.childNodes.length is 0
        parent = msg.node.parentNode
        msg.up().up()
        msg.node.removeChild parent
      else
        msg.up().up()
    msg.c("x",
      xmlns: "jabber:x:event"
    ).c "composing"
    @_connection.send msg
    msgid

  
  #Function
  #  Convenience Function to send a Message to all Occupants
  #  Parameters:
  #  (String) room - The multi-user chat room name.
  #  (String) message - The plaintext message to send to the room.
  #  (String) html_message - The message to send to the room with html markup.
  #  Returns:
  #  msgiq - the unique id used to send the message
  #  
  groupchat: (room, message, html_message) ->
    @message room, null, message, html_message

  
  #Function
  #  Send a mediated invitation.
  #  Parameters:
  #  (String) room - The multi-user chat room name.
  #  (String) receiver - The invitation's receiver.
  #  (String) reason - Optional reason for joining the room.
  #  Returns:
  #  msgiq - the unique id used to send the invitation
  #  
  invite: (room, receiver, reason) ->
    invitation = undefined
    msgid = undefined
    msgid = @_connection.getUniqueId()
    invitation = $msg(
      from: @_connection.jid
      to: room
      id: msgid
    ).c("x",
      xmlns: Strophe.NS.MUC_USER
    ).c("invite",
      to: receiver
    )
    invitation.c "reason", reason  if reason?
    @_connection.send invitation
    msgid

  
  #Function
  #  Send a direct invitation.
  #  Parameters:
  #  (String) room - The multi-user chat room name.
  #  (String) receiver - The invitation's receiver.
  #  (String) reason - Optional reason for joining the room.
  #  (String) password - Optional password for the room.
  #  Returns:
  #  msgiq - the unique id used to send the invitation
  #  
  directInvite: (room, receiver, reason, password) ->
    attrs = undefined
    invitation = undefined
    msgid = undefined
    msgid = @_connection.getUniqueId()
    attrs =
      xmlns: "jabber:x:conference"
      jid: room

    attrs.reason = reason  if reason?
    attrs.password = password  if password?
    invitation = $msg(
      from: @_connection.jid
      to: receiver
      id: msgid
    ).c("x", attrs)
    @_connection.send invitation
    msgid

  
  #Function
  #  Queries a room for a list of occupants
  #  (String) room - The multi-user chat room name.
  #  (Function) success_cb - Optional function to handle the info.
  #  (Function) error_cb - Optional function to handle an error.
  #  Returns:
  #  id - the unique id used to send the info request
  #  
  queryOccupants: (room, success_cb, error_cb) ->
    attrs = undefined
    info = undefined
    attrs = xmlns: Strophe.NS.DISCO_ITEMS
    info = $iq(
      from: @_connection.jid
      to: room
      type: "get"
    ).c("query", attrs)
    @_connection.sendIQ info, success_cb, error_cb

  
  #Function
  #  Start a room configuration.
  #  Parameters:
  #  (String) room - The multi-user chat room name.
  #  (Function) handler_cb - Optional function to handle the config form.
  #  Returns:
  #  id - the unique id used to send the configuration request
  #  
  configure: (room, handler_cb, error_cb) ->
    config = undefined
    stanza = undefined
    config = $iq(
      to: room
      type: "get"
    ).c("query",
      xmlns: Strophe.NS.MUC_OWNER
    )
    stanza = config.tree()
    @_connection.sendIQ stanza, handler_cb, error_cb

  
  #Function
  #  Cancel the room configuration
  #  Parameters:
  #  (String) room - The multi-user chat room name.
  #  Returns:
  #  id - the unique id used to cancel the configuration.
  #  
  cancelConfigure: (room) ->
    config = undefined
    stanza = undefined
    config = $iq(
      to: room
      type: "set"
    ).c("query",
      xmlns: Strophe.NS.MUC_OWNER
    ).c("x",
      xmlns: "jabber:x:data"
      type: "cancel"
    )
    stanza = config.tree()
    @_connection.sendIQ stanza

  
  #Function
  #  Save a room configuration.
  #  Parameters:
  #  (String) room - The multi-user chat room name.
  #  (Array) config- Form Object or an array of form elements used to configure the room.
  #  Returns:
  #  id - the unique id used to save the configuration.
  #  
  saveConfiguration: (room, config, success_cb, error_cb) ->
    conf = undefined
    iq = undefined
    stanza = undefined
    _i = undefined
    _len = undefined
    iq = $iq(
      to: room
      type: "set"
    ).c("query",
      xmlns: Strophe.NS.MUC_OWNER
    )
    if config instanceof Form
      config.type = "submit"
      iq.cnode config.toXML()
    else
      iq.c "x",
        xmlns: "jabber:x:data"
        type: "submit"

      _i = 0
      _len = config.length

      while _i < _len
        conf = config[_i]
        iq.cnode(conf).up()
        _i++
    stanza = iq.tree()
    @_connection.sendIQ stanza, success_cb, error_cb

  
  #Function
  #  Parameters:
  #  (String) room - The multi-user chat room name.
  #  Returns:
  #  id - the unique id used to create the chat room.
  #  
  createInstantRoom: (room, success_cb, error_cb) ->
    roomiq = undefined
    roomiq = $iq(
      to: room
      type: "set"
    ).c("query",
      xmlns: Strophe.NS.MUC_OWNER
    ).c("x",
      xmlns: "jabber:x:data"
      type: "submit"
    )
    @_connection.sendIQ roomiq.tree(), success_cb, error_cb

  
  #Function
  #  Set the topic of the chat room.
  #  Parameters:
  #  (String) room - The multi-user chat room name.
  #  (String) topic - Topic message.
  #  
  setTopic: (room, topic) ->
    msg = undefined
    msg = $msg(
      to: room
      from: @_connection.jid
      type: "groupchat"
    ).c("subject",
      xmlns: "jabber:client"
    ).t(topic)
    @_connection.send msg.tree()

  
  #Function
  #  Internal Function that Changes the role or affiliation of a member
  #  of a MUC room. This function is used by modifyRole and modifyAffiliation.
  #  The modification can only be done by a room moderator. An error will be
  #  returned if the user doesn't have permission.
  #  Parameters:
  #  (String) room - The multi-user chat room name.
  #  (Object) item - Object with nick and role or jid and affiliation attribute
  #  (String) reason - Optional reason for the change.
  #  (Function) handler_cb - Optional callback for success
  #  (Function) error_cb - Optional callback for error
  #  Returns:
  #  iq - the id of the mode change request.
  #  
  _modifyPrivilege: (room, item, reason, handler_cb, error_cb) ->
    iq = undefined
    iq = $iq(
      to: room
      type: "set"
    ).c("query",
      xmlns: Strophe.NS.MUC_ADMIN
    ).cnode(item.node)
    iq.c "reason", reason  if reason?
    @_connection.sendIQ iq.tree(), handler_cb, error_cb

  
  #Function
  #  Changes the role of a member of a MUC room.
  #  The modification can only be done by a room moderator. An error will be
  #  returned if the user doesn't have permission.
  #  Parameters:
  #  (String) room - The multi-user chat room name.
  #  (String) nick - The nick name of the user to modify.
  #  (String) role - The new role of the user.
  #  (String) affiliation - The new affiliation of the user.
  #  (String) reason - Optional reason for the change.
  #  (Function) handler_cb - Optional callback for success
  #  (Function) error_cb - Optional callback for error
  #  Returns:
  #  iq - the id of the mode change request.
  #  
  modifyRole: (room, nick, role, reason, handler_cb, error_cb) ->
    item = undefined
    item = $build("item",
      nick: nick
      role: role
    )
    @_modifyPrivilege room, item, reason, handler_cb, error_cb

  kick: (room, nick, reason, handler_cb, error_cb) ->
    @modifyRole room, nick, "none", reason, handler_cb, error_cb

  voice: (room, nick, reason, handler_cb, error_cb) ->
    @modifyRole room, nick, "participant", reason, handler_cb, error_cb

  mute: (room, nick, reason, handler_cb, error_cb) ->
    @modifyRole room, nick, "visitor", reason, handler_cb, error_cb

  op: (room, nick, reason, handler_cb, error_cb) ->
    @modifyRole room, nick, "moderator", reason, handler_cb, error_cb

  deop: (room, nick, reason, handler_cb, error_cb) ->
    @modifyRole room, nick, "participant", reason, handler_cb, error_cb

  
  #Function
  #  Changes the affiliation of a member of a MUC room.
  #  The modification can only be done by a room moderator. An error will be
  #  returned if the user doesn't have permission.
  #  Parameters:
  #  (String) room - The multi-user chat room name.
  #  (String) jid  - The jid of the user to modify.
  #  (String) affiliation - The new affiliation of the user.
  #  (String) reason - Optional reason for the change.
  #  (Function) handler_cb - Optional callback for success
  #  (Function) error_cb - Optional callback for error
  #  Returns:
  #  iq - the id of the mode change request.
  #  
  modifyAffiliation: (room, jid, affiliation, reason, handler_cb, error_cb) ->
    item = undefined
    item = $build("item",
      jid: jid
      affiliation: affiliation
    )
    @_modifyPrivilege room, item, reason, handler_cb, error_cb

  ban: (room, jid, reason, handler_cb, error_cb) ->
    @modifyAffiliation room, jid, "outcast", reason, handler_cb, error_cb

  member: (room, jid, reason, handler_cb, error_cb) ->
    @modifyAffiliation room, jid, "member", reason, handler_cb, error_cb

  revoke: (room, jid, reason, handler_cb, error_cb) ->
    @modifyAffiliation room, jid, "none", reason, handler_cb, error_cb

  owner: (room, jid, reason, handler_cb, error_cb) ->
    @modifyAffiliation room, jid, "owner", reason, handler_cb, error_cb

  admin: (room, jid, reason, handler_cb, error_cb) ->
    @modifyAffiliation room, jid, "admin", reason, handler_cb, error_cb

  
  #Function
  #  Change the current users nick name.
  #  Parameters:
  #  (String) room - The multi-user chat room name.
  #  (String) user - The new nick name.
  #  
  changeNick: (room, user) ->
    presence = undefined
    room_nick = undefined
    room_nick = @test_append_nick(room, user)
    presence = $pres(
      from: @_connection.jid
      to: room_nick
      id: @_connection.getUniqueId()
    )
    @_connection.send presence.tree()

  
  #Function
  #  Change the current users status.
  #  Parameters:
  #  (String) room - The multi-user chat room name.
  #  (String) user - The current nick.
  #  (String) show - The new show-text.
  #  (String) status - The new status-text.
  #  
  setStatus: (room, user, show, status) ->
    presence = undefined
    room_nick = undefined
    room_nick = @test_append_nick(room, user)
    presence = $pres(
      from: @_connection.jid
      to: room_nick
    )
    presence.c("show", show).up()  if show?
    presence.c "status", status  if status?
    @_connection.send presence.tree()

  
  #Function
  #  List all chat room available on a server.
  #  Parameters:
  #  (String) server - name of chat server.
  #  (String) handle_cb - Function to call for room list return.
  #  (String) error_cb - Function to call on error.
  #  
  listRooms: (server, handle_cb, error_cb) ->
    iq = undefined
    iq = $iq(
      to: server
      from: @_connection.jid
      type: "get"
    ).c("query",
      xmlns: Strophe.NS.DISCO_ITEMS
    )
    @_connection.sendIQ iq, handle_cb, error_cb

  test_append_nick: (room, nick) ->
    room + ((if nick? then "/" + (Strophe.escapeNode(nick)) else ""))

XmppRoom = (->
  XmppRoom = (client, name, nick, password) ->
    @client = client
    @name = name
    @nick = nick
    @password = password
    @_roomRosterHandler = __bind_(@_roomRosterHandler, this)
    @_addOccupant = __bind_(@_addOccupant, this)
    @client = client.muc  if client.muc
    @name = Strophe.getBareJidFromJid(name)
    @client.rooms[@name] = this
    @addHandler "presence", @_roomRosterHandler
  XmppRoom::roster = {}
  XmppRoom::_message_handlers = {}
  XmppRoom::_presence_handlers = {}
  XmppRoom::_roster_handlers = {}
  XmppRoom::_handler_ids = 0
  XmppRoom::join = (msg_handler_cb, pres_handler_cb, roster_cb) ->
    @client.join @name, @nick, msg_handler_cb, pres_handler_cb, roster_cb, @password

  XmppRoom::leave = (handler_cb, message) ->
    @client.leave @name, @nick, handler_cb, message
    delete @client.rooms[@name]

  XmppRoom::message = (nick, message, html_message, type) ->
    @client.message @name, nick, message, html_message, type

  XmppRoom::groupchat = (message, html_message) ->
    @client.groupchat @name, message, html_message

  XmppRoom::invite = (receiver, reason) ->
    @client.invite @name, receiver, reason

  XmppRoom::directInvite = (receiver, reason) ->
    @client.directInvite @name, receiver, reason, @password

  XmppRoom::configure = (handler_cb) ->
    @client.configure @name, handler_cb

  XmppRoom::cancelConfigure = ->
    @client.cancelConfigure @name

  XmppRoom::saveConfiguration = (config) ->
    @client.saveConfiguration @name, config

  XmppRoom::queryOccupants = (success_cb, error_cb) ->
    @client.queryOccupants @name, success_cb, error_cb

  XmppRoom::setTopic = (topic) ->
    @client.setTopic @name, topic

  XmppRoom::modifyRole = (nick, role, reason, success_cb, error_cb) ->
    @client.modifyRole @name, nick, role, reason, success_cb, error_cb

  XmppRoom::kick = (nick, reason, handler_cb, error_cb) ->
    @client.kick @name, nick, reason, handler_cb, error_cb

  XmppRoom::voice = (nick, reason, handler_cb, error_cb) ->
    @client.voice @name, nick, reason, handler_cb, error_cb

  XmppRoom::mute = (nick, reason, handler_cb, error_cb) ->
    @client.mute @name, nick, reason, handler_cb, error_cb

  XmppRoom::op = (nick, reason, handler_cb, error_cb) ->
    @client.op @name, nick, reason, handler_cb, error_cb

  XmppRoom::deop = (nick, reason, handler_cb, error_cb) ->
    @client.deop @name, nick, reason, handler_cb, error_cb

  XmppRoom::modifyAffiliation = (jid, affiliation, reason, success_cb, error_cb) ->
    @client.modifyAffiliation @name, jid, affiliation, reason, success_cb, error_cb

  XmppRoom::ban = (jid, reason, handler_cb, error_cb) ->
    @client.ban @name, jid, reason, handler_cb, error_cb

  XmppRoom::member = (jid, reason, handler_cb, error_cb) ->
    @client.member @name, jid, reason, handler_cb, error_cb

  XmppRoom::revoke = (jid, reason, handler_cb, error_cb) ->
    @client.revoke @name, jid, reason, handler_cb, error_cb

  XmppRoom::owner = (jid, reason, handler_cb, error_cb) ->
    @client.owner @name, jid, reason, handler_cb, error_cb

  XmppRoom::admin = (jid, reason, handler_cb, error_cb) ->
    @client.admin @name, jid, reason, handler_cb, error_cb

  XmppRoom::changeNick = (nick) ->
    @nick = nick
    @client.changeNick @name, nick

  XmppRoom::setStatus = (show, status) ->
    @client.setStatus @name, @nick, show, status

  
  #Function
  #  Adds a handler to the MUC room.
  #    Parameters:
  #  (String) handler_type - 'message', 'presence' or 'roster'.
  #  (Function) handler - The handler function.
  #  Returns:
  #  id - the id of handler.
  #  
  XmppRoom::addHandler = (handler_type, handler) ->
    id = undefined
    id = @_handler_ids++
    switch handler_type
      when "presence"
        @_presence_handlers[id] = handler
      when "message"
        @_message_handlers[id] = handler
      when "roster"
        @_roster_handlers[id] = handler
      else
        @_handler_ids--
        return null
    id

  
  #Function
  #  Removes a handler from the MUC room.
  #  This function takes ONLY ids returned by the addHandler function
  #  of this room. passing handler ids returned by connection.addHandler
  #  may brake things!
  #    Parameters:
  #  (number) id - the id of the handler
  #  
  XmppRoom::removeHandler = (id) ->
    delete @_presence_handlers[id]

    delete @_message_handlers[id]

    delete @_roster_handlers[id]

  
  #Function
  #  Creates and adds an Occupant to the Room Roster.
  #    Parameters:
  #  (Object) data - the data the Occupant is filled with
  #  Returns:
  #  occ - the created Occupant.
  #  
  XmppRoom::_addOccupant = (data) ->
    occ = undefined
    occ = new Occupant(data, this)
    @roster[occ.nick] = occ
    occ

  
  #Function
  #  The standard handler that managed the Room Roster.
  #    Parameters:
  #  (Object) pres - the presence stanza containing user information
  #  
  XmppRoom::_roomRosterHandler = (pres) ->
    data = undefined
    handler = undefined
    id = undefined
    newnick = undefined
    nick = undefined
    _ref = undefined
    data = XmppRoom._parsePresence(pres)
    nick = data.nick
    newnick = data.newnick or null
    switch data.type
      when "error"
        return
      when "unavailable"
        if newnick
          data.nick = newnick
          if @roster[nick] and @roster[newnick]
            @roster[nick].update @roster[newnick]
            @roster[newnick] = @roster[nick]
          @roster[newnick] = @roster[nick].update(data)  if @roster[nick] and not @roster[newnick]
        delete @roster[nick]
      else
        if @roster[nick]
          @roster[nick].update data
        else
          @_addOccupant data
    _ref = @_roster_handlers
    for id of _ref
      handler = _ref[id]
      delete @_roster_handlers[id]  unless handler(@roster, this)
    true

  
  #Function
  #  Parses a presence stanza
  #    Parameters:
  #  (Object) data - the data extracted from the presence stanza
  #  
  XmppRoom._parsePresence = (pres) ->
    a = undefined
    c = undefined
    c2 = undefined
    data = undefined
    _i = undefined
    _j = undefined
    _len = undefined
    _len1 = undefined
    _ref = undefined
    _ref1 = undefined
    _ref2 = undefined
    _ref3 = undefined
    _ref4 = undefined
    _ref5 = undefined
    _ref6 = undefined
    _ref7 = undefined
    data = {}
    a = pres.attributes
    data.nick = Strophe.getResourceFromJid(a.from.textContent)
    data.type = ((if (_ref = a.type)? then _ref.textContent else undefined)) or null
    data.states = []
    _ref1 = pres.childNodes
    _i = 0
    _len = _ref1.length

    while _i < _len
      c = _ref1[_i]
      switch c.nodeName
        when "status"
          data.status = c.textContent or null
        when "show"
          data.show = c.textContent or null
        when "x"
          a = c.attributes
          if ((if (_ref2 = a.xmlns)? then _ref2.textContent else undefined)) is Strophe.NS.MUC_USER
            _ref3 = c.childNodes
            _j = 0
            _len1 = _ref3.length

            while _j < _len1
              c2 = _ref3[_j]
              switch c2.nodeName
                when "item"
                  a = c2.attributes
                  data.affiliation = ((if (_ref4 = a.affiliation)? then _ref4.textContent else undefined)) or null
                  data.role = ((if (_ref5 = a.role)? then _ref5.textContent else undefined)) or null
                  data.jid = ((if (_ref6 = a.jid)? then _ref6.textContent else undefined)) or null
                  data.newnick = ((if (_ref7 = a.nick)? then _ref7.textContent else undefined)) or null
                when "status"
                  data.states.push c2.attributes.code.textContent  if c2.attributes.code
              _j++
      _i++
    data

  XmppRoom
)()
RoomConfig = (->
  RoomConfig = (info) ->
    @parse = __bind_(@parse, this)
    @parse info  if info?
  RoomConfig::parse = (result) ->
    attr = undefined
    attrs = undefined
    child = undefined
    field = undefined
    identity = undefined
    query = undefined
    _i = undefined
    _j = undefined
    _k = undefined
    _len = undefined
    _len1 = undefined
    _len2 = undefined
    _ref = undefined
    query = result.getElementsByTagName("query")[0].childNodes
    @identities = []
    @features = []
    @x = []
    _i = 0
    _len = query.length

    while _i < _len
      child = query[_i]
      attrs = child.attributes
      switch child.nodeName
        when "identity"
          identity = {}
          _j = 0
          _len1 = attrs.length

          while _j < _len1
            attr = attrs[_j]
            identity[attr.name] = attr.textContent
            _j++
          @identities.push identity
        when "feature"
          @features.push attrs["var"].textContent
        when "x"
          attrs = child.childNodes[0].attributes
          break  if (not attrs["var"].textContent is "FORM_TYPE") or (not attrs.type.textContent is "hidden")
          _ref = child.childNodes
          _k = 0
          _len2 = _ref.length

          while _k < _len2
            field = _ref[_k]
            continue  unless not field.attributes.type
            attrs = field.attributes
            @x.push
              var: attrs["var"].textContent
              label: attrs.label.textContent or ""
              value: field.firstChild.textContent or ""

            _k++
      _i++
    identities: @identities
    features: @features
    x: @x

  RoomConfig
)()
Occupant = (->
  Occupant = (data, room) ->
    @room = room
    @update = __bind_(@update, this)
    @admin = __bind_(@admin, this)
    @owner = __bind_(@owner, this)
    @revoke = __bind_(@revoke, this)
    @member = __bind_(@member, this)
    @ban = __bind_(@ban, this)
    @modifyAffiliation = __bind_(@modifyAffiliation, this)
    @deop = __bind_(@deop, this)
    @op = __bind_(@op, this)
    @mute = __bind_(@mute, this)
    @voice = __bind_(@voice, this)
    @kick = __bind_(@kick, this)
    @modifyRole = __bind_(@modifyRole, this)
    @update data
  Occupant::modifyRole = (role, reason, success_cb, error_cb) ->
    @room.modifyRole @nick, role, reason, success_cb, error_cb

  Occupant::kick = (reason, handler_cb, error_cb) ->
    @room.kick @nick, reason, handler_cb, error_cb

  Occupant::voice = (reason, handler_cb, error_cb) ->
    @room.voice @nick, reason, handler_cb, error_cb

  Occupant::mute = (reason, handler_cb, error_cb) ->
    @room.mute @nick, reason, handler_cb, error_cb

  Occupant::op = (reason, handler_cb, error_cb) ->
    @room.op @nick, reason, handler_cb, error_cb

  Occupant::deop = (reason, handler_cb, error_cb) ->
    @room.deop @nick, reason, handler_cb, error_cb

  Occupant::modifyAffiliation = (affiliation, reason, success_cb, error_cb) ->
    @room.modifyAffiliation @jid, affiliation, reason, success_cb, error_cb

  Occupant::ban = (reason, handler_cb, error_cb) ->
    @room.ban @jid, reason, handler_cb, error_cb

  Occupant::member = (reason, handler_cb, error_cb) ->
    @room.member @jid, reason, handler_cb, error_cb

  Occupant::revoke = (reason, handler_cb, error_cb) ->
    @room.revoke @jid, reason, handler_cb, error_cb

  Occupant::owner = (reason, handler_cb, error_cb) ->
    @room.owner @jid, reason, handler_cb, error_cb

  Occupant::admin = (reason, handler_cb, error_cb) ->
    @room.admin @jid, reason, handler_cb, error_cb

  Occupant::update = (data) ->
    @nick = data.nick or null
    @affiliation = data.affiliation or null
    @role = data.role or null
    @jid = data.jid or null
    @status = data.status or null
    @show = data.show or null
    this

  Occupant
)()