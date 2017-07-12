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

ActiveRecord::Schema.define(version: 20170711024125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title",         default: ""
    t.text     "description",   default: ""
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "profession_id", default: 0,  null: false
  end

  create_table "client_reviews", force: :cascade do |t|
    t.integer  "job_id",     default: 0, null: false
    t.float    "score"
    t.text     "notes"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "deposits", force: :cascade do |t|
    t.float    "amount"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "token"
    t.string   "ip"
    t.string   "payer_id"
  end

  create_table "freelancer_reviews", force: :cascade do |t|
    t.integer  "job_id",     default: 0, null: false
    t.float    "score"
    t.text     "notes"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "title",         default: ""
    t.integer  "price",         default: 0
    t.text     "description",   default: ""
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id",       default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "category_ids"
    t.string   "postcode",      default: ""
    t.integer  "profession_id", default: 0
    t.integer  "status",        default: 0,  null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer  "freelancer_id"
    t.json     "attachments"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "title",      default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.json     "attachments"
    t.index ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "portfolios", force: :cascade do |t|
    t.string   "title"
    t.text     "overview"
    t.integer  "profession_id"
    t.string   "category_ids"
    t.date     "completion_date"
    t.integer  "user_id"
    t.string   "image"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "professions", force: :cascade do |t|
    t.string   "title",      default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "proposals", force: :cascade do |t|
    t.integer  "job_id",                   null: false
    t.integer  "price",       default: 0
    t.text     "description", default: ""
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id",     default: 0,  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.json     "attachments"
  end

  create_table "transactions", force: :cascade do |t|
    t.float    "amount"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "job_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name",             default: ""
    t.string   "last_name",              default: ""
    t.date     "birthday"
    t.integer  "user_type",              default: 0
    t.string   "image",                  default: ""
    t.string   "country",                default: ""
    t.string   "title",                  default: ""
    t.integer  "location_id"
    t.string   "postcode",               default: ""
    t.text     "overview",               default: ""
    t.text     "skills"
    t.integer  "profession_id"
    t.string   "get_paid_email"
    t.boolean  "email_confirmed"
    t.string   "confirm_token"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "withdraws", force: :cascade do |t|
    t.float    "amount"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
  end

end
