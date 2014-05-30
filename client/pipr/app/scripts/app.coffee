'use strict'

angular
  .module('piprApp', [
    'ngResource',
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

