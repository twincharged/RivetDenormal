'use strict'

# angular.module('boltWebApp')
#   .controller('UserCtrl', ['UserService', ($scope, UserService)->

#   	$scope.user = UserService.one("users", 1)

#   ])

angular.module('boltWebApp')
  .controller 'UserCtrl', ['UserService', '$stateParams', ($scope, UserService)->
    
    $scope.user = UserService.one("users", 1)

  ]