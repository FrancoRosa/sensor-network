require "application_system_test_case"

class ActuatorsTest < ApplicationSystemTestCase
  setup do
    @actuator = actuators(:one)
  end

  test "visiting the index" do
    visit actuators_url
    assert_selector "h1", text: "Actuators"
  end

  test "creating a Actuator" do
    visit actuators_url
    click_on "New Actuator"

    fill_in "Current status", with: @actuator.current_status
    fill_in "Device", with: @actuator.device
    fill_in "Element", with: @actuator.element
    fill_in "Expected status", with: @actuator.expected_status
    click_on "Create Actuator"

    assert_text "Actuator was successfully created"
    click_on "Back"
  end

  test "updating a Actuator" do
    visit actuators_url
    click_on "Edit", match: :first

    fill_in "Current status", with: @actuator.current_status
    fill_in "Device", with: @actuator.device
    fill_in "Element", with: @actuator.element
    fill_in "Expected status", with: @actuator.expected_status
    click_on "Update Actuator"

    assert_text "Actuator was successfully updated"
    click_on "Back"
  end

  test "destroying a Actuator" do
    visit actuators_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Actuator was successfully destroyed"
  end
end
