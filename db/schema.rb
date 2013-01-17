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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130117074750) do

  create_table "brand_translations", :force => true do |t|
    t.integer  "brand_id"
    t.string   "locale"
    t.string   "name",       :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "brand_translations", ["brand_id"], :name => "index_brand_translations_on_brand_id"
  add_index "brand_translations", ["locale"], :name => "index_brand_translations_on_locale"

  create_table "brands", :force => true do |t|
    t.integer  "uid"
    t.integer  "hub_type"
    t.integer  "layout_id"
    t.integer  "user_id"
    t.string   "uri"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "brands", ["layout_id"], :name => "index_brands_on_layout_id"
  add_index "brands", ["user_id"], :name => "index_brands_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "faq_categories", :force => true do |t|
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_translations", :force => true do |t|
    t.integer  "user_id"
    t.string   "locale"
    t.string   "first_name", :limit => 20
    t.string   "last_name",  :limit => 20
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "user_translations", ["locale"], :name => "index_user_translations_on_locale"
  add_index "user_translations", ["user_id"], :name => "index_user_translations_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                        :default => "", :null => false
    t.integer  "sign_in_count",                :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "locale"
    t.string   "image_url"
    t.string   "nuvo_uid"
    t.string   "nuvo_access_token"
    t.datetime "nuvo_access_token_expires_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
