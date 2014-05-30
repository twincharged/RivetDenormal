# 'use strict'

# angular.module("piprApp")
#   .service "Pipbackend", Pipbackend = ($resource) ->
#     @pips = $resource("http://pippypips.herokuapp.com/api/pips/:id")
#     return
"use strict"
angular.module("boltClientApp").service "Pipbackend", Pipbackend = ($resource) ->
  @pips = $resource("http://pippypips.herokuapp.com/api/pips/:id")
  return