require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new
  end

  def test_that_it_responds_to_default_fields
    assert_respond_to @user, :email
    assert_respond_to @user, :api_token
    assert_respond_to @user, :name
    assert_respond_to @user, :password
    assert_respond_to @user, :password_confirmation
  end

  def test_that_it_fails_to_save_without_a_name
    refute @user.save, "Name field required"
  end

  def test_that_it_fails_to_save_without_an_email
    @user.name = Faker::Name.name
    @user.api_token = Faker::Bitcoin.testnet_address
    refute @user.save, "Email field required"
  end
end
