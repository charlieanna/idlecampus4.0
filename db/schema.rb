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

ActiveRecord::Schema.define(version: 20131011200009) do

  create_table "ASAS", force: true do |t|
    t.text    "name", limit: 20
    t.integer "P_Id"
  end

  create_table "batches", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "class_timings", force: true do |t|
    t.integer  "to_minutes"
    t.integer  "to_hours"
    t.integer  "from_hours"
    t.integer  "from_minutes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cvzxc", force: true do |t|
    t.text    "name", limit: 20
    t.integer "P_Id"
  end

  create_table "dasdas", force: true do |t|
    t.text    "name", limit: 20
    t.integer "P_Id"
  end

  create_table "eqwe", force: true do |t|
    t.text    "name", limit: 20
    t.integer "P_Id"
  end

  create_table "erew", force: true do |t|
    t.text    "name", limit: 20
    t.integer "P_Id"
  end

  create_table "ewqeqw", force: true do |t|
    t.text    "name", limit: 20
    t.integer "P_Id"
  end

  create_table "ewrwe", force: true do |t|
    t.text    "name", limit: 20
    t.integer "P_Id"
  end

  create_table "field9", force: true do |t|
    t.text    "name", limit: 20
    t.integer "P_Id"
  end

  create_table "fields", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fields_timetables", force: true do |t|
    t.integer  "field_id"
    t.integer  "timetable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fsfdsf", force: true do |t|
    t.text    "name", limit: 20
    t.integer "P_Id"
  end

  create_table "group_memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_memberships", ["group_id"], name: "index_group_memberships_on_group_id"
  add_index "group_memberships", ["user_id", "group_id"], name: "index_group_memberships_on_user_id_and_group_id"
  add_index "group_memberships", ["user_id"], name: "index_group_memberships_on_user_id"

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "group_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "owner_id"
  end

  add_index "groups", ["owner_id"], name: "index_groups_on_owner_id"
  add_index "groups", ["user_id"], name: "index_groups_on_user_id"

  create_table "readc", force: true do |t|
    t.text    "name", limit: 20
    t.integer "P_Id"
  end

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sdsad", force: true do |t|
    t.text    "name", limit: 20
    t.integer "P_Id"
  end

  create_table "sdsadsa", force: true do |t|
    t.text    "name", limit: 20
    t.integer "P_Id"
  end

  create_table "small_groups", force: true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teacherss", force: true do |t|
    t.text    "name", limit: 20
    t.integer "P_Id"
  end

  create_table "timetable_entries", force: true do |t|
    t.integer  "timetable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weekday_id"
    t.integer  "class_timing_id"
    t.integer  "small_group_id"
    t.integer  "subject_id"
    t.integer  "teacher_id"
  end

  create_table "timetables", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "jabber_id"
    t.string   "device_identifier"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "weekdays", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wqeqw", force: true do |t|
    t.text    "name", limit: 20
    t.integer "P_Id"
  end

end
