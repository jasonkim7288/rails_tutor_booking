require 'test_helper'

class TutorSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tutor_session = tutor_sessions(:one)
  end

  test "should get index" do
    get tutor_sessions_url
    assert_response :success
  end

  test "should get new" do
    get new_tutor_session_url
    assert_response :success
  end

  test "should create tutor_session" do
    assert_difference('TutorSession.count') do
      post tutor_sessions_url, params: { tutor_session: { address: @tutor_session.address, category: @tutor_session.category, conf_url: @tutor_session.conf_url, decimal: @tutor_session.decimal, description: @tutor_session.description, end_datetime: @tutor_session.end_datetime, latitude: @tutor_session.latitude, longitude: @tutor_session.longitude, max_students_num: @tutor_session.max_students_num, place: @tutor_session.place, start_datetime: @tutor_session.start_datetime, title: @tutor_session.title, user_id: @tutor_session.user_id } }
    end

    assert_redirected_to tutor_session_url(TutorSession.last)
  end

  test "should show tutor_session" do
    get tutor_session_url(@tutor_session)
    assert_response :success
  end

  test "should get edit" do
    get edit_tutor_session_url(@tutor_session)
    assert_response :success
  end

  test "should update tutor_session" do
    patch tutor_session_url(@tutor_session), params: { tutor_session: { address: @tutor_session.address, category: @tutor_session.category, conf_url: @tutor_session.conf_url, decimal: @tutor_session.decimal, description: @tutor_session.description, end_datetime: @tutor_session.end_datetime, latitude: @tutor_session.latitude, longitude: @tutor_session.longitude, max_students_num: @tutor_session.max_students_num, place: @tutor_session.place, start_datetime: @tutor_session.start_datetime, title: @tutor_session.title, user_id: @tutor_session.user_id } }
    assert_redirected_to tutor_session_url(@tutor_session)
  end

  test "should destroy tutor_session" do
    assert_difference('TutorSession.count', -1) do
      delete tutor_session_url(@tutor_session)
    end

    assert_redirected_to tutor_sessions_url
  end
end
