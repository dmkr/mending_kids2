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

ActiveRecord::Schema.define(version: 20150731060652) do

  create_table "donations", force: true do |t|
    t.string   "item_description"
    t.string   "brand"
    t.string   "lot_number"
    t.date     "expiration_date"
    t.decimal  "fair_market_value"
    t.decimal  "mk_cost"
    t.decimal  "total_in_kind_value"
    t.integer  "donor_id"
    t.integer  "quantity"
    t.integer  "inventory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ref"
    t.string   "uom"
    t.text     "details"
    t.string   "location"
    t.string   "country_of_origin"
    t.string   "comments"
    t.string   "category"
  end

  add_index "donations", ["donor_id"], name: "index_donations_on_donor_id"
  add_index "donations", ["inventory_id"], name: "index_donations_on_inventory_id"

  create_table "donors", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventories", force: true do |t|
    t.string   "item_description"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventories_missions", force: true do |t|
    t.integer "inventory_id"
    t.integer "mission_id"
  end

  add_index "inventories_missions", ["inventory_id"], name: "index_inventories_missions_on_inventory_id"
  add_index "inventories_missions", ["mission_id"], name: "index_inventories_missions_on_mission_id"

  create_table "mission_inventories", force: true do |t|
    t.string   "item_description"
    t.string   "brand"
    t.string   "lot_number"
    t.integer  "mission_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expiration_date"
  end

  add_index "mission_inventories", ["mission_id"], name: "index_mission_inventories_on_mission_id"

  create_table "missions", force: true do |t|
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
