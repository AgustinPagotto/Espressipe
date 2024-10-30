require "test_helper"

class BrewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get brews_index_url
    assert_response :success
  end

  test "should get show" do
    get brews_show_url
    assert_response :success
  end

  test "should get create" do
    get brews_create_url
    assert_response :success
  end

  test "should get update" do
    get brews_update_url
    assert_response :success
  end

  test "should get destroy" do
    get brews_destroy_url
    assert_response :success
  end
end
