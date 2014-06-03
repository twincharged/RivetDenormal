'use strict'

angular.module('boltWebApp')
  .controller('UserCtrl', ['$scope', 'Post'
    ($scope, Post) ->
      Post.get({userId: $scope.userId, info: "posts"}, (data) ->
        $scope.posts = data.posts
        $scope.user = data.user
      )])
