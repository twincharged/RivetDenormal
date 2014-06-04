'use strict'

describe 'Service: Boltapi', ->

  # load the service's module
  beforeEach module 'boltWebApp'

  # instantiate service
  Boltapi = {}
  beforeEach inject (_Boltapi_) ->
    Boltapi = _Boltapi_

  it 'should do something', ->
    expect(!!Boltapi).toBe true
