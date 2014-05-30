'use strict'

angular
  .module('boltWebApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngRoute',
    'boltApiServices'
  ])
  
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .otherwise
        redirectTo: '/'

