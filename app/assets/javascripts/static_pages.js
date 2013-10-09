var app, re;

app = angular.module("idlecampus", ['ngResource', '$strap.directives']);

re = /\S+@\S+\.\S+/;

app.directive("integer1", [
  "$http", function($http) {
    return {
      require: "ngModel",
      link: function(scope, elm, attrs, ctrl) {
        return ctrl.$parsers.unshift(function(viewValue) {
          if (viewValue && re.test(viewValue)) {
            $http({
              method: "GET",
              url: "/users/checkEmail",
              params: {
                email: viewValue
              }
            }).success(function(data, status, headers, config) {
              console.log(data);
              if (parseInt(data) === 0) {
                $("#emailicon").attr('class', 'icon-check');
                ctrl.$setValidity("integer1", true);
                viewValue;

              }
              if (parseInt(data) > 0) {
                $("#emailicon").attr('class', 'icon-remove');
                ctrl.$setValidity("integer1", false);
                return viewValue;
              }
            }).error(function(data, status, headers, config) {
              console.log("error");
              ctrl.$setValidity("integer1", false);
              return undefined;
            });
            ctrl.$setValidity("integer1", true);
            return viewValue;
          }
        });
      }
    };
  }
]);

re = /\S+@\S+\.\S+/;

app.directive("integer", [
  "$http", function($http) {
    return {
      require: "ngModel",
      link: function(scope, elm, attrs, ctrl) {
        return ctrl.$parsers.unshift(function(viewValue) {
          $http({
            method: "GET",
            url: "/users/checkName",
            params: {
              name: viewValue
            }
          }).success(function(data, status, headers, config) {
            console.log(data);
            if (parseInt(data) === 0) {
              $("#nameicon").attr('class', 'icon-check');
              ctrl.$setValidity("integer", true);
              viewValue;

            }
            if (parseInt(data) > 0) {
              $("#nameicon").attr('class', 'icon-remove');
              ctrl.$setValidity("integer", false);
              return viewValue;
            }
          }).error(function(data, status, headers, config) {
            console.log("error");
            ctrl.$setValidity("integer", false);
            return undefined;
          });
          ctrl.$setValidity("integer", true);
          return viewValue;
        });
      }
    };
  }
]);

app.directive("passworddir", [
  function() {
    return {
      require: "ngModel",
      link: function(scope, elm, attrs, ctrl) {
        return ctrl.$parsers.unshift(function(viewValue) {
          console.log(viewValue);
          if (viewValue.length > 5) {
            $("#passwordicon").attr('class', 'icon-check');
            ctrl.$setValidity("passworddir", true);
            return viewValue;
          } else {
            $("#passwordicon").attr('class', 'icon-remove');
            return ctrl.$setValidity("passworddir", false);
          }
        });
      }
    };
  }
]);

$(function() {
  $("#dialog-form1").dialog({
    autoOpen: false,
    modal: true,
    show: "fade",
    hide: "fade"
  });
  $(".create-user1").click(function() {
    return $("#signup-form").dialog("open");
  });
  return $(".create-user").click(function() {
    return $("#dialog-form1").dialog("open");
  });
});
