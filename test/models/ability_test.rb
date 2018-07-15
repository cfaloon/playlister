require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @other_user = create(:user2)
    @playlist = build(:playlist, user: @user)
  end

  test "User can update own playlist" do
    ability = Ability.new(@user)

    assert ability.can? :update, @playlist
  end

  test "User cannot update other's playlist" do
    ability = Ability.new(@other_user)

    assert_not ability.can? :update, @playlist
  end
end
