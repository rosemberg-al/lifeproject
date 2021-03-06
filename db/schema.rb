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

ActiveRecord::Schema.define(version: 2019_04_05_145457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "content_genres", force: :cascade do |t|
    t.string "description"
    t.bigint "user_id"
    t.datetime "inactivated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_content_genres_on_user_id"
  end

# Could not dump table "content_people" because of following StandardError
#   Unknown type 'content_person_type' for column 'type_content_person'

  create_table "content_subjects", force: :cascade do |t|
    t.bigint "content_id"
    t.bigint "user_id"
    t.bigint "subject_id"
    t.datetime "inactivated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_content_subjects_on_content_id"
    t.index ["subject_id"], name: "index_content_subjects_on_subject_id"
    t.index ["user_id"], name: "index_content_subjects_on_user_id"
  end

# Could not dump table "content_types" because of following StandardError
#   Unknown type 'content_type_features' for column 'feature'

  create_table "contents", force: :cascade do |t|
    t.string "description"
    t.datetime "inactivated_at"
    t.bigint "user_id"
    t.bigint "content_type_id"
    t.bigint "content_genre_id"
    t.string "synopsis"
    t.string "book_publisher"
    t.datetime "book_date_published"
    t.string "movie_company"
    t.datetime "movie_date_released"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "movie_time"
    t.bigint "language_id"
    t.index ["content_genre_id"], name: "index_contents_on_content_genre_id"
    t.index ["content_type_id"], name: "index_contents_on_content_type_id"
    t.index ["language_id"], name: "index_contents_on_language_id"
    t.index ["user_id"], name: "index_contents_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "iso_639_1"
    t.string "iso_639_2t"
    t.string "iso_639_2b"
    t.string "description"
  end

# Could not dump table "people" because of following StandardError
#   Unknown type 'person_type' for column 'type_person'

# Could not dump table "quotation_people" because of following StandardError
#   Unknown type 'content_person_type' for column 'type_person'

# Could not dump table "quotations" because of following StandardError
#   Unknown type 'quotation_type' for column 'type_quote'

# Could not dump table "reviews" because of following StandardError
#   Unknown type 'review_type' for column 'type_review'

  create_table "subjects", force: :cascade do |t|
    t.string "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "inactivated_at"
  end

# Could not dump table "summaries" because of following StandardError
#   Unknown type 'content_summary_type' for column 'type_summary'

  create_table "summary_contents", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "content_id"
    t.bigint "summary_id"
    t.datetime "inactivated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_summary_contents_on_content_id"
    t.index ["summary_id"], name: "index_summary_contents_on_summary_id"
    t.index ["user_id"], name: "index_summary_contents_on_user_id"
  end

# Could not dump table "summary_people" because of following StandardError
#   Unknown type 'content_person_type' for column 'type_person'

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "password_digest"
    t.text "bio"
    t.datetime "confirmed_at"
    t.string "confirmation_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "content_genres", "users"
  add_foreign_key "content_people", "contents"
  add_foreign_key "content_people", "people"
  add_foreign_key "content_people", "users"
  add_foreign_key "content_subjects", "contents"
  add_foreign_key "content_subjects", "subjects"
  add_foreign_key "content_subjects", "users"
  add_foreign_key "content_types", "users"
  add_foreign_key "contents", "content_genres"
  add_foreign_key "contents", "content_types"
  add_foreign_key "contents", "users"
  add_foreign_key "people", "users"
  add_foreign_key "quotation_people", "people"
  add_foreign_key "quotation_people", "quotations"
  add_foreign_key "quotation_people", "users"
  add_foreign_key "quotations", "contents"
  add_foreign_key "quotations", "users"
  add_foreign_key "reviews", "contents"
  add_foreign_key "reviews", "users"
  add_foreign_key "subjects", "users"
  add_foreign_key "summaries", "users"
  add_foreign_key "summary_contents", "contents"
  add_foreign_key "summary_contents", "summaries"
  add_foreign_key "summary_contents", "users"
  add_foreign_key "summary_people", "people"
  add_foreign_key "summary_people", "summaries"
  add_foreign_key "summary_people", "users"
end
