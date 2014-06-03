'use strict'

angular.module('boltWebApp', ['restangular'])

  .factory('UserService', ['Restangular',
  	(Restangular) ->
      restAngular = Restangular.withConfig((Configurer) ->
        Configurer.setBaseUrl('localhost:3000/api/v1')
      )
    userService = restAngular.one("users", 1)
    # return getMessages: ->
      # userService.getList()
  ])
