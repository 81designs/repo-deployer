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

ActiveRecord::Schema.define(version: 20130805003659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "builds", force: true do |t|
    t.integer  "repo_id"
    t.integer  "head_commit_id"
    t.string   "branch"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "builds_commits", force: true do |t|
    t.integer "build_id"
    t.integer "commit_id"
  end

  create_table "commits", force: true do |t|
    t.string   "commit_id"
    t.integer  "committer_id"
    t.string   "message"
    t.datetime "timestamp"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "committers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "repos", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "provider_id"
    t.string   "provider_token"
    t.string   "owner"
    t.string   "name"
    t.string   "clone_url"
    t.string   "url"
    t.text     "test_commands",       default: "bundle exec rake\n# bundle exec rspec\n# bundle exec cucumber\n# bundle exec guard-jasmine"
    t.text     "test_setup_commands", default: "bundle install\nexport RAILS_ENV=test\nbundle exec rake db:setup\n# bundle exec rake db:migrate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
