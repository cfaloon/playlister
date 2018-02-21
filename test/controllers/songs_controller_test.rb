class SongsControllerTest < ActionDispatch::IntegrationTest
  test "should get song show" do
    get song_path(songs(:one))
    assert_response :success
  end
end
