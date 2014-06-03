'use strict'

angular.module('boltWebApp')
  .controller('MainCtrl', ['$scope', 'Post'
    ($scope, Post) ->
      $scope.info = Post.query()
      $scope.posts = $scope.info
      $scope.user = $scope.info.user
      console.log($scope.info)
  ])
