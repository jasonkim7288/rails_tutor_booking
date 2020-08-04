require 'test_helper'

class NotiSettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get noti_settings_edit_url
    assert_response :success
  end

  test "should get update" do
    get noti_settings_update_url
    assert_response :success
  end

end
