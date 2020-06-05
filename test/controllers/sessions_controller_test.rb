require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end


  # Actions tests.

  test "login_success" do
    user = create_user
    post '/sessions', params: {:email => 'kashyap.vad@gmail.com', :password => '12345678'}
    assert_equal user.email, current_user.email
  end

  test "login_failure_password" do
    create_user
    post '/sessions', params: {:email => 'kashyap.vad@gmail.com', :password => '123456789'}
    assert_nil current_user
  end

  test "login_failure_email" do
    create_user
    post '/sessions', params: {:email => 'kvadrevu@gmail.com', :password => '12345678'}
    assert_nil current_user
  end

  test "login_failure_email_and_password" do
    create_user
    post '/sessions', params: {:email => 'kvadrevu@gmail.com', :password => '12345678'}
    assert_nil current_user
  end

  # routes tests

  test "login" do
    get '/login'
    assert_equal 200, @response.status
  end

  test "logout" do
    create_user
    post '/sessions', params: {:email => 'kashyap.vad@gmail.com', :password => '12345678'}
    get '/logout'
    assert_nil current_user
  end
end
