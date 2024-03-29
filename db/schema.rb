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

ActiveRecord::Schema.define(version: 20131207115839) do

  create_table "alerts", force: true do |t|
    t.string   "message"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerts", ["group_id"], name: "index_alerts_on_group_id"

  create_table "batches", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "class_timings", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "from"
    t.time     "to"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "documents", force: true do |t|
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["folder_id"], name: "index_documents_on_folder_id"

  create_table "folders", force: true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
  end

  add_index "folders", ["group_id"], name: "index_folders_on_group_id"

  create_table "follows", force: true do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows"

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
    t.string   "slug"
  end

  add_index "groups", ["owner_id"], name: "index_groups_on_owner_id"
  add_index "groups", ["slug"], name: "index_groups_on_slug"
  add_index "groups", ["user_id"], name: "index_groups_on_user_id"

  create_table "locations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
    t.integer  "group_id"
    t.text     "content"
    t.text     "message"
  end

  add_index "notes", ["group_id"], name: "index_notes_on_group_id"

  create_table "posts", force: true do |t|
    t.integer  "article_id"
    t.string   "article_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["article_id", "article_type"], name: "index_posts_on_article_id_and_article_type"

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.integer  "timetable_id"
  end

  add_index "rooms", ["group_id"], name: "index_rooms_on_group_id"
  add_index "rooms", ["timetable_id"], name: "index_rooms_on_timetable_id"

  create_table "small_groups", force: true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.integer "user_id"
  end

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.integer  "timetable_id"
  end

  add_index "subjects", ["group_id"], name: "index_subjects_on_group_id"
  add_index "subjects", ["timetable_id"], name: "index_subjects_on_timetable_id"

  create_table "teachers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.integer  "timetable_id"
  end

  add_index "teachers", ["group_id"], name: "index_teachers_on_group_id"
  add_index "teachers", ["timetable_id"], name: "index_teachers_on_timetable_id"

  create_table "timetable_entries", force: true do |t|
    t.integer  "timetable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weekday_id"
    t.integer  "class_timing_id"
    t.integer  "small_group_id"
    t.integer  "subject_id"
    t.integer  "teacher_id"
    t.integer  "location_id"
    t.integer  "room_id"
  end

  add_index "timetable_entries", ["timetable_id"], name: "index_timetable_entries_on_timetable_id"

  create_table "timetable_field_values", force: true do |t|
    t.string   "name"
    t.integer  "timetable_field_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timetable_fields", force: true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "timetable_id"
  end

  create_table "timetables", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  add_index "timetables", ["group_id"], name: "index_timetables_on_group_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "jabber_id"
    t.string   "device_identifier",      default: "web"
    t.string   "remember_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "member_id"
    t.string   "member_type"
    t.integer  "rolable_id"
    t.string   "rolable_type"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["jabber_id"], name: "index_users_on_jabber_id"
  add_index "users", ["name"], name: "index_users_on_name", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "weekdays", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
