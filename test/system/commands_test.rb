require "application_system_test_case"

class CommandsTest < ApplicationSystemTestCase
  setup do
    @command = commands(:one)
  end

  test "visiting the index" do
    visit commands_url
    assert_selector "h1", text: "Commands"
  end

  test "creating a Command" do
    visit commands_url
    click_on "New Command"

    fill_in "Condition", with: @command.condition
    fill_in "Name", with: @command.name
    fill_in "Status", with: @command.status
    click_on "Create Command"

    assert_text "Command was successfully created"
    click_on "Back"
  end

  test "updating a Command" do
    visit commands_url
    click_on "Edit", match: :first

    fill_in "Condition", with: @command.condition
    fill_in "Name", with: @command.name
    fill_in "Status", with: @command.status
    click_on "Update Command"

    assert_text "Command was successfully updated"
    click_on "Back"
  end

  test "destroying a Command" do
    visit commands_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Command was successfully destroyed"
  end
end
