'use strict'

angular.module("boltWebApp.services", ['restangular'])

.factory "BoltApi", (Restangular)->

  getUser: (userId)->
    Restangular.one("users", userId).get()

  getProfile: (userId)->
    Restangular.one("users", userId).one("profile").get()

  getEvents: (userId)->
    Restangular.one("users", userId).one("events").get()

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

  getAddedEvents: (userId)->
    Restangular.one("users", userId).one("added_events").get()

  getInvitedEvents: (userId)->
    Restangular.one("users", userId).one("invited_events").get()

  getEvent: (eventId)->
    Restangular.one("events", eventId).get()

  getPost: (postId)->
    Restangular.one("posts", eventId).get()

  getSettings: (userId)->
    Restangular.one("users", userId).one("settings").get()

  getFollowerCount: (userId)->
    Restangular.one("users", userId).one("follower_count").get()

  getFollowingCount: (userId)->
    Restangular.one("users", userId).one("following_count").get()

  getBlockedUserIds: (userId)->
    Restangular.one("users", userId).one("blocked_user_ids").get()