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

ActiveRecord::Schema.define(version: 20150625060953) do

  create_table "albums", force: :cascade do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "picture_id"
  end

  add_index "albums", ["picture_id"], name: "index_albums_on_picture_id"
  add_index "albums", ["user_id"], name: "index_albums_on_user_id"

  create_table "pictures", force: :cascade do |t|
    t.string  "name"
    t.integer "album_id"
    t.integer "year"
    t.string  "color"
    t.text    "description"
    t.string  "image_uid"
    t.string  "image_name"
  end

  add_index "pictures", ["album_id"], name: "index_pictures_on_album_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "avatar_uid"
    t.string   "avatar_name"
    t.boolean  "admin"
  end

end
