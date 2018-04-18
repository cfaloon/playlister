require 'test_helper'

class SongsControllerTest < ActionDispatch::IntegrationTest
  test "should get song show" do
    get song_path(create(:song))
    assert_response :success
  end
end
