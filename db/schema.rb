# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_10_150826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fabrics", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "project_id", null: false
    t.index ["project_id"], name: "index_fabrics_on_project_id"
  end

  create_table "garment_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "measurements", force: :cascade do |t|
    t.integer "bust"
    t.integer "waist"
    t.integer "hip"
    t.integer "year"
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_measurements_on_user_id"
  end

  create_table "patterns", force: :cascade do |t|
    t.string "title"
    t.string "designer"
    t.string "fabric_type"
    t.string "pattern_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "garment_category"
    t.text "notes"
    t.bigint "user_id"
    t.bigint "garment_category_id", null: false
    t.index ["garment_category_id"], name: "index_patterns_on_garment_category_id"
    t.index ["user_id"], name: "index_patterns_on_user_id"
  end

  create_table "project_fabrics", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "fabric_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fabric_id"], name: "index_project_fabrics_on_fabric_id"
    t.index ["project_id"], name: "index_project_fabrics_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "pattern_id"
    t.string "size"
    t.index ["pattern_id"], name: "index_projects_on_pattern_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "shopping_items", force: :cascade do |t|
    t.bigint "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.bigint "user_id", null: false
    t.boolean "bought", default: false
    t.index ["project_id"], name: "index_shopping_items_on_project_id"
    t.index ["user_id"], name: "index_shopping_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "fabrics", "projects"
  add_foreign_key "measurements", "users"
  add_foreign_key "patterns", "garment_categories"
  add_foreign_key "patterns", "users"
  add_foreign_key "project_fabrics", "fabrics"
  add_foreign_key "project_fabrics", "projects"
  add_foreign_key "projects", "patterns"
  add_foreign_key "projects", "users"
  add_foreign_key "shopping_items", "projects"
  add_foreign_key "shopping_items", "users"
end
