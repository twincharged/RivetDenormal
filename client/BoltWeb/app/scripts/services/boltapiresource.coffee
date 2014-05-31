"use strict"

postServices = angular.module("boltApiServices", ["ngResource"])
postServices.factory("Post", ["$resource",
  ($resource) ->
  	return getPosts: (callback) ->
      api = $resource("http://api.bolt-dev.com:9001/users/1/posts", {},
        query:
          method: "JSONP"
          params:
            userId: "@userId"
 
      isArray: true
      )
      api.query (response) ->
      	callback(response.data)

])