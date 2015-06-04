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

ActiveRecord::Schema.define(version: 20150603214423) do

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "description"
    t.text     "summary"
  end

  add_index "games", ["name"], name: "index_games_on_name", unique: true
  add_index "games", ["slug"], name: "index_games_on_slug", unique: true

  create_table "members", force: :cascade do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "biography"
    t.string   "handle"
    t.string   "email"
    t.string   "password_digest"
    t.string   "rank"
    t.string   "role"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "members", ["handle"], name: "index_members_on_handle", unique: true

end
