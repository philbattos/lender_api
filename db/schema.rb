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

ActiveRecord::Schema.define(version: 20151226190053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sms", force: :cascade do |t|
    t.string   "from"
    t.string   "to"
    t.string   "body"
    t.string   "to_zip"
    t.string   "to_city"
    t.string   "to_state"
    t.string   "to_country"
    t.string   "from_zip"
    t.string   "from_city"
    t.string   "from_state"
    t.string   "from_country"
    t.string   "sms_status"
    t.string   "sms_message_sid"
    t.string   "sms_sid"
    t.string   "message_sid"
    t.string   "account_sid"
    t.string   "num_media"
    t.string   "num_segments"
    t.string   "api_version"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "peer_id"
    t.string   "terms"
    t.decimal  "amount"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transactions", ["user_id", "peer_id"], name: "index_transactions_on_user_id_and_peer_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
