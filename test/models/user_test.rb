require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'valid_user' do
    user = User.new(email: 'kashyap.vad@gmail.com', password: '12345678')
    assert user.valid?
  end

  test 'invalid_without_email' do
    user = User.new(email: '', password: '12345678')
    refute user.valid?
    assert_equal ["can't be blank", "address not valid"], user.errors[:email]
  end

  test 'invalid_email' do
    user = User.new(email: 'kashyap.vad@gmail', password: '12345678')
    refute user.valid?
    assert_equal ["address not valid"], user.errors[:email]
  end

  test 'invalid_password' do
    user = User.new(email: 'kashyap.vad@gmail.com', password: '123456')
    refute user.valid?
    assert_equal ["is too short (minimum is 8 characters)"], user.errors[:password]
  end

  test 'invalid_username_when_update' do
    user = create_user
    user.username = 'kash'
    refute user.valid?
    assert_equal ["is too short (minimum is 5 characters)"], user.errors[:username]
  end

  test 'valid_username_create' do
    user = User.new(email: 'kashyap.vad@gmail.com', password: '12345678', username: 'kash')
    assert user.valid?
  end

  # testing emails
end
