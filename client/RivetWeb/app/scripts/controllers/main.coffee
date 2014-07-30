'use strict'

class MainCtrl
 constructor: ($scope) ->

    $scope.langs = ['Ruby', 'CS', 'Python']

MainCtrl.$inject = ["$scope"]
angular.module("rivetWebApp").controller "MainCtrl", MainCtrl