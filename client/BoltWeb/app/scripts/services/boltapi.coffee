'use strict'

angular.module("boltWebApp.services", ['restangular'])

.factory "BoltApi", (Restangular)->

  getProfile: (userId)->
    # deferred = $q.defer()
    Restangular.one("users", userId).get().$object
      # Restangular.one("users", 1).get().then (data)->
      # deferred.resolve(data)
      # deferred.promise
      # return data