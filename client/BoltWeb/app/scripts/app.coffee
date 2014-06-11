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
      templateUrl: 'views/users.html'

    .state 'users.userId',
      url: '/:userId'
      templateUrl: 'views/users.userId.html'
      controller: 'UserCtrl'

.config (RestangularProvider)->
  RestangularProvider.setBaseUrl('http://127.0.0.1:3000/api/v1')


















 # Hax


String.prototype.capitalize = () ->
    @charAt(0).toUpperCase() + @slice(1)