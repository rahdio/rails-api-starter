require "test_helper"

class UsersControllerTest < ActionController::TestCase
  def setup
    @controller = Api::V1::UsersController.new
  end

  def test_that_it_creates_when_all_params_are_valid
    password = Faker::Internet.password
    post :create,
         name: Faker::Name.name,
         email: Faker::Internet.email,
         password: password,
         password_confirmation: password
    assert_response :success
  end

  def test_that_it_raises_an_error_when_a_parameter_is_invalid
    post :create,
         name: Faker::Name.name,
         email: Faker::Internet.email,
         password: Faker::Internet.password,
         password_confirmation: Faker::Internet.password

    assert_equal response.status, 400
    assert_equal JSON.parse(response.body)["message"],
                 "Password confirmation doesn't match Password"
  end
end
