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

ActiveRecord::Schema.define(version: 20191204160347) do

  create_table "basket_joins", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.integer "quantity"
  end

  create_table "order_product_joins", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.string  "product_name"
    t.decimal "purchase_price"
    t.string  "product_description"
    t.integer "quantity"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "address"
    t.decimal  "total_cost"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_tags", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.integer  "stock_count"
    t.integer  "user_id"
    t.string   "img_url",     default: "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=2ahUKEwiw9OmjopzmAhWrBGMBHX3xCGsQjRx6BAgBEAQ&url=https%3A%2F%2Fwww.freeiconspng.com%2Fimg%2F23490&psig=AOvVaw081xXbG9NKsqiUjwL-726Z&ust=1575558324998221"
    t.datetime "created_at",                                                                                                                                                                                                                                             null: false
    t.datetime "updated_at",                                                                                                                                                                                                                                             null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "security_question"
    t.string   "security_answer"
  end

end
