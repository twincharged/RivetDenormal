"use strict"

angular.module("piprApp")
  .controller("MainCtrl", ['$scope', 'Post',
    ($scope, Post) ->
      $scope.refreshPips = ->
        $scope.pips = Post.query()
      
      $scope.makePip = ->
        Post.pips.save $scope.newPip, onSuccess = (newPip) ->
          $scope.newPip = {name: $scope.newPip.name}
          $scope.refreshPips()
        
      $scope.refreshPips()
      return
      ])