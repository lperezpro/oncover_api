# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_01_044444) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "first_names"
    t.string "last_names"
    t.integer "phone_number"
    t.date "date_birth"
    t.string "document_id"
    t.integer "gender"
    t.string "email"
    t.string "password_digest"
    t.string "id_gg"
    t.string "email_gg"
    t.string "token_gg"
    t.string "id_fb"
    t.string "email_fb"
    t.string "token_fb"
    t.datetime "last_login"
    t.boolean "validated_email", default: false
    t.string "email_token"
    t.datetime "email_token_sent_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "last_reset_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_token"], name: "index_users_on_email_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

end
