'use strict'

class UserCtrl
 constructor: ($scope, $stateParams, BoltApi) ->

    BoltApi.getProfile($stateParams.userId).then (data)->
      $scope.user = data.user
      $scope.posts = data.posts

    getFollowers = (userId)->
      BoltApi.getFollowers(userId).then (data)->
        $scope.followers = data.followers

    getFollowing = (userId)->
      BoltApi.getFollowing(userId).then (data)->
        $scope.following = data.following

UserCtrl.$inject = ["$scope", '$stateParams', 'BoltApi']
angular.module("boltWebApp").controller "UserCtrl", UserCtrl









































#   // # .controller 'UserCtrl', ['BoltApi', '$stateParams', ($scope, BoltApi)->
#   // #   console.log(BoltApi.someValue)
#   // #   # BoltApi.getProfile(1).then (data)-> #.getList() #.then (data)->
#   // #   #  $scope.user = data
#   // #   # console.log($scope.user)
#   // #   # serverUser = uposts[0]
#   // #   # $scope.userPosts = serverUser.get("posts")
#   // #     # $scope.user = data
#   // # ]
#   app.controller('UserCtrl', ['$scope', 'BoltApi', '$stateParams', function($scope, BoltApi, $stateParams) {
#   $scope.data = BoltApi;
#   console.log(BoltApi)
# }]);
