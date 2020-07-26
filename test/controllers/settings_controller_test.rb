require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit_profile" do
    get settings_edit_profile_url
    assert_response :success
  end

  test "should get notifications" do
    get settings_notifications_url
    assert_response :success
  end

  test "should get close_account" do
    get settings_close_account_url
    assert_response :success
  end

end
