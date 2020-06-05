require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  # Actions tests.
  test "sign_up_success" do
    post '/users', params: {user: {:email => 'kashyap.vad@gmail.com', :password => '12345678', :password_confirmation => '12345678'}}
    assert_equal 'kashyap.vad@gmail.com', current_user.email
  end

  test "sign_up_failure_email" do
    post '/users', params: {user: {:email => 'kashyap.vad', :password => '12345678', :password_confirmation => '12345678'}}
    assert_nil current_user
  end

  test "sign_up_failure_password_length" do
    post '/users', params: {user: {:email => 'kashyap.vad@gmail.com', :password => '123456', :password_confirmation => '123456'}}
    assert_nil current_user
  end

  test "sign_up_failure_password_match" do
    post '/users', params: {user: {:email => 'kashyap.vad@gmail.com', :password => '123456789', :password_confirmation => '12345678'}}
    assert_nil current_user
  end

  test "forgot_password_success" do
    user = create_user
    post '/forgot_password_submit', params: {user: {:email => user.email}}
    assert_nil current_user
  end

  test "forgot_password_failure" do
    post '/forgot_password_submit', params: {user: {:email => 'kashyap.vad@gmail.com'}}
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

end
