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

ActiveRecord::Schema[7.0].define(version: 2025_04_30_144023) do
  create_table "beans", force: :cascade do |t|
    t.string "name"
    t.string "origin"
    t.string "process"
    t.string "roastlevel"
    t.float "rating"
    t.boolean "decaf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_beans_on_user_id"
  end

  create_table "brews", force: :cascade do |t|
    t.float "cofamount"
    t.float "watamount"
    t.string "method"
    t.float "grindsetting"
    t.integer "temperature"
    t.integer "extractiontime"
    t.float "ratingbrew"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.float "brewresult"
    t.integer "bean_id", null: false
    t.index ["bean_id"], name: "index_brews_on_bean_id"
    t.index ["user_id"], name: "index_brews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "beans", "users"
  add_foreign_key "brews", "beans"
  add_foreign_key "brews", "users"
end
