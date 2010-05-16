# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100516085424) do

  create_table "expense_items", :force => true do |t|
    t.date     "date",            :null => false
    t.integer  "expense_type_id", :null => false
    t.float    "value",           :null => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "expense_items", ["expense_type_id"], :name => "expense_type_foreign_key"

  create_table "expense_items_expense_tags", :id => false, :force => true do |t|
    t.integer "expense_item_id", :null => false
    t.integer "expense_tag_id",  :null => false
  end

  add_index "expense_items_expense_tags", ["expense_item_id", "expense_tag_id"], :name => "index_items_tags", :unique => true
  add_index "expense_items_expense_tags", ["expense_item_id"], :name => "index_tags"
  add_index "expense_items_expense_tags", ["expense_tag_id"], :name => "foreign_key_tag_id"

  create_table "expense_tags", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expense_types", :force => true do |t|
    t.string   "description", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "nickname",                       :null => false
    t.string   "email",                          :null => false
    t.string   "salt",                           :null => false
    t.string   "hashed_password",                :null => false
    t.integer  "role",            :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
