'use strict'

describe 'Service: Pipbackend', ->

  # load the service's module
  beforeEach module 'piprApp'

  # instantiate service
  Pipbackend = {}
  beforeEach inject (_Pipbackend_) ->
    Pipbackend = _Pipbackend_

  it 'should do something', ->
    expect(!!Pipbackend).toBe true
