require "test_helper"
require "pry"

class SessionsControllerTest < BaseTestAuth
  def setup
    @controller = Api::V1::SessionsController.new
    @user = create(:user)
  end

  def test_that_it_detects_invalid_logon
    post :login,
         email: Faker::Internet.email,
         password: Faker::Internet.password

    assert_response :unauthorized
    assert_equal JSON.parse(response.body)["message"],
                 "Login Failed. Credentials Invalid."
  end

  def test_that_it_logins_and_returns_an_hash_with_token_and_expiry
    login_as_user
    response_hash_keys = JSON.parse(response.body).keys
    assert_response :success
    assert_includes response_hash_keys, "token"
    assert_includes response_hash_keys, "expiry_date"
  end

  def test_that_it_logouts_successfully
    @request.headers["Authorization"] = "token #{get_token}"
    post :logout
    
    assert_response :success
    assert_nil @user.api_token
  end

  def test_that_it_fails_when_token_is_needed_but_not_sent
    login_as_user
    post :logout
    
    assert_response :unauthorized
    assert_equal JSON.parse(response.body)["message"],
                 "Token required. Please see documentation for usage instructions."
  end

  def test_that_it_fails_when_invalid_token_is_sent
    login_as_user
    @request.headers["Authorization"] = Faker::Lorem.characters(64)
    post :logout
    
    assert_response :unauthorized
    assert_equal JSON.parse(response.body)["message"],
                 "Token invalid."
  end
end