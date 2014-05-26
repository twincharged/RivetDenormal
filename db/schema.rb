# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140524021732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banned_emails", force: true do |t|
    t.string   "email"
    t.text     "ban_report"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "banned_emails", ["email"], name: "index_banned_emails_on_email", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "reply_to_user_id"
    t.text     "body",                          null: false
    t.string   "photo"
    t.integer  "threadable_id"
    t.string   "threadable_type"
    t.integer  "user_id"
    t.integer  "tagged_user_ids",  default: [],              array: true
    t.integer  "flagger_ids",      default: [],              array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: true do |t|
    t.boolean  "started_by_entity",     default: false
    t.integer  "owner_id"
    t.integer  "conversation_user_ids", default: [],    array: true
    t.integer  "message_ids",           default: [],    array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.text     "body"
    t.string   "name"
    t.boolean  "public",           default: false
    t.string   "address"
    t.boolean  "special",          default: true
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "photo"
    t.string   "youtube_url"
    t.integer  "user_id"
    t.integer  "tagged_user_ids",  default: [],    array: true
    t.integer  "invited_user_ids", default: [],    array: true
    t.integer  "flagger_ids",      default: [],    array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "feedbacks", force: true do |t|
    t.integer  "user_id",    null: false
    t.text     "subject"
    t.text     "body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["created_at", "user_id"], name: "index_feedbacks_on_created_at_and_user_id", using: :btree
  add_index "feedbacks", ["subject"], name: "index_feedbacks_on_subject", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "group_user_ids", default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.text     "body"
    t.string   "photo"
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.text     "body"
    t.boolean  "public",          default: false
    t.string   "youtube_url"
    t.string   "photo"
    t.integer  "user_id"
    t.integer  "shareable_id"
    t.string   "shareable_type"
    t.integer  "tagged_user_ids", default: [],    array: true
    t.integer  "flagger_ids",     default: [],    array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "settings", force: true do |t|
    t.boolean  "follower_approval",     default: false
    t.boolean  "email_notifications",   default: true
    t.boolean  "lock_all_self_content", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["id", "follower_approval"], name: "index_settings_on_id_and_follower_approval", using: :btree

  create_table "user_relations", force: true do |t|
    t.integer  "owned_post_ids",       default: [], array: true
    t.integer  "owned_event_ids",      default: [], array: true
    t.integer  "owned_group_ids",      default: [], array: true
    t.integer  "added_event_ids",      default: [], array: true
    t.integer  "invited_event_ids",    default: [], array: true
    t.integer  "in_conversation_ids",  default: [], array: true
    t.integer  "followed_ids",         default: [], array: true
    t.integer  "follower_ids",         default: [], array: true
    t.integer  "pending_follower_ids", default: [], array: true
    t.integer  "flagger_ids",          default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "university"
    t.string   "gender"
    t.date     "birthday"
    t.text     "description"
    t.boolean  "entity",                 default: false
    t.boolean  "moderator",              default: false
    t.boolean  "deactivated",            default: false
    t.string   "avatar"
    t.string   "backdrop"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["university"], name: "index_users_on_university", using: :btree

end
