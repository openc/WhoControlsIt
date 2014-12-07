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

ActiveRecord::Schema.define(version: 20141207144934) do

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "jurisdiction_code"
    t.string   "company_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "control_relationships", force: true do |t|
    t.string   "relationship_type"
    t.text     "details"
    t.string   "timestamps"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "document"
    t.text     "notes"
    t.integer  "entity_id"
  end

  create_table "entities", force: true do |t|
    t.string   "name"
    t.string   "entity_type"
    t.string   "jurisdiction"
    t.string   "date_of_birth"
    t.string   "address"
    t.string   "company_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "nationality"
    t.date     "date_of_birth"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
