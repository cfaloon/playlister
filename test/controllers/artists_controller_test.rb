class ArtistsControllerTest < ActionDispatch::IntegrationTest
  test "should get artists index" do
    get artists_path
    assert_response :success
  end

  test "should get artist show" do
    get artist_path(artists(:cream))
    assert_response :success
  end
end
