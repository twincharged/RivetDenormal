"use strict"

angular.module("boltApiServices", ["ngResource"])
  .factory("Post", ["$resource",
    ($resource) ->
    	$resource("http://127.0.0.1:3000/api/v1/users/1/posts.json", {},
        query:{method: "GET", params:{userId: "@userId"}, isArray: false})
  ])