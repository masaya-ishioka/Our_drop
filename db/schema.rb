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

ActiveRecord::Schema.define(version: 2019_01_10_061654) do

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.integer "user_id"
    t.integer "sound_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "like_sounds", force: :cascade do |t|
    t.integer "user_id"
    t.integer "sound_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "like_users", force: :cascade do |t|
    t.integer "my_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sounds", force: :cascade do |t|
    t.string "url"
    t.string "title"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tag1"
    t.string "tag2"
    t.string "tag3"
    t.text "sound_text"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_id"
    t.boolean "admin"
    t.string "password_digest"
    t.text "user_text"
    t.string "facebook"
    t.string "twitter"
    t.string "instagram"
    t.string "youtube"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.boolean "active", default: false
  end

end
