'use strict'

# angular.module('boltWebApp')
#   .controller('UserCtrl', ['UserService', ($scope, UserService)->

#   	$scope.user = UserService.one("users", 1)

#   ])

angular.module('boltWebApp')
  .controller 'UserCtrl', ['restangular', '$stateParams', ($scope, Restangular)->
    uposts = Restangular.all('users')
    # serverUser = uposts[0]
    # $scope.userPosts = serverUser.get("posts")
    $scope.user = "bob"
  ]