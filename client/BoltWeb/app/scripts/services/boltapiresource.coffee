"use strict"

postServices = angular.module("boltApiServices", ["ngResource"])
postServices.factory("Post", ["$resource",
  ($resource) ->
  	return getPosts: (callback) ->
      api = $resource("http://127.0.0.1:3000/api/v1/users/1/posts", {},
        query:
          method: "JSONP"
          params:
            userId: "@userId"
 
      isArray: true
      )
      api.query (response) ->
      	callback(response.data)

])