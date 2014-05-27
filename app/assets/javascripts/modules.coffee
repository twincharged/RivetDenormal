angular.module('bolt', [
  'bolt.user'
])

angular.module('bolt.user', [
  'ngRoute'
  'bolt.services'
])

angular.module('bolt.services', [
  'ngRoute'
  'ngAnimate'
  'ngResource'
  'rails'
  'ng-rails-csrf'
])