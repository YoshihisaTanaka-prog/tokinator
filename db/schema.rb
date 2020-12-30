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

ActiveRecord::Schema.define(version: 2020_12_30_051345) do

  create_table "c_counts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "count", default: 0, null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "user_attribute"
    t.integer "access_count", default: 0, null: false
    t.integer "score_count", default: 0, null: false
    t.decimal "average_score"
    t.time "start"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "r_counts", force: :cascade do |t|
    t.integer "route_id"
    t.integer "count", default: 0, null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "routes", force: :cascade do |t|
    t.string "before_id"
    t.string "next_title_name"
    t.string "table_name"
    t.string "after_id"
    t.text "comment", default: "", null: false
    t.integer "strength", default: 0, null: false
    t.integer "group", default: 0, null: false
    t.integer "total_accessed", default: 0, null: false
    t.time "total_accessed_start"
    t.integer "j1_accessed", default: 0, null: false
    t.integer "j1_score", default: 0, null: false
    t.time "j1_start"
    t.integer "j2_accessed", default: 0, null: false
    t.integer "j2_score", default: 0, null: false
    t.time "j2_start"
    t.integer "j3_accessed", default: 0, null: false
    t.integer "j3_score", default: 0, null: false
    t.time "j3_start"
    t.integer "h1s_accessed", default: 0, null: false
    t.integer "h1s_score", default: 0, null: false
    t.time "h1s_start"
    t.integer "h2s_accessed", default: 0, null: false
    t.integer "h2s_score", default: 0, null: false
    t.time "h2s_start"
    t.integer "h3s_accessed", default: 0, null: false
    t.integer "h3s_score", default: 0, null: false
    t.time "h3s_start"
    t.integer "h1h_accessed", default: 0, null: false
    t.integer "h1h_score", default: 0, null: false
    t.time "h1h_start"
    t.integer "h2h_accessed", default: 0, null: false
    t.integer "h2h_score", default: 0, null: false
    t.time "h2h_start"
    t.integer "h3h_accessed", default: 0, null: false
    t.integer "h3h_score", default: 0, null: false
    t.time "h3h_start"
    t.integer "h1n_accessed", default: 0, null: false
    t.integer "h1n_score", default: 0, null: false
    t.time "h1n_start"
    t.integer "h2n_accessed", default: 0, null: false
    t.integer "h2n_score", default: 0, null: false
    t.time "h2n_start"
    t.integer "h3n_accessed", default: 0, null: false
    t.integer "h3n_score", default: 0, null: false
    t.time "h3n_start"
    t.integer "const_ructing", default: 0, null: false
    t.time "constructing_accessed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
  end

  create_table "support_chats", force: :cascade do |t|
    t.integer "customer_id"
    t.boolean "isFromI"
    t.text "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "u_counts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "count", default: 0, null: false
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "level", default: 0, null: false
    t.datetime "request_levelup_at"
    t.integer "edit_route_count", default: 0, null: false
    t.time "edit_route_count_start"
    t.integer "edit_goal_count", default: 0, null: false
    t.time "edit_goal_count_start"
    t.integer "support_count", default: 0, null: false
    t.time "support_count_start"
    t.time "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
