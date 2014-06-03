'use strict'

angular
  .module('boltWebApp', [
    'ngCookies',
    'ngSanitize',
    'restangular',
    'ui.router'
  ])

.config ($stateProvider, $urlRouterProvider) ->
	$urlRouterProvider.otherwise '/'
	$stateProvider
	  .state 'main',
		url: '/'
		templateUrl: 'views/main.html'
		controller: 'MainCtrl'