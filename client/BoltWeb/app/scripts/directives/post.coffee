'use strict'

angular.module('boltWebApp')
  .directive('post', ->
    template: '<div></div>'
    restrict: 'E'
    link: (scope, element, attrs) ->
      element.text 'this is the Post directive'
  )