class LabelsControllerTest < ActionDispatch::IntegrationTest
  test "should get labels index" do
    get labels_path
    assert_response :success
  end

  test "should get labels index as json" do
    get labels_path, as: :json
    assert_response :success
  end

  test "should get label show" do
    get label_path(create(:label))
    assert_response :success
  end
end
