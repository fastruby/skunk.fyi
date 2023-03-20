# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_03_20_185535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analyzed_files", force: :cascade do |t|
    t.bigint "report_id"
    t.string "name"
    t.decimal "skunk_score", precision: 8, scale: 2
    t.decimal "churn_times_cost", precision: 8, scale: 2
    t.decimal "churn", precision: 8, scale: 2
    t.decimal "cost", precision: 8, scale: 2
    t.decimal "coverage", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["report_id"], name: "index_analyzed_files_on_report_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "git_url"
    t.string "permalink"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["permalink"], name: "index_projects_on_permalink", unique: true
  end

  create_table "reports", id: :serial, force: :cascade do |t|
    t.text "report"
    t.boolean "compare"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.bigint "project_id"
    t.index ["project_id"], name: "index_reports_on_project_id"
    t.index ["slug"], name: "index_reports_on_slug", unique: true
  end

  add_foreign_key "reports", "projects"
end
