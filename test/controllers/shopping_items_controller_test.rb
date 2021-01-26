require 'test_helper'

class ShoppingItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get shopping_items_new_url
    assert_response :success
  end

  test "should get index" do
    get shopping_items_index_url
    assert_response :success
  end

end
