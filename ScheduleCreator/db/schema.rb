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

ActiveRecord::Schema.define(version: 20150429190940) do

  create_table "courses", force: true do |t|
    t.integer  "subject_id"
    t.string   "courseId"
    t.string   "title"
    t.text     "description"
    t.integer  "credits"
    t.boolean  "lecture_required?"
    t.boolean  "lab_required?"
    t.boolean  "tutorial_required?"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["subject_id"], name: "index_courses_on_subject_id", using: :btree

  create_table "lab_sections", force: true do |t|
    t.integer  "course_id"
    t.integer  "true_id"
    t.integer  "seats_remaining"
    t.integer  "currently_registered"
    t.integer  "term"
    t.string   "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lecture_sections", force: true do |t|
    t.integer  "course_id"
    t.integer  "true_id"
    t.integer  "seats_remaining"
    t.integer  "currently_registered"
    t.integer  "term"
    t.string   "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.text     "description"
    t.string   "department"
    t.string   "year"
    t.string   "session"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tutorial_sections", force: true do |t|
    t.integer  "course_id"
    t.integer  "true_id"
    t.integer  "seats_remaining"
    t.integer  "currently_registered"
    t.integer  "term"
    t.string   "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
