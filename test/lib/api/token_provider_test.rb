require "test_helper"
require "pry"

class TokenProviderTest < ActiveSupport::TestCase
  def setup
    @test_id = Faker::Number.number(2)
    @payload = { user_id: @test_id }
    @encoded_data = Api::TokenProvider.encode(@payload)
  end

  def test_token_encoded_is_valid_for_two_days
    _, date = @encoded_data
    today = Date.today

    assert_equal date.year, today.year
    assert_equal date.month, today.month
    assert_equal((date.day - today.day), 2)
  end

  def test_token_is_successfully_decoded
    decoded_data = Api::TokenProvider.decode(@encoded_data.first)
    assert_equal decoded_data["user_id"], @test_id
  end
end
