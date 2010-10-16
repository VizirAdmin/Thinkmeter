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

ActiveRecord::Schema.define(:version => 20101016045743) do

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.string   "site"
    t.string   "description"
    t.string   "twitter_profile"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands_opinions", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "opinion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.string   "from_user"
    t.integer  "from_user_id"
    t.string   "geo"
    t.integer  "twitter_id",      :limit => 8,                 :null => false
    t.string   "language_code"
    t.string   "profile_img_url"
    t.string   "source"
    t.string   "text"
    t.string   "to_user"
    t.integer  "to_user_id"
    t.integer  "status",                       :default => -1
    t.datetime "created_at"
    t.integer  "recent_retweets"
    t.string   "result_type"
    t.datetime "updated_at"
  end

  create_table "messages_brands", :force => true do |t|
    t.integer  "message_id"
    t.integer  "brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages_opinions", :force => true do |t|
    t.integer  "message_id"
    t.integer  "opinion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "opinions", :force => true do |t|
    t.string   "name"
    t.string   "expression"
    t.integer  "classification"
    t.string   "language_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", :force => true do |t|
    t.integer  "last_tweet_id", :limit => 8, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searchlogs", :force => true do |t|
    t.datetime "date_start"
    t.datetime "date_end"
    t.integer  "count"
    t.integer  "rc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
