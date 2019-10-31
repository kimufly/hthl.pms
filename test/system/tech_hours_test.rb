require "application_system_test_case"

class TechHoursTest < ApplicationSystemTestCase
  setup do
    @tech_hour = tech_hours(:one)
  end

  test "visiting the index" do
    visit tech_hours_url
    assert_selector "h1", text: "Tech Hours"
  end

  test "creating a Tech hour" do
    visit tech_hours_url
    click_on "New Tech Hour"

    fill_in "Describe", with: @tech_hour.describe
    fill_in "Project", with: @tech_hour.project_id
    fill_in "Start at", with: @tech_hour.start_at
    fill_in "Time limit", with: @tech_hour.time_limit
    fill_in "User", with: @tech_hour.user_id
    click_on "Create Tech hour"

    assert_text "Tech hour was successfully created"
    click_on "Back"
  end

  test "updating a Tech hour" do
    visit tech_hours_url
    click_on "Edit", match: :first

    fill_in "Describe", with: @tech_hour.describe
    fill_in "Project", with: @tech_hour.project_id
    fill_in "Start at", with: @tech_hour.start_at
    fill_in "Time limit", with: @tech_hour.time_limit
    fill_in "User", with: @tech_hour.user_id
    click_on "Update Tech hour"

    assert_text "Tech hour was successfully updated"
    click_on "Back"
  end

  test "destroying a Tech hour" do
    visit tech_hours_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tech hour was successfully destroyed"
  end
end
