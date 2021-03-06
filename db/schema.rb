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

ActiveRecord::Schema.define(version: 20200804202451) do

  create_table "goals", force: :cascade do |t|
    t.float   "start_weight"
    t.float   "start_bodyfat"
    t.float   "weight_goal"
    t.float   "body_fat_goal"
    t.integer "start_calorie_goal"
    t.integer "user_id"
  end

  create_table "logs", force: :cascade do |t|
    t.integer "worked_out"
    t.integer "tracked_food"
    t.float   "weight"
    t.float   "body_fat"
    t.integer "active_calories"
    t.integer "calories"
    t.integer "points_worked_out"
    t.integer "points_tracked_food"
    t.integer "points_met_calorie_goal"
    t.integer "points_maintain_weight"
    t.integer "points_maintain_bodyfat"
    t.integer "points_met_active_calories"
    t.integer "total_points"
    t.integer "user_id"
    t.string  "date"
  end

  create_table "points", force: :cascade do |t|
    t.integer "points_worked_out"
    t.integer "points_tracked_food"
    t.integer "points_met_calorie_goal"
    t.integer "points_maintain_weight"
    t.integer "points_maintain_bodyfat"
    t.integer "points_met_active_calories"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
