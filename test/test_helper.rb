require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"

class BaseTest < ActionController::TestCase
  include FactoryGirl::Syntax::Methods
end

class BaseTestAuth < BaseTest
  def login_as_user
    post :login,
         email: @user.email,
         password: @user.password
  end

  def get_token
    login_as_user
    response_hash = JSON.parse(response.body)

    response_hash["token"]
  end
end
