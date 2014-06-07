'use strict'

angular.module("boltWebApp.services", ['restangular'])

.factory "BoltApi", (Restangular, $q)->

  getProfile: (userId)->

    deferred = $q.defer()
    # Restangular.one("users", userId).one("profile").get().$object
    Restangular.one("users", userId).one("profile").get() #.then (data)->
      # deferred.resolve(data)
      # r = deferred.promise
      # console.log data
      # return data