require "test_helper"

class Admin::WelcomesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_welcome = admin_welcomes(:one)
  end

  test "should get index" do
    get admin_welcomes_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_welcome_url
    assert_response :success
  end

  test "should create admin_welcome" do
    assert_difference('Admin::Welcome.count') do
      post admin_welcomes_url, params: { admin_welcome: { index: @admin_welcome.index } }
    end

    assert_redirected_to admin_welcome_url(Admin::Welcome.last)
  end

  test "should show admin_welcome" do
    get admin_welcome_url(@admin_welcome)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_welcome_url(@admin_welcome)
    assert_response :success
  end

  test "should update admin_welcome" do
    patch admin_welcome_url(@admin_welcome), params: { admin_welcome: { index: @admin_welcome.index } }
    assert_redirected_to admin_welcome_url(@admin_welcome)
  end

  test "should destroy admin_welcome" do
    assert_difference('Admin::Welcome.count', -1) do
      delete admin_welcome_url(@admin_welcome)
    end

    assert_redirected_to admin_welcomes_url
  end
end
