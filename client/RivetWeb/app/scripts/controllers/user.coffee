'use strict'

class UserCtrl
 constructor: ($scope, $stateParams, RivetApi) ->

    RivetApi.getProfile($stateParams.userId).then (data)->
      $scope.user = data.user
      $scope.posts = data.posts

    $scope.getFollowers = (userId)->
      getData(userId, "followers")

    $scope.getFollowing = (userId)->
      getData(userId, "following")

    $scope.getConversations = (userId)->
      getData(userId, "conversations")

    $scope.getGroups = (userId)->
      getData(userId, "groups")

    $scope.getBlockedUserIds = (userId)->
      getData(userId, "blockedUserIds")

    $scope.getSettings = (userId)->
      getData(userId, "settings")

    getData = (userId, fieldName)->
      RivetApi['get' + fieldName.capitalize()](userId).then (data)->
        $scope[fieldName] = data[fieldName]
        $scope[fieldName].push("none") if _.isEmpty($scope[fieldName])

UserCtrl.$inject = ["$scope", '$stateParams', 'RivetApi']
angular.module("rivetWebApp").controller "UserCtrl", UserCtrl