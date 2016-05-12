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

ActiveRecord::Schema.define(version: 20160512144849) do

  create_table "announcements", force: :cascade do |t|
    t.text     "body",       limit: 16777215
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "badges_sashes", force: :cascade do |t|
    t.integer  "badge_id",      limit: 4
    t.integer  "sash_id",       limit: 4
    t.boolean  "notified_user", limit: 1, default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id", using: :btree
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id", using: :btree
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id", using: :btree

  create_table "basics", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.string   "flag",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content",    limit: 65535
  end

  create_table "cryptos", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.string   "flag",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content",    limit: 65535
  end

  create_table "hints", force: :cascade do |t|
    t.string   "cate",       limit: 255
    t.string   "hint",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.string   "oauth_token",      limit: 255
    t.string   "oauth_secret",     limit: 255
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "indicators", force: :cascade do |t|
    t.boolean "value", limit: 1, default: false
  end

  create_table "majors", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "merit_actions", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "action_method", limit: 255
    t.integer  "action_value",  limit: 4
    t.boolean  "had_errors",    limit: 1,        default: false
    t.string   "target_model",  limit: 255
    t.integer  "target_id",     limit: 4
    t.text     "target_data",   limit: 16777215
    t.boolean  "processed",     limit: 1,        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: :cascade do |t|
    t.integer  "action_id",           limit: 4
    t.string   "related_change_type", limit: 191
    t.integer  "related_change_id",   limit: 4
    t.string   "description",         limit: 255
    t.datetime "created_at"
  end

  add_index "merit_activity_logs", ["action_id"], name: "index_merit_activity_logs_on_action_id", using: :btree
  add_index "merit_activity_logs", ["related_change_id", "related_change_type"], name: "index_merit_activity_logs_on_rcid_and_rctype", using: :btree

  create_table "merit_score_points", force: :cascade do |t|
    t.integer  "score_id",   limit: 4
    t.integer  "num_points", limit: 4,   default: 0
    t.string   "log",        limit: 255
    t.datetime "created_at"
  end

  add_index "merit_score_points", ["score_id"], name: "index_merit_score_points_on_score_id", using: :btree

  create_table "merit_scores", force: :cascade do |t|
    t.integer "sash_id",  limit: 4
    t.string  "category", limit: 255
  end

  add_index "merit_scores", ["sash_id"], name: "index_merit_scores_on_sash_id", using: :btree

  create_table "news", force: :cascade do |t|
    t.string   "messages", limit: 255
    t.datetime "date"
  end

  create_table "pwns", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.string   "flag",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content",    limit: 65535
  end

  create_table "qnas", force: :cascade do |t|
    t.string   "question",   limit: 255
    t.string   "answer",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     limit: 4,   default: 0
  end

  create_table "records", force: :cascade do |t|
    t.string   "cate",          limit: 255
    t.boolean  "solved",        limit: 1,   default: false
    t.integer  "user_id",       limit: 4
    t.datetime "last_try_time"
    t.datetime "finish_time"
    t.integer  "score",         limit: 8,   default: 0
    t.string   "tag",           limit: 255
  end

  add_index "records", ["user_id"], name: "index_records_on_user_id", using: :btree

  create_table "reverses", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.string   "flag",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content",    limit: 65535
  end

  create_table "sashes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 191
    t.text     "data",       limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string  "tag",    limit: 255
    t.boolean "active", limit: 1,   default: false
  end

  create_table "sexes", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 191
    t.string   "encrypted_password",     limit: 255
    t.string   "reset_password_token",   limit: 191
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.integer  "major_id",               limit: 4
    t.integer  "sex_id",                 limit: 4
    t.integer  "score",                  limit: 4,   default: 0
    t.datetime "last_submit_time"
    t.string   "time_zone",              limit: 255
    t.boolean  "admin",                  limit: 1,   default: false
    t.integer  "sash_id",                limit: 4
    t.integer  "level",                  limit: 4,   default: 0
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.integer  "port",                   limit: 8
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["major_id"], name: "index_users_on_major_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["sash_id"], name: "index_users_on_sash_id", using: :btree
  add_index "users", ["score"], name: "index_users_on_score", using: :btree
  add_index "users", ["sex_id"], name: "index_users_on_sex_id", using: :btree

  create_table "webs", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.string   "subdomain",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "db",         limit: 255
    t.text     "content",    limit: 65535
  end

end
