require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "User creation" do
    # no username, failed creation
    user_without_username = build(:user, username: nil)
    assert_not user_without_username.valid?
    # no email, failed creation
    user_without_email = build(:user, email: nil)
    assert_not user_without_email.valid?
    # no password, failed creation
    user_without_password = build(:user, password: nil)
    assert_not user_without_password.valid?
    # successful creation
    good_user = build(:user)
    assert good_user.valid?
    # enforce uniqueness of username
    first_user = create(:user, username: 'foo')
    second_user = build(:user, username: 'foo')
    assert_not second_user.valid?
  end
end
