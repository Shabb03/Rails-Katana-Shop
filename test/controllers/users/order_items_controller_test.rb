require "test_helper"

class Users::OrderItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_order_items_create_url
    assert_response :success
  end

  test "should get update" do
    get users_order_items_update_url
    assert_response :success
  end

  test "should get destroy" do
    get users_order_items_destroy_url
    assert_response :success
  end
end
