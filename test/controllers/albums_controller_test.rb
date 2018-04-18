class AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "should get albums index" do
    get albums_path
    assert_response :success
  end

  test "should get album show" do
    get album_path(create(:album))
    assert_response :success
  end
end
