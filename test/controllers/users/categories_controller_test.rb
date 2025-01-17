require "test_helper"

class Users::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_categories_index_url
    assert_response :success
  end

  test "should get show" do
    get users_categories_show_url
    assert_response :success
  end
end
