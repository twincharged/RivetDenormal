'use strict'

angular.module("boltWebApp.services", ['restangular'])

.factory "BoltApi", (Restangular)->

  getUser: (userId)->
  	Restangular.one("users", userId).get()

  getProfile: (userId)->
    Restangular.one("users", userId).one("profile").get()

  getFollowers: (userId)->
  	Restangular.one("users", userId).one("followers").get()

  getFollowing: (userId)->
  	Restangular.one("users", userId).one("following").get()








    # deferred = $q.defer()
    # Restangular.one("users", userId).one("profile").get().then (data)->   #.$object
      # deferred.resolve(data)
      # deferred.promise
      # console.log data