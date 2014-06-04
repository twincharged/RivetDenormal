'use strict'

angular.module('boltWebApp')

  .factory 'BoltApi', ['restangular', (RestangularProvider)->
    RestangularProvider.setBaseUrl('http://127.0.0.1:3000/api/v1')

  ]


  # .service 'UserService', ->