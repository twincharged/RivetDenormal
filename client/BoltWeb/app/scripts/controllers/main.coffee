'use strict'

angular.module('boltWebApp')
  .controller('MainCtrl', ['$scope', 'Post'
    ($scope, Post) ->
      $scope.posts = Post.getPosts()
  ])
