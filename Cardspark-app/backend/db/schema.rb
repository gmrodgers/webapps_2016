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

ActiveRecord::Schema.define(version: 20160527021125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.integer "topic_id"
    t.string  "filename"
    t.binary  "card_file"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
  end

  create_table "topics_users", id: false, force: :cascade do |t|
    t.integer "topic_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "topics_users", ["topic_id", "user_id"], name: "index_topics_users_on_topic_id_and_user_id", using: :btree
  add_index "topics_users", ["user_id", "topic_id"], name: "index_topics_users_on_user_id_and_topic_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_hash"
  end

end
