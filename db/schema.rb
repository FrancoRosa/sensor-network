# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_10_084152) do

  create_table "actuators", force: :cascade do |t|
    t.integer "device_id", null: false
    t.integer "element_id", null: false
    t.float "expected_status"
    t.float "current_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["device_id"], name: "index_actuators_on_device_id"
    t.index ["element_id"], name: "index_actuators_on_element_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.text "description"
    t.integer "tx_period"
    t.integer "tx_slot"
    t.integer "rx_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "elements", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sensor_histories", force: :cascade do |t|
    t.integer "sensor_id", null: false
    t.float "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sensor_id"], name: "index_sensor_histories_on_sensor_id"
  end

  create_table "sensors", force: :cascade do |t|
    t.integer "device_id"
    t.integer "variable_id"
    t.float "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["device_id"], name: "index_sensors_on_device_id"
    t.index ["variable_id"], name: "index_sensors_on_variable_id"
  end

  create_table "variables", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "actuators", "devices"
  add_foreign_key "actuators", "elements"
  add_foreign_key "sensor_histories", "sensors"
end
