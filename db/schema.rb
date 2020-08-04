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

ActiveRecord::Schema.define(version: 2020_07_30_165842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "login_name", null: false
    t.string "password_digest"
    t.string "admin_name", null: false
    t.integer "dspo", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "lower((login_name)::text)", name: "index_admins_on_LOWER_login_name", unique: true
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.integer "quantity", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "trader_id"
    t.index ["item_id"], name: "index_cart_items_on_item_id"
    t.index ["trader_id"], name: "index_cart_items_on_trader_id"
    t.index ["user_id"], name: "index_cart_items_on_user_id"
  end

  create_table "charges", force: :cascade do |t|
    t.integer "price_from"
    t.integer "price_to"
    t.integer "charge", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "diary_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["diary_id"], name: "index_comments_on_diary_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.string "coupon_code"
    t.bigint "admin_id", null: false
    t.bigint "user_id"
    t.integer "point", default: 0, null: false
    t.bigint "order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_coupons_on_admin_id"
    t.index ["order_id"], name: "index_coupons_on_order_id"
    t.index ["user_id"], name: "index_coupons_on_user_id"
  end

  create_table "delivery_periods", force: :cascade do |t|
    t.integer "hour_from", null: false
    t.integer "hour_to", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "diaries", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.string "picture"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "goods", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "diary_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["diary_id"], name: "index_goods_on_diary_id"
    t.index ["user_id", "diary_id"], name: "index_goods_on_user_id_and_diary_id", unique: true
    t.index ["user_id"], name: "index_goods_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "item_name", null: false
    t.string "picture"
    t.integer "price", null: false
    t.text "description"
    t.boolean "disabled", default: false, null: false
    t.integer "dspo", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "item_id"
    t.integer "quantity", null: false
    t.string "item_name"
    t.string "picture"
    t.integer "price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "delivery_date"
    t.bigint "delivery_period_id"
    t.integer "item_price", null: false
    t.integer "charge_price", null: false
    t.integer "shipping_price", null: false
    t.integer "tax_price", null: false
    t.string "ship_zip", null: false
    t.string "ship_address", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "trader_id"
    t.index ["delivery_period_id"], name: "index_orders_on_delivery_period_id"
    t.index ["trader_id"], name: "index_orders_on_trader_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "trader_id", null: false
    t.bigint "item_id", null: false
    t.bigint "order_id"
    t.integer "stock_number", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_stocks_on_item_id"
    t.index ["order_id"], name: "index_stocks_on_order_id"
    t.index ["trader_id"], name: "index_stocks_on_trader_id"
  end

  create_table "traders", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "trader_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "lower((email)::text)", name: "index_traders_on_LOWER_email", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "user_name"
    t.string "zip"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.string "picture"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cart_items", "items"
  add_foreign_key "cart_items", "traders"
  add_foreign_key "cart_items", "users"
  add_foreign_key "comments", "diaries"
  add_foreign_key "comments", "users"
  add_foreign_key "coupons", "admins"
  add_foreign_key "coupons", "orders"
  add_foreign_key "coupons", "users"
  add_foreign_key "diaries", "users"
  add_foreign_key "goods", "diaries"
  add_foreign_key "goods", "users"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "delivery_periods"
  add_foreign_key "orders", "traders"
  add_foreign_key "orders", "users"
  add_foreign_key "stocks", "items"
  add_foreign_key "stocks", "orders"
  add_foreign_key "stocks", "traders"
end
