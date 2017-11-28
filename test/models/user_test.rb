require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "User creation" do
    # no username, failed creation
    user_without_username = User.new(username: nil, email: 'testy@test.com', password: 'pwd123')
    assert_not user_without_username.save
    # no email, failed creation
    user_without_email = User.new(username: 'cole', email: nil, password: 'pwd123')
    assert_not user_without_email.save
    # no password, failed creation
    user_without_password = User.new(username: 'cole', email: 'testy@test.com', password: nil)
    assert_not user_without_password.save
    # successful creation
    good_user = User.new(username: 'cole', email: 'testy@test.com', password: 'pwd123')
    assert good_user.save
    # enforce uniqueness of username
    first_user = User.create(username: 'user1', email: 'user1@test.com', password: '456lmnop')
    second_user = User.new(username: 'user1', email: 'user2@test.com', password: 'abc123')
    assert_not second_user.save
  end
end
