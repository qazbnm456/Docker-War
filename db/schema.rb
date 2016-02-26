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

ActiveRecord::Schema.define(version: 20160209151526) do

  create_table "announcements", force: :cascade do |t|
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "badges_sashes", force: :cascade do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id"
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id"
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id"

  create_table "basics", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.string   "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cryptos", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.string   "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forensics", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.string   "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id"

  create_table "indicators", force: :cascade do |t|
    t.boolean "value", default: false
  end

  create_table "majors", force: :cascade do |t|
    t.string "name"
  end

  create_table "merit_actions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.text     "target_data"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: :cascade do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  add_index "merit_activity_logs", ["action_id"], name: "index_merit_activity_logs_on_action_id"
  add_index "merit_activity_logs", ["related_change_id", "related_change_type"], name: "index_merit_activity_logs_on_rcid_and_rctype"

  create_table "merit_score_points", force: :cascade do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  add_index "merit_score_points", ["score_id"], name: "index_merit_score_points_on_score_id"

  create_table "merit_scores", force: :cascade do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  add_index "merit_scores", ["sash_id"], name: "index_merit_scores_on_sash_id"

  create_table "news", force: :cascade do |t|
    t.string   "messages"
    t.datetime "date"
  end

  create_table "qnas", force: :cascade do |t|
    t.string   "question"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     default: 0
  end

  create_table "records", force: :cascade do |t|
    t.string   "cate"
    t.boolean  "solved",                  default: false
    t.integer  "user_id"
    t.datetime "last_try_time"
    t.datetime "finish_time"
    t.integer  "score",         limit: 5, default: 0
    t.string   "tag",                                     null: false
  end

  add_index "records", ["user_id"], name: "index_records_on_user_id"

  create_table "reverses", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.string   "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sashes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "settings", force: :cascade do |t|
    t.string  "tag",                    null: false
    t.boolean "active", default: false
  end

  create_table "sexes", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                            default: "",       null: false
    t.string   "encrypted_password",               default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "major_id"
    t.integer  "sex_id"
    t.integer  "score",                            default: 0
    t.datetime "last_submit_time"
    t.string   "time_zone",                        default: "Taipei"
    t.boolean  "admin",                            default: false
    t.integer  "sash_id"
    t.integer  "level",                            default: 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "port",                   limit: 5
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["major_id"], name: "index_users_on_major_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["sash_id"], name: "index_users_on_sash_id"
  add_index "users", ["score"], name: "index_users_on_score"
  add_index "users", ["sex_id"], name: "index_users_on_sex_id"

  create_table "webs", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.string   "subdomain"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "db"
  end

end
