require 'test_helper'

class LabelTest < ActiveSupport::TestCase
  test "creation" do
    label = build(:label, name: nil)
    assert_not label.valid?
  end

  test 'label saves duplicate name fails' do
    label = build(:label)
    assert label.save

    duplicate_label_name = build(:label)
    assert_not duplicate_label_name.valid?
  end

  test '.search_by_name' do
    label = create(:label, name: '12X')
    assert_includes Label.search_by_name('12'), label
  end
end
