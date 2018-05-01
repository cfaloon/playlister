class ArtistsControllerTest < ActionDispatch::IntegrationTest
  # index action
  test "should get artists index" do
    get artists_path
    assert_response :success
  end

  test "should get artists index as json" do
    get artists_path, as: :json
    assert_response :success
  end

  test "should search artists index with param q" do
    artist1 = create(:artist, name: 'Shadowfax')
    artist2 = create(:artist, name: 'Michael Hedges')

    get artists_path, params: {q: 'Shado'}

    assert_includes assigns(:artists), artist1
    refute_includes assigns(:artists), artist2
  end

  # show action
  test "should get artist show" do
    get artist_path(create(:artist))
    assert_response :success
  end
end
