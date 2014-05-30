# 'use strict'

# angular.module('boltClientApp')
#   .controller('MainCtrl', ($scope) ->
#     $scope.pips = [
#      {id: 1, name: 'Jim', pip: 'Celebrity gossip is crucial to life success...'},
#      {id: 2, name: 'Barry', pip: 'Just ate breakfast. Going to watch TV'}
#     ])
"use strict"
angular.module("boltClientApp").controller "MainCtrl", ($scope, Pipbackend) ->
  $scope.refreshPips = ->
    Pipbackend.pips.query
      limit: 10
      offset: 0
    , (onSuccess = (pipList) ->
      $scope.pips = pipList
      $scope.clearError()
      return
    ), $scope.setError # on error
    return