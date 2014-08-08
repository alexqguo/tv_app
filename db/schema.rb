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

ActiveRecord::Schema.define(version: 20140808165319) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "seasons", force: true do |t|
    t.integer  "season_number", null: false
    t.integer  "show_id",       null: false
    t.integer  "tmdb_id",       null: false
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
  end

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
