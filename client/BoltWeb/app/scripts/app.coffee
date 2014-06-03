'use strict'

angular.module('boltWebApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    # 'ngRoute',
    'ui.router',
    'boltApiServices'
  ])
  
  # .config ($routeProvider) ->
  #   $routeProvider
  #     .when '/',
  #       templateUrl: 'views/main.html'
  #       controller: 'MainCtrl'
  #     .otherwise redirectTo: '/'
  #     .when '/users/:id',
  #       templateUrl: 'views/user.html'
  #       controller: 'UserCtrl',
  #         id: ":id"

  .config ($stateProvider, $urlRouterProvider) ->
    # $urlRouterProvider.otherwise "/"
    $stateProvider
      .state "main",
        url: "/"
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'

      .state "users",
        url: "users"
        templateUrl: "views/user.html"
        controller: 'UserCtrl'
        # controller: ($scope, $stateParams) ->
        #   $scope.userId = $stateParams.userId

  # .run(['$rootScope', '$state', '$stateParams',
  #     ($rootScope, $state, $stateParams) ->
  #         $rootScope.$state = $state
  #         $rootScope.$stateParams = $stateParams
  #         $state.transitionTo('main')
  # ])