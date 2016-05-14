module Api
  module V1
    class UsersController < ApplicationController
      def create
        @user = User.new(user_params)
        if @user.save
          render json: { "message": "Account Created Successfully" }
        else
          render json: { "message": @user.get_error }, status: 400
        end
      end

      private

        def user_params
          params.permit :name, :password, :email, :password_confirmation
        end
    end
  end
end
