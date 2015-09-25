# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150925063329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "payments", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "price"
    t.string   "receipt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "short_description"
    t.text     "long_description"
    t.string   "product_image"
    t.string   "product_file"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "publishable_key"
    t.string   "secret_key"
    t.string   "stripe_user_id"
  end

end
