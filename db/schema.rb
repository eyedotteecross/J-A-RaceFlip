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

ActiveRecord::Schema.define(version: 5) do

  create_table "cars", force: :cascade do |t|
    t.string "make"
    t.string "model"
    t.integer "value"
    t.integer "top_speed"
  end

  create_table "races", force: :cascade do |t|
    t.integer "prize"
    t.string "result"
    t.integer "user_id"
  end

  create_table "user_cars", force: :cascade do |t|
    t.integer "condition"
    t.integer "user_id"
    t.integer "car_id"
    t.integer "uc_top_speed"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "balance"
    t.integer "wins"
    t.integer "losses"
    t.integer "num_cars"
  end

end
