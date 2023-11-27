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

ActiveRecord::Schema.define(version: 20_231_020_190_402) do
  create_table 'add_data', charset: 'utf8', collation: 'utf8_general_ci', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'departments', primary_key: 'department_id', charset: 'utf8', collation: 'utf8_general_ci', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'name'
  end

  create_table 'employees', charset: 'utf8', collation: 'utf8_general_ci', force: :cascade do |t|
    t.string 'lastname'
    t.string 'firstname'
    t.string 'email'
    t.string 'phone'
    t.string 'title'
    t.string 'department_id'
    t.string 'working_title'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', charset: 'utf8', collation: 'utf8_general_ci', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'password_digest'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'locked_at'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['locked_at'], name: 'index_users_on_locked_at'
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'views', charset: 'utf8', collation: 'utf8_general_ci', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_views_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_views_on_reset_password_token', unique: true
  end
end
