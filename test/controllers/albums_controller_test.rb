class AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "should get albums index" do
    get albums_path
    assert_response :success
  end

  test "should get albums index as json" do
    get albums_path, as: :json
    assert_response :success
  end

  test "should search albums index with param q" do
    album1 = create(:album, name: 'In Melody', artists: [create(:artist, name: 'Nils Frahm')])
    album2 = create(:album, name: 'A Rainbow in Curved Air', artists: [create(:artist, name: 'Terry Riley')])

    get albums_path, params: {q: 'Melod'}

    assert_includes assigns(:albums), album1
    refute_includes assigns(:albums), album2
  end

  test "should get album show" do
    get album_path(create(:album))
    assert_response :success
  end
end
