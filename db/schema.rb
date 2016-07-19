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

ActiveRecord::Schema.define(version: 20160718191453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "endorsements", force: :cascade do |t|
    t.string   "office"
    t.string   "candidate_name"
    t.string   "jurisdiction"
    t.text     "explanation"
    t.boolean  "highlight"
    t.integer  "voter_guide_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["voter_guide_id"], name: "index_endorsements_on_voter_guide_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.json     "auth_hash"
    t.string   "email"
    t.string   "image"
    t.string   "name"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "voter_guides", force: :cascade do |t|
    t.string   "name"
    t.string   "target_city"
    t.string   "target_state"
    t.date     "election_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "author_id"
    t.index ["author_id"], name: "index_voter_guides_on_author_id", using: :btree
  end

  add_foreign_key "endorsements", "voter_guides"
  add_foreign_key "voter_guides", "users", column: "author_id"
end
