module Api
  module V1
    class SessionsController < ApplicationController
      before_action :authenticate_token, only: [:destroy]

      def create
        auth_command = Api::UserAuthentication.call(
          params[:email],
          params[:password]
        )
        respond_with_command auth_command
      end

      def destroy
        current_user.update api_token: nil
        render json: { "message": "Logged out successfully." }
      end

      private

        def respond_with_command(auth_command)
          if auth_command.success?
            render json: auth_command.result
          else
            render json: auth_command.errors, status: :unauthorized
          end
        end
    end
  end
end
