require "application_system_test_case"

class SensorActuatorsTest < ApplicationSystemTestCase
  setup do
    @sensor_actuator = sensor_actuators(:one)
  end

  test "visiting the index" do
    visit sensor_actuators_url
    assert_selector "h1", text: "Sensor Actuators"
  end

  test "creating a Sensor actuator" do
    visit sensor_actuators_url
    click_on "New Sensor Actuator"

    fill_in "Actuator", with: @sensor_actuator.actuator_id
    fill_in "Command", with: @sensor_actuator.command_id
    check "Enable" if @sensor_actuator.enable
    fill_in "Sensor", with: @sensor_actuator.sensor_id
    fill_in "Threshold", with: @sensor_actuator.threshold
    click_on "Create Sensor actuator"

    assert_text "Sensor actuator was successfully created"
    click_on "Back"
  end

  test "updating a Sensor actuator" do
    visit sensor_actuators_url
    click_on "Edit", match: :first

    fill_in "Actuator", with: @sensor_actuator.actuator_id
    fill_in "Command", with: @sensor_actuator.command_id
    check "Enable" if @sensor_actuator.enable
    fill_in "Sensor", with: @sensor_actuator.sensor_id
    fill_in "Threshold", with: @sensor_actuator.threshold
    click_on "Update Sensor actuator"

    assert_text "Sensor actuator was successfully updated"
    click_on "Back"
  end

  test "destroying a Sensor actuator" do
    visit sensor_actuators_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sensor actuator was successfully destroyed"
  end
end
