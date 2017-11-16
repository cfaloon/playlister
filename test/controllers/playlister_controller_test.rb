require 'test_helper'

class PlaylisterControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get playlister_new_url
    assert_response :success
  end

  test "should get create" do
    get playlister_create_url
    assert_response :success
  end

  test "should get show" do
    get playlister_show_url
    assert_response :success
  end

  test "should get index" do
    get playlister_index_url
    assert_response :success
  end

end
