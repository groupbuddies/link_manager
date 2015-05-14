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

ActiveRecord::Schema.define(version: 20150514160932) do

  create_table "links", force: :cascade do |t|
    t.string   "url",                                 null: false
    t.string   "unique_key",  limit: 10,              null: false
    t.integer  "use_count",              default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description",            default: "", null: false
    t.string   "owner_email",            default: "", null: false
  end

  add_index "links", ["owner_email"], name: "index_links_on_owner_email"
  add_index "links", ["unique_key"], name: "index_links_on_unique_key", unique: true
  add_index "links", ["url"], name: "index_links_on_url"

end
