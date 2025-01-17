require "test_helper"

class Users::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get users_orders_show_url
    assert_response :success
  end

  test "should get create" do
    get users_orders_create_url
    assert_response :success
  end

  test "should get update" do
    get users_orders_update_url
    assert_response :success
  end
end
