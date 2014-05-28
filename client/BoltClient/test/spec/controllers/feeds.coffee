'use strict'

describe 'Controller: FeedsCtrl', ->

  # load the controller's module
  beforeEach module 'boltClientApp'

  FeedsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    FeedsCtrl = $controller 'FeedsCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
