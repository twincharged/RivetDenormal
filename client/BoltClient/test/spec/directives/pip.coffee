'use strict'

describe 'Directive: pip', ->

  # load the directive's module
  beforeEach module 'boltClientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<pip></pip>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the pip directive'
