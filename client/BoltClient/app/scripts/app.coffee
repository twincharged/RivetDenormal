"use strict"

angular.module("boltClientApp", [
  "ngCookies"
  "ngResource"
  "ngSanitize"
  "ngRoute"
])

.config(($routeProvider) ->
  $routeProvider
  .when "/",
    templateUrl: "views/main.html"
    controller: "MainCtrl"
  .when "/users",
    templateUrl: "views/users.html"
    controller: "UsersCtrl"
  .otherwise redirectTo: "/"
  return
  )

.config(["$resourceProvider", ($resourceProvider) ->
  $resourceProvider.defaults.stripTrailingSlashes = false
])