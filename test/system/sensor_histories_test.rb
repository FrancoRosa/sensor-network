require "application_system_test_case"

class SensorHistoriesTest < ApplicationSystemTestCase
  setup do
    @sensor_history = sensor_histories(:one)
  end

  test "visiting the index" do
    visit sensor_histories_url
    assert_selector "h1", text: "Sensor Histories"
  end

  test "creating a Sensor history" do
    visit sensor_histories_url
    click_on "New Sensor History"

    fill_in "Sensor", with: @sensor_history.sensor_id
    fill_in "Value", with: @sensor_history.value
    click_on "Create Sensor history"

    assert_text "Sensor history was successfully created"
    click_on "Back"
  end

  test "updating a Sensor history" do
    visit sensor_histories_url
    click_on "Edit", match: :first

    fill_in "Sensor", with: @sensor_history.sensor_id
    fill_in "Value", with: @sensor_history.value
    click_on "Update Sensor history"

    assert_text "Sensor history was successfully updated"
    click_on "Back"
  end

  test "destroying a Sensor history" do
    visit sensor_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sensor history was successfully destroyed"
  end
end
