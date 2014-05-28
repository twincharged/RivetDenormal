"use strict"

describe "Controller: MainCtrl", ->
  
  beforeEach module("boltClientApp")
  MainCtrl = undefined
  scope = undefined
  
  beforeEach inject(($controller, $rootScope) ->
    scope = $rootScope.$new()
    MainCtrl = $controller("MainCtrl", $scope: scope)
    return
  )
  
  it "should attach a list of awesomeThings to the scope", ->
    expect(scope.awesomeThings.length).toBe(3)
    return

  return
