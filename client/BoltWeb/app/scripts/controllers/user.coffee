'use strict'

class UserCtrl
 constructor: ($scope, $stateParams, BoltApi) ->

    profile = BoltApi.getProfile($stateParams.userId)
    profile.then (data)->
      $scope.user = data.user
      $scope.posts = data.posts

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
