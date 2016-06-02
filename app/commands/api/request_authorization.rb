module Api
  class RequestAuthorization
    prepend SimpleCommand
    attr_reader :headers, :params

    def initialize(headers, params)
      @headers = headers
      @params = params
    end

    def call
      user
    end

    private

      def user
        token = get_token
        return if token_empty? token

        user_by_token token
      end

      def get_token
        auth_header = headers["Authorization"]
        return token_by_header auth_header if auth_header

        params[:token]
      end

      def token_by_header(auth_header)
        auth_header.split(":").last.split("token").last.strip
      end

      def token_empty?(token)
        if token.nil?
          errors[:message] = "Token required. "\
          "Please see documentation for usage instructions."

          true
        end
      end

      def user_by_token(token)
        decoded_token = Api::TokenProvider.decode(token)
        if decoded_token
          match_id_to_user decoded_token["user_id"]
        else
          errors[:message] = "Token invalid."
        end
      end

      def match_id_to_user(user_id)
        user = User.find_by_id(user_id)
        errors[:message] = "Token invalid." unless user && user.api_token

        user
      end
  end
end