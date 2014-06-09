'use strict'

class UserCtrl
 constructor: ($scope, $stateParams, BoltApi) ->

    BoltApi.getProfile($stateParams.userId).then (data)->
      $scope.user = data.user
      $scope.posts = data.posts

    $scope.getEvents = (userId)->
      BoltApi.getEvents(userId).then (data)->
        $scope.events = data.events
        $scope.events = ["none"] if _.isEmpty($scope.events)

    $scope.getFollowers = (userId)->
      BoltApi.getFollowers(userId).then (data)->
        $scope.followers = data.followers
        $scope.followers = ["none"] if _.isEmpty($scope.followers)

    $scope.getFollowing = (userId)->
      BoltApi.getFollowing(userId).then (data)->
        $scope.following = data.following
        $scope.following = ["none"] if _.isEmpty($scope.following)

    $scope.getConversations = (userId)->
      BoltApi.getConversations(userId).then (data)->
        $scope.conversations = data.conversations
        $scope.conversations = ["none"] if _.isEmpty($scope.conversations)

UserCtrl.$inject = ["$scope", '$stateParams', 'BoltApi']
angular.module("boltWebApp").controller "UserCtrl", UserCtrl
