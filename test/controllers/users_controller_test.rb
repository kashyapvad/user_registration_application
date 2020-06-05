require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  # Actions tests.

  test "reset_password_success" do
    user = create_user
    link_hash = LinkHash.find_or_create_by(:user_id => user.id)
    link_hash.update(:updated_at => Time.now, :slug => SecureRandom.uuid)
    get "/reset_password/#{link_hash.slug}"
    assert_equal user.email, current_user.email
  end

  test "reset_password_expired" do
    user = create_user
    link_hash = LinkHash.find_or_create_by(:user_id => user.id)
    link_hash.update(:updated_at => Time.now - 7.hours, :slug => SecureRandom.uuid)
    get "/reset_password/#{SecureRandom.uuid}"
    assert_nil current_user
  end

  test "reset_password_failure" do
    get "/reset_password/#{SecureRandom.uuid}"
    assert_nil current_user
  end

  # routes tests
  test "sign_up" do
    get '/signup'
    assert_equal 200, @response.status
  end

  test "forgot_password" do
    get '/forgot_password'
    assert_equal 200, @response.status
  end

  test "edit_without_log_in" do
    user = create_user
    get "/users/#{user.id}/edit"
    assert_nil  current_user
  end

  test "edit_with_log_in" do
    user = create_user
    post '/sessions', params: {:email => user.email, :password => user.password}
    get "/users/#{user.id}/edit"
    assert_equal user.email, current_user.email
  end
end
