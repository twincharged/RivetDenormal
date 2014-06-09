'use strict'

class UserCtrl
 constructor: ($scope, $stateParams, BoltApi) ->

    BoltApi.getProfile($stateParams.userId).then (data)->
      $scope.user = data.user
      $scope.posts = data.posts

    $scope.getEvents = (userId)->
      BoltApi.getEvents(userId).then (data)->
        $scope.events = data.events
        $scope.events = ["none"] unless $scope.events.length

    $scope.getFollowers = (userId)->
      BoltApi.getFollowers(userId).then (data)->
        $scope.followers = data.followers
        $scope.followers = ["none"] unless $scope.followers.length

    $scope.getFollowing = (userId)->
      BoltApi.getFollowing(userId).then (data)->
        $scope.following = data.following
        $scope.following = ["none"] unless $scope.following.length


UserCtrl.$inject = ["$scope", '$stateParams', 'BoltApi']
angular.module("boltWebApp").controller "UserCtrl", UserCtrl
