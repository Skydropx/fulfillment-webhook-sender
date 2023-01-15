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

ActiveRecord::Schema[7.0].define(version: 20_230_114_231_723) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'events', force: :cascade do |t|
    t.string 'external_user_id'
    t.json 'payload'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'topic'
  end

  create_table 'messages', force: :cascade do |t|
    t.bigint 'event_id', null: false
    t.bigint 'webhook_id', null: false
    t.integer 'attempts'
    t.integer 'delivery_status'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_messages_on_event_id'
    t.index ['webhook_id'], name: 'index_messages_on_webhook_id'
  end

  create_table 'webhooks', force: :cascade do |t|
    t.string 'url_path'
    t.string 'external_used_id'
    t.integer 'topic'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'messages', 'events'
  add_foreign_key 'messages', 'webhooks'
end
