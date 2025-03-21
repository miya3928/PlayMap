require "test_helper"

class Admin::PostControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_post_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_post_show_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_post_destroy_url
    assert_response :success
  end
end
