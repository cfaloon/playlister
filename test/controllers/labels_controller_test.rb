class LabelsControllerTest < ActionDispatch::IntegrationTest
  test "should get labels index" do
    get labels_path
    assert_response :success
  end

  test "should get labels index as json" do
    get labels_path, as: :json
    assert_response :success
  end

  test "should search labels index with param q" do
    label1 = create(:label, name: 'Virgin')
    label2 = create(:label, name: 'School Kids Records')

    get labels_path, params: {q: 'Virg'}

    assert_includes assigns(:labels), label1
    refute_includes assigns(:labels), label2
  end

  test "should get label show" do
    get label_path(create(:label))
    assert_response :success
  end
end
