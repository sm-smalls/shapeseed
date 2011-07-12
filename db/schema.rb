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

ActiveRecord::Schema.define(:version => 20110710171620) do

  create_table "categories", :force => true do |t|
    t.string    "name"
    t.integer   "person_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "categories", ["person_id"], :name => "index_categories_on_person_id"

  create_table "contributions", :force => true do |t|
    t.integer   "contributed_id"
    t.integer   "contributor_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "contributions", ["contributed_id"], :name => "index_contributions_on_contributed_id"
  add_index "contributions", ["contributor_id"], :name => "index_contributions_on_contributor_id"

  create_table "mentorships", :force => true do |t|
    t.integer   "mentor_id"
    t.integer   "mentee_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "mentorships", ["mentee_id"], :name => "index_mentorships_on_mentee_id"
  add_index "mentorships", ["mentor_id", "mentee_id"], :name => "index_mentorships_on_mentor_id_and_mentee_id", :unique => true
  add_index "mentorships", ["mentor_id"], :name => "index_mentorships_on_mentor_id"

  create_table "people", :force => true do |t|
    t.string    "first"
    t.string    "last"
    t.text      "title"
    t.text      "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "name"
  end

  create_table "relationships", :force => true do |t|
    t.integer   "follower_id"
    t.integer   "followed_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "searches", :force => true do |t|
    t.string    "query"
    t.integer   "min_age"
    t.integer   "max_age"
    t.string    "work_results"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string    "name"
    t.integer   "work_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "tags", ["work_id"], :name => "index_tags_on_work_id"

  create_table "users", :force => true do |t|
    t.string    "first"
    t.string    "last"
    t.string    "email",                                 :null => false
    t.string    "crypted_password",                      :null => false
    t.string    "password_salt",                         :null => false
    t.string    "persistence_token",                     :null => false
    t.string    "perishable_token",                      :null => false
    t.integer   "login_count",        :default => 0,     :null => false
    t.integer   "failed_login_count", :default => 0,     :null => false
    t.timestamp "last_request_at"
    t.timestamp "current_login_at"
    t.timestamp "last_login_at"
    t.string    "current_login_ip"
    t.string    "last_login_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["email"], :name => "index_users_on_login", :unique => true
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true

  create_table "works", :force => true do |t|
    t.text      "content"
    t.integer   "person_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "age"
    t.string    "name"
    t.text      "source"
  end

  add_index "works", ["person_id"], :name => "index_works_on_person_id"

end
