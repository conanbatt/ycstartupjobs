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

ActiveRecord::Schema.define(version: 20170621014516) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "fuzzystrmatch"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "jobs_url"
    t.string "logo"
    t.string "yc_class"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_companies_on_name"
    t.index ["url"], name: "index_companies_on_url"
  end

  create_table "job_openings", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.string "commitment"
    t.string "team"
    t.string "description"
    t.string "salary"
    t.string "url"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_job_openings_on_company_id"
    t.index ["team"], name: "index_job_openings_on_team"
    t.index ["url"], name: "index_job_openings_on_url"
  end

end
