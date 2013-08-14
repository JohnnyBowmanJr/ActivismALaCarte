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

ActiveRecord::Schema.define(:version => 20130810020456) do

  create_table "calls", :force => true do |t|
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "recording"
    t.string   "twilio_id"
    t.integer  "duration"
    t.string   "recording_url"
    t.string   "answered_by"
  end

  create_table "campaigns", :force => true do |t|
    t.string   "title"
    t.string   "target_name"
    t.string   "phone_number"
    t.string   "action"
    t.string   "start_date"
    t.string   "end_date"
    t.text     "description"
    t.integer  "organizer_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "image"
    t.string   "slug"
  end

  add_index "campaigns", ["slug"], :name => "index_campaigns_on_slug", :unique => true

  create_table "referrals", :force => true do |t|
    t.integer  "clicker_id"
    t.integer  "sharelink_id"
    t.boolean  "call_conversion"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "sharelinks", :force => true do |t|
    t.string   "short_key",   :null => false
    t.integer  "referrer_id", :null => false
    t.integer  "campaign_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "sharelinks", ["short_key"], :name => "sharelinks_short_key_index", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image_url"
    t.string   "image_url_small"
    t.string   "phone_number"
    t.string   "zipcode"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
