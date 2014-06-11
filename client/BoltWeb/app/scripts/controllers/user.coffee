'use strict'

class UserCtrl
 constructor: ($scope, $stateParams, BoltApi) ->

    BoltApi.getProfile($stateParams.userId).then (data)->
      $scope.user = data.user
      $scope.posts = data.posts

    $scope.getEvents = (userId)->
      getData(userId, "events")

    $scope.getAddedEvents = (userId)->
      getData(userId, "addedEvents")

    $scope.getInvitedEvents = (userId)->
      getData(userId, "invitedEvents")

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

    getData = (userId, fieldName)->
      eval("BoltApi.get#{fieldName.capitalize()}(#{userId})").then (data)->
        $scope[fieldName] = data[fieldName]
        $scope[fieldName].push("none") if _.isEmpty($scope[fieldName])

UserCtrl.$inject = ["$scope", '$stateParams', 'BoltApi']
angular.module("boltWebApp").controller "UserCtrl", UserCtrl
