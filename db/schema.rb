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

ActiveRecord::Schema.define(version: 20160425180713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "measurements", force: :cascade do |t|
    t.integer "metric_id"
    t.float   "min"
    t.float   "max"
    t.float   "avg"
    t.float   "median"
    t.float   "ninety_five"
    t.float   "ninety_nine"
    t.integer "count"
    t.float   "sum"
    t.integer "epoch_minute"
  end

  add_index "measurements", ["metric_id", "epoch_minute"], name: "index_measurements_on_metric_id_and_epoch_minute", unique: true, using: :btree

  create_table "metrics", force: :cascade do |t|
    t.text     "name",                   null: false
    t.integer  "unit",       default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
