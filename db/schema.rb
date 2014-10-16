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

ActiveRecord::Schema.define(version: 20141016020759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "episode_views", force: true do |t|
    t.integer  "episode_id",             null: false
    t.integer  "user_id",                null: false
    t.integer  "view_count", default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "episode_views", ["episode_id"], name: "index_episode_views_on_episode_id", using: :btree
  add_index "episode_views", ["user_id"], name: "index_episode_views_on_user_id", using: :btree

  create_table "episodes", force: true do |t|
    t.string   "name",           null: false
    t.integer  "season_id",      null: false
    t.integer  "season_number",  null: false
    t.integer  "episode_number", null: false
    t.integer  "tmdb_id",        null: false
    t.integer  "show_id",        null: false
    t.integer  "show_tmdb_id",   null: false
    t.string   "still_path"
    t.text     "description"
    t.date     "air_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "episodes", ["season_id"], name: "index_episodes_on_season_id", using: :btree
  add_index "episodes", ["show_id"], name: "index_episodes_on_show_id", using: :btree
  add_index "episodes", ["tmdb_id"], name: "index_episodes_on_tmdb_id", using: :btree

  create_table "follows", force: true do |t|
    t.integer  "follower_id", null: false
    t.integer  "followed_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followed_id"], name: "index_follows_on_followed_id", using: :btree
  add_index "follows", ["follower_id", "followed_id"], name: "index_follows_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "follows", ["follower_id"], name: "index_follows_on_follower_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "seasons", force: true do |t|
    t.integer  "season_number", null: false
    t.integer  "show_id",       null: false
    t.integer  "tmdb_id",       null: false
    t.integer  "show_tmdb_id",  null: false
    t.string   "poster_path"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seasons", ["show_id"], name: "index_seasons_on_show_id", using: :btree
  add_index "seasons", ["tmdb_id"], name: "index_seasons_on_tmdb_id", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_token", null: false
    t.integer  "user_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id", using: :btree

  create_table "shows", force: true do |t|
    t.string   "name",              null: false
    t.text     "description"
    t.boolean  "in_production",     null: false
    t.date     "release_date"
    t.string   "poster_image_path"
    t.string   "created_by"
    t.integer  "tmdb_id",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "shows", ["slug"], name: "index_shows_on_slug", using: :btree

  create_table "user_shows", force: true do |t|
    t.integer  "user_id"
    t.integer  "show_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_shows", ["show_id"], name: "index_user_shows_on_show_id", using: :btree
  add_index "user_shows", ["user_id"], name: "index_user_shows_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
