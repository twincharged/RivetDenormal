'use strict'

angular.module("piprApp")
  .directive "pip", ->
    restrict: "E"
    transclude: true
    scope:
      pip: "=currentPip"
  
    template: "<div ng-transclude id=\"{{pip.id}}\" class=\"pip-box\"></div>"
    replace: true
