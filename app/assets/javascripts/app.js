var app, re;

app = angular.module("idlecampus", ['ngResource', '$strap.directives']);

re = /\S+@\S+\.\S+/;

app.factory("Data", [
  function() {
    return {
      getgroups: function(connection) {
        var jid;
        jid = connection.jid.split("/")[0];
        return connection.pubsub.items(jid + "/groups", function(iq) {
          return $(iq).find("item").each(function() {
            var node;
            node = void 0;
            node = $(this).children("value").text();
            console.log(node);
            return $.get("/groups/get_group_name", {
              group_code: node
            }).done(function(data) {
              console.log(data);
              $scope.data.groupscreated.push(data);
              console.log($scope.data.groupscreated);
              return $scope.$digest();
            });
          });
        });
      },
	  checked: false,
      currentGroup: "",
      pagetitle: "Latest Posts",
      groupscreated: [],
      groupsfollowing: [],
      folders: [],
      groupMessages: [],
      user: "",
      isVisible: false,
      entries: [],
      teacher: [],
      subjects: [],
      smallGroups: [],
      weekdays: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
      batches: [],
      timeArray: [],
       timetable: {
    weekdays: [],
    batches: [],
    entries: [
      {
        name: "teacher",
        values: []
      }, {
        name: "subject",
        values: []
      }, {
        name: "room",
        values: []
      }
    ]
  }
    };
  }
]);

app.factory("Group", [
  "$resource", function($resource) {
    return $resource("/groups/:verb", {
      verb: ""
    }, {
      update: {
        method: "PUT",
        isArray: true,
        params: {
          name: "",
          verb: "find_by_name"
        }
      },
      createGroup: {
        method: "POST",
        params: {
          name: "",
          code: ""
        }
      }
    });
  }
]);

app.factory("Folder", [
  "$resource", function($resource) {
    return $resource("/groups/find_by_name", {
      group: '@group'
    }, {
      create: {
        method: "POST"
      },
      index: {
        method: "GET",
        isArray: true
      },
      show: {
        method: "GET",
        isArray: false
      },
      update: {
        method: "PUT"
      },
      destroy: {
        method: "DELETE"
      }
    });
  }
]);

app.factory("FilesForFolder", [
  "$resource", function($resource) {
    return "FilesForFolder";
  }
]);

app.factory("Timetable", [
  "$resource", function($resource) {
    return "FilesForFolder";
  }
]);

app.directive('latestposts', function() {
  return function(scope, element) {
    return element.bind("click", function() {
      $('#myposts').show();
      $('#mygroupposts').hide();
      return $('#currentgroup').hide();
    });
  };
});

app.directive('groups', function() {
  return function(scope, element) {
    element.bind("click", function() {});
    $('#mygroupposts').show();
    return $('#myposts').hide();
  };
});

app.directive('deletenode', function() {
  return function(scope, element) {
    return element.bind("click", function() {
      var newNode;
      newNode = $("#newnode").val();
      XMPP.connection.pubsub.connect("abc@idlecampus.com", "pubsub.idlecampus.com");
      return XMPP.connection.pubsub.deleteNode(newNode, callb);
    });
  };
});

app.directive('addf', function() {
  return function(scope, element) {
    return element.bind("click", function() {
      var subscribe;
      subscribe = $pres({
        to: $("#addfriend").val(),
        type: "subscribe"
      });
      return XMPP.connection.send(subscribe);
    });
  };
});

app.directive('logout', function() {
  return function(scope, element) {
    return element.bind("click", function() {
      console.log("logout");
      window.localStorage.setItem("name", "");
      window.localStorage.setItem("password", "");
      $("#loginname").val("");
      $("#loginpassword").val("");
      return XMPP.connection.disconnect("bored");
    });
  };
});

app.directive('accept', function() {
  return function(scope, element) {
    return element.bind("click", function() {
      XMPP.connection.send($pres({
        to: XMPP.pending_subscriber,
        type: "subscribed"
      }));
      XMPP.connection.send($pres({
        to: XMPP.pending_subscriber,
        type: "subscribe"
      }));
      return XMPP.pending_subscriber = null;
    });
  };
});

app.directive('reject', function() {
  return function(scope, element) {
    return element.bind("click", function() {
      XMPP.connection.send($pres({
        to: XMPP.pending_subscriber,
        type: "unsubscribed"
      }));
      return XMPP.pending_subscriber = null;
    });
  };
});

app.directive('folder', function() {
  return function(scope, element) {
    return element.bind("click", function() {
      var folder;
      folder = $(this).text();
      return $.get("/groups/find_by_name", {
        group: node
      });
    });
  };
});
function createCookie(name,value,days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name,"",-1);
}