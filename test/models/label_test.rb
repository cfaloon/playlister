require 'test_helper'

class LabelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "creation" do
    nameless_label = Label.new
    assert_not nameless_label.save

    named_label = Label.new({ name: '4AD' })
    assert named_label.save
  end
end
