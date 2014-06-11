'use strict'

class UserCtrl
 constructor: ($scope, $stateParams, BoltApi) ->

    BoltApi.getProfile($stateParams.userId).then (data)->
      $scope.user = data.user
      $scope.posts = data.posts

    $scope.getEvents = (userId)->
      BoltApi.getEvents(userId).then (data)->
        $scope.events = data.events
        $scope.events.push("none") if _.isEmpty($scope.events)

    $scope.getAddedEvents = (userId)->
      BoltApi.getAddedEvents(userId).then (data)->
        $scope.addedEvents = data.added_events
        $scope.addedEvents.push("none") if _.isEmpty($scope.addedEvents)

    $scope.getInvitedEvents = (userId)->
      BoltApi.getInvitedEvents(userId).then (data)->
        $scope.invitedEvents = data.invited_events
        $scope.invitedEvents.push("none") if _.isEmpty($scope.invitedEvents)

    $scope.getFollowers = (userId)->
      BoltApi.getFollowers(userId).then (data)->
        $scope.followers = data.followers
        $scope.followers.push("none") if _.isEmpty($scope.followers)

    $scope.getFollowing = (userId)->
      BoltApi.getFollowing(userId).then (data)->
        $scope.following = data.following
        $scope.following.push("none") if _.isEmpty($scope.following)

    $scope.getConversations = (userId)->
      BoltApi.getConversations(userId).then (data)->
        $scope.conversations = data.conversations
        $scope.conversations.push("none") if _.isEmpty($scope.conversations)

    $scope.getGroups = (userId)->
      BoltApi.getGroups(userId).then (data)->
        $scope.groups = data.groups
        $scope.groups.push("none") if _.isEmpty($scope.groups)

UserCtrl.$inject = ["$scope", '$stateParams', 'BoltApi']
angular.module("boltWebApp").controller "UserCtrl", UserCtrl
