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

ActiveRecord::Schema.define(version: 20150821183808) do

  create_table "background_images", force: :cascade do |t|
    t.integer  "backgroundable_id"
    t.string   "backgroundable_type"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "background_images", ["backgroundable_type", "backgroundable_id"], name: "index_background_images_on_polymorphic_backgroundable"

  create_table "external_links", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "site"
    t.string   "fragment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "external_links", ["member_id"], name: "index_external_links_on_member_id"

  create_table "game_memberships", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "game_memberships", ["game_id"], name: "index_game_memberships_on_game_id"
  add_index "game_memberships", ["member_id"], name: "index_game_memberships_on_member_id"

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
    t.boolean  "featured"
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
    t.string   "rank",                default: "general"
    t.string   "role",                default: "user"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "members", ["handle"], name: "index_members_on_handle", unique: true

  create_table "news_posts", force: :cascade do |t|
    t.string   "title"
    t.integer  "member_id"
    t.integer  "game_id"
    t.text     "short_body"
    t.text     "long_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "news_posts", ["game_id"], name: "index_news_posts_on_game_id"
  add_index "news_posts", ["member_id"], name: "index_news_posts_on_member_id"

  create_table "videos", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "member_id"
    t.string   "fragment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "videos", ["game_id"], name: "index_videos_on_game_id"
  add_index "videos", ["member_id"], name: "index_videos_on_member_id"

end
