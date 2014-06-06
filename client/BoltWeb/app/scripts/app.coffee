'use strict'

angular
  .module('boltWebApp', [
    'ngCookies',
    'ngSanitize',
    'ui.router',
    'boltWebApp.services',
    'restangular'
  ])

.config ($stateProvider, $urlRouterProvider)->
  $urlRouterProvider.otherwise '/'
  $stateProvider
    .state 'main',
      url: '/'
      templateUrl: 'views/main.html'
      controller: 'MainCtrl'

    .state 'users',
      url: '/users'
      abstract: true
      templateUrl: 'views/user.html'
      controller: 'UserCtrl'

    .state 'users.userId',
      url: '/:userId'
      templateUrl: 'views/user.html'
      controller: ($scope, $stateParams)->
        $scope.userId = $stateParams.userId

.config (RestangularProvider)->
    RestangularProvider.setBaseUrl('http://127.0.0.1:3000/api/v1')