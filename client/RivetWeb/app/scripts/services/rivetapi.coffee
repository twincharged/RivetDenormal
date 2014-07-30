'use strict'

angular.module("rivetWebApp.services", ['restangular'])

.factory "RivetApi", (Restangular)->

  getUser: (userId)->
    Restangular.one("users", userId).get()

  getProfile: (userId)->
    Restangular.one("users", userId).one("profile").get()

  getFollowers: (userId)->
    Restangular.one("users", userId).one("followers").get()

  getFollowing: (userId)->
    Restangular.one("users", userId).one("following").get()

  getConversations: (userId)->
    Restangular.one("users", userId).one("conversations").get()

  getConversation: (userId, conversationId)->
    Restangular.one("users", userId).one("conversations", conversationId).get()

  getGroups: (userId)->
    Restangular.one("users", userId).one("groups").get()

  getGroup: (userId, groupId)->
    Restangular.one("users", userId).one("groups", groupId).get()

  getPost: (postId)->
    Restangular.one("posts", postId).get()

  getSettings: (userId)->
    Restangular.one("users", userId).one("settings").get()

  getFollowerCount: (userId)->
    Restangular.one("users", userId).one("follower_count").get()

  getFollowingCount: (userId)->
    Restangular.one("users", userId).one("following_count").get()

  getBlockedUserIds: (userId)->
    Restangular.one("users", userId).one("blocked_user_ids").get()