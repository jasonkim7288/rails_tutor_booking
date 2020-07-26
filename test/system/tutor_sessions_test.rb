require "application_system_test_case"

class TutorSessionsTest < ApplicationSystemTestCase
  setup do
    @tutor_session = tutor_sessions(:one)
  end

  test "visiting the index" do
    visit tutor_sessions_url
    assert_selector "h1", text: "Tutor Sessions"
  end

  test "creating a Tutor session" do
    visit tutor_sessions_url
    click_on "New Tutor Session"

    fill_in "Address", with: @tutor_session.address
    fill_in "Category", with: @tutor_session.category
    fill_in "Conf url", with: @tutor_session.conf_url
    fill_in "Decimal", with: @tutor_session.decimal
    fill_in "Description", with: @tutor_session.description
    fill_in "End datetime", with: @tutor_session.end_datetime
    fill_in "Latitude", with: @tutor_session.latitude
    fill_in "Longitude", with: @tutor_session.longitude
    fill_in "Max students num", with: @tutor_session.max_students_num
    fill_in "Place", with: @tutor_session.place
    fill_in "Start datetime", with: @tutor_session.start_datetime
    fill_in "Title", with: @tutor_session.title
    fill_in "User", with: @tutor_session.user_id
    click_on "Create Tutor session"

    assert_text "Tutor session was successfully created"
    click_on "Back"
  end

  test "updating a Tutor session" do
    visit tutor_sessions_url
    click_on "Edit", match: :first

    fill_in "Address", with: @tutor_session.address
    fill_in "Category", with: @tutor_session.category
    fill_in "Conf url", with: @tutor_session.conf_url
    fill_in "Decimal", with: @tutor_session.decimal
    fill_in "Description", with: @tutor_session.description
    fill_in "End datetime", with: @tutor_session.end_datetime
    fill_in "Latitude", with: @tutor_session.latitude
    fill_in "Longitude", with: @tutor_session.longitude
    fill_in "Max students num", with: @tutor_session.max_students_num
    fill_in "Place", with: @tutor_session.place
    fill_in "Start datetime", with: @tutor_session.start_datetime
    fill_in "Title", with: @tutor_session.title
    fill_in "User", with: @tutor_session.user_id
    click_on "Update Tutor session"

    assert_text "Tutor session was successfully updated"
    click_on "Back"
  end

  test "destroying a Tutor session" do
    visit tutor_sessions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tutor session was successfully destroyed"
  end
end
