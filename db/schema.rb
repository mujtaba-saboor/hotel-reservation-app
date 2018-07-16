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

ActiveRecord::Schema.define(version: 20180716101424) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "hotels", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.string   "country",              limit: 255
    t.string   "city",                 limit: 255
    t.string   "street",               limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "picture",              limit: 255
    t.string   "picture_file_name",    limit: 255
    t.string   "picture_content_type", limit: 255
    t.integer  "picture_file_size",    limit: 4
    t.datetime "picture_updated_at"
  end

  create_table "payments", force: :cascade do |t|
    t.string   "full_name",      limit: 255
    t.integer  "telephone",      limit: 4
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "card_token",     limit: 255
    t.integer  "user_id",        limit: 4
    t.integer  "reservation_id", limit: 4
    t.decimal  "amount",                     precision: 10
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "date_from"
    t.datetime "date_to"
    t.integer  "user_id",    limit: 4
    t.integer  "room_id",    limit: 4
    t.integer  "hotel_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "booked",     limit: 1
  end

  add_index "reservations", ["hotel_id"], name: "index_reservations_on_hotel_id", using: :btree
  add_index "reservations", ["room_id"], name: "index_reservations_on_room_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.decimal  "price",                  precision: 10
    t.integer  "hotel_id",   limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "room_no",    limit: 255
    t.string   "category",   limit: 255
  end

  add_index "rooms", ["hotel_id"], name: "index_rooms_on_hotel_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",  null: false
    t.string   "encrypted_password",     limit: 255, default: "",  null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,   null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.string   "name",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   limit: 255, default: "0"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "reservations", "hotels"
  add_foreign_key "reservations", "rooms"
  add_foreign_key "reservations", "users"
  add_foreign_key "rooms", "hotels"
end
