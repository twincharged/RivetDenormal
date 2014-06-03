'use strict'

describe 'Service: Boltserverapi', ->

  # load the service's module
  beforeEach module 'boltWebApp'

  # instantiate service
  Boltserverapi = {}
  beforeEach inject (_Boltserverapi_) ->
    Boltserverapi = _Boltserverapi_

  it 'should do something', ->
    expect(!!Boltserverapi).toBe true
