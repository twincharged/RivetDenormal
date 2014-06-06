'use strict'

angular.module("boltWebApp.services", ['restangular'])

.factory "BoltApi", (Restangular, $q) ->

  getProfile: (userId)->
    # deferred = $q.defer()
    Restangular.one("users", userId).get().then (profile)->
      return profile
      # deferred.resolve(data)
      # deferred.promise
      # return data
    # console.log(data)