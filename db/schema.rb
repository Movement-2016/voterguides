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

ActiveRecord::Schema.define(version: 20160819011226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "elections", force: :cascade do |t|
    t.string   "name"
    t.date     "election_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "email_confirmations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "confirmation_code"
    t.string   "email"
    t.datetime "confirmed_at"
    t.index ["confirmation_code"], name: "index_email_confirmations_on_confirmation_code", unique: true, using: :btree
    t.index ["user_id", "email"], name: "index_email_confirmations_on_user_id_and_email", using: :btree
    t.index ["user_id"], name: "index_email_confirmations_on_user_id", using: :btree
  end

  create_table "endorsements", force: :cascade do |t|
    t.string   "office"
    t.string   "candidate_name"
    t.string   "jurisdiction"
    t.text     "explanation"
    t.boolean  "highlight"
    t.integer  "voter_guide_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "guide_order",    null: false
    t.string   "initiative"
    t.boolean  "recommendation"
    t.index ["voter_guide_id"], name: "index_endorsements_on_voter_guide_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string "zipcode", limit: 5
    t.string "city"
    t.string "county"
    t.string "state",   limit: 2
    t.index ["state"], name: "index_locations_on_state", using: :btree
    t.index ["zipcode"], name: "index_locations_on_zipcode", using: :btree
  end

  create_table "supporters", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "voter_guide_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["user_id"], name: "index_supporters_on_user_id", using: :btree
    t.index ["voter_guide_id"], name: "index_supporters_on_voter_guide_id", using: :btree
  end

  create_table "unsubscribe_options", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "code"
    t.datetime "requested_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["code"], name: "index_unsubscribe_options_on_code", using: :btree
    t.index ["email"], name: "index_unsubscribe_options_on_email", using: :btree
    t.index ["user_id"], name: "index_unsubscribe_options_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.json     "auth_hash"
    t.string   "email"
    t.string   "image"
    t.string   "name"
    t.string   "uid"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "admin"
    t.datetime "suspended_at"
    t.string   "secure_id",    limit: 12, null: false
    t.index ["secure_id"], name: "index_users_on_secure_id", using: :btree
  end

  create_table "voter_guides", force: :cascade do |t|
    t.string   "name"
    t.string   "target_city"
    t.string   "target_state"
    t.date     "election_date"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "author_id"
    t.string   "external_guide_url"
    t.datetime "published_at"
    t.integer  "supporters_count"
    t.text     "description"
    t.datetime "recommended_at"
    t.string   "secure_id",          limit: 12, null: false
    t.index ["author_id"], name: "index_voter_guides_on_author_id", using: :btree
    t.index ["recommended_at"], name: "index_voter_guides_on_recommended_at", using: :btree
    t.index ["secure_id"], name: "index_voter_guides_on_secure_id", using: :btree
  end

  add_foreign_key "email_confirmations", "users"
  add_foreign_key "endorsements", "voter_guides"
  add_foreign_key "supporters", "users"
  add_foreign_key "supporters", "voter_guides"
  add_foreign_key "unsubscribe_options", "users"
  add_foreign_key "voter_guides", "users", column: "author_id"
end
