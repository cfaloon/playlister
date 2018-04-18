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
end
