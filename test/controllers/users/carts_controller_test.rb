require "test_helper"

class Users::CartsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_carts_show_url
    assert_response :success
  end

  test "should get update" do
    get users_carts_update_url
    assert_response :success
  end

  test "should get edit" do
    get users_carts_edit_url
    assert_response :success
  end
end
