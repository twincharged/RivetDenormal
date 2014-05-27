angular.module('bolt').config [
  '$routeProvider'
  '$locationProvider'
  ($routeProvider, $locationProvider) ->
    $routeProvider
    .when '/login',
      templateUrl: '/assets/javascripts/templates/login.html',
      controller: 'LoginController'

    .when '/user/:id',
      templateUrl: '/assets/javascripts/templates/users.html',
      controller: 'UsersController'

    .otherwise
      redirectTo: '/login'

    $locationProvider.html5Mode true
]