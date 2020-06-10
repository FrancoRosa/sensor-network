require "application_system_test_case"

class ActuatorHistoriesTest < ApplicationSystemTestCase
  setup do
    @actuator_history = actuator_histories(:one)
  end

  test "visiting the index" do
    visit actuator_histories_url
    assert_selector "h1", text: "Actuator Histories"
  end

  test "creating a Actuator history" do
    visit actuator_histories_url
    click_on "New Actuator History"

    fill_in "Actuator", with: @actuator_history.actuator_id
    fill_in "Current status", with: @actuator_history.current_status
    fill_in "Expected status", with: @actuator_history.expected_status
    click_on "Create Actuator history"

    assert_text "Actuator history was successfully created"
    click_on "Back"
  end

  test "updating a Actuator history" do
    visit actuator_histories_url
    click_on "Edit", match: :first

    fill_in "Actuator", with: @actuator_history.actuator_id
    fill_in "Current status", with: @actuator_history.current_status
    fill_in "Expected status", with: @actuator_history.expected_status
    click_on "Update Actuator history"

    assert_text "Actuator history was successfully updated"
    click_on "Back"
  end

  test "destroying a Actuator history" do
    visit actuator_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Actuator history was successfully destroyed"
  end
end
