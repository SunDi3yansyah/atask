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

ActiveRecord::Schema[7.0].define(version: 2023_11_06_061140) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "transfers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "from"
    t.bigint "to"
    t.string "code"
    t.decimal "amount", precision: 26, scale: 2
    t.string "status"
    t.index ["from"], name: "index_transfers_on_from"
    t.index ["to"], name: "index_transfers_on_to"
  end

  create_table "user_tokens", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "token"
    t.string "refresh_token"
    t.datetime "expired_at"
    t.string "user_agent"
    t.index ["user_id"], name: "index_user_tokens_on_user_id"
  end

  create_table "user_wallets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "assignable_type"
    t.bigint "assignable_id"
    t.string "in_out"
    t.string "description"
    t.decimal "amount", precision: 26, scale: 2
    t.decimal "total", precision: 26, scale: 2
    t.index ["assignable_type", "assignable_id"], name: "index_user_wallets_on_assignable"
    t.index ["user_id"], name: "index_user_wallets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "password_digest"
  end

  create_table "withdrawals", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "code"
    t.decimal "amount", precision: 26, scale: 2
    t.string "bank_name"
    t.string "bank_account_number"
    t.string "bank_account_name"
    t.string "status"
    t.index ["user_id"], name: "index_withdrawals_on_user_id"
  end

  add_foreign_key "user_tokens", "users"
  add_foreign_key "user_wallets", "users"
  add_foreign_key "withdrawals", "users"
end
