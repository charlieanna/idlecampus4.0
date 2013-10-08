# problem is if i open another chat then the msgs go there instead of coming to me.
# console.log gon.names
app = angular.module("idlecampus", ['ngResource','$strap.directives'])
re = /\S+@\S+\.\S+/
# available
app.directive "integer1",($http) ->
  require: "ngModel"
  link: (scope, elm, attrs, ctrl) ->
    ctrl.$parsers.unshift (viewValue) ->
      if viewValue and re.test(viewValue)
        $http(
          method: "GET"
          url: "/users/checkEmail"
          params:{email:viewValue}
        ).success((data, status, headers, config) ->
          console.log data
          if  parseInt(data) == 0
            $("#emailicon").attr('class','icon-check')
            ctrl.$setValidity "integer1", true
            viewValue
          if  parseInt(data) > 0
            $("#emailicon").attr('class','icon-remove')
            ctrl.$setValidity "integer1", false
            viewValue

        ).error (data, status, headers, config) ->
          console.log "error"

          ctrl.$setValidity "integer1", false
          `undefined`

        # it is valid
        ctrl.$setValidity "integer1", true
        viewValue
#      else
#
#        # it is invalid, return undefined (no model update)
#        ctrl.$setValidity "integer", false
#        `undefined`


re = /\S+@\S+\.\S+/
# available
#app.directive "emailavailable", ($http) ->
#  require: "ngModel"
#  link: (scope, elem, attr, ctrl,ngModel) ->
#    ctrl.$parsers.unshift (viewValue) ->
#      console.log viewValue
#      if viewValue and re.test(viewValue)
#        console.log "variable is defined"
#        $http(
#          method: "GET"
#          url: "/users/checkEmail"
#          params:{email:viewValue}
#        ).success((data, status, headers, config) ->
#          console.log data
#          if  parseInt(data) == 0
#            $("#emailicon").attr('class','icon-check')
#            ctrl.$setValidity "emailavailable", true
#            viewValue
#          if  parseInt(data) > 0
#            $("#emailicon").attr('class','icon-remove')
#            ctrl.$setValidity "emailavailable", false
#            #               ngModel.$setValidity('somethingIsBad', false);
#            viewValue
#
#        ).error (data, status, headers, config) ->
#          console.log "error"
#          $("#emailicon").attr('class','icon-remove')
#          ctrl.$setValidity "emailavailable", false
#          `undefined`
#
#
#      else
#        console.log "hi"
#        ctrl.$setValidity "emailavailable", false
#        $("#emailicon").attr('class','icon-remove')





app.directive "integer",($http) ->
  require: "ngModel"
  link: (scope, elm, attrs, ctrl) ->
    ctrl.$parsers.unshift (viewValue) ->
#      if (viewValue).length > 0
      $http(
        method: "GET"
        url: "/users/checkName"
        params:{name:viewValue}
      ).success((data, status, headers, config) ->
        console.log data
        if  parseInt(data) == 0
          $("#nameicon").attr('class','icon-check')
          ctrl.$setValidity "integer", true
          viewValue
        if  parseInt(data) > 0
          $("#nameicon").attr('class','icon-remove')
          ctrl.$setValidity "integer", false
          viewValue

      ).error (data, status, headers, config) ->
        console.log "error"

        ctrl.$setValidity "integer", false
        `undefined`

      # it is valid
      ctrl.$setValidity "integer", true
      viewValue
#      else
#
#        # it is invalid, return undefined (no model update)
#        ctrl.$setValidity "integer", false
#        `undefined`








app.directive "passworddir", ->
  require: "ngModel"
  link: (scope, elm, attrs, ctrl) ->
    ctrl.$parsers.unshift (viewValue) ->
      console.log viewValue
      if viewValue.length >5
        $("#passwordicon").attr('class','icon-check')
        # it is valid
        ctrl.$setValidity "passworddir", true
        viewValue
      else

# it is invalid, return undefined (no model update)
        $("#passwordicon").attr('class','icon-remove')
        ctrl.$setValidity "passworddir", false


$ ->


  # $("#signinbutton").click ->
  #   $("#signin_form").slideToggle()

  $("#dialog-form1").dialog
    autoOpen: false
    modal: true
    show: "fade"
    hide: "fade"

  $(".create-user1").click ->
    $("#signup-form").dialog "open"

  $(".create-user").click ->
    $("#dialog-form1").dialog "open"


















