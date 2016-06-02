module Api
  class UserAuthentication
    prepend SimpleCommand
    attr_accessor :email, :password

    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      if user
        token, exp_date = Api::TokenProvider.encode(user_id: user.id)
        user.update api_token: token

        {
          "token" => token,
          "expiry_date" => exp_date.to_formatted_s(:db)
        }
      end
    end

    private

      def user
        user = User.find_by_email(email)
        return user if user && user.authenticate(password)
        errors[:message] = "Login Failed. Credentials Invalid."

        nil
      end
  end
end