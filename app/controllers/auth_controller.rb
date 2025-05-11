class AuthController < ApplicationController
    skip_before_action :authorized, only: [:login]
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

    def login 
        @user = User.find_by!(email: login_params[:email].downcase)
        if @user.authenticate(login_params[:password])
            @token = encode_token(user_id: @user.id)
            render json:{ user: @user, token: @token }, except: %i[created_at updated_at password_digest id], status: :accepted
        else
            render json: { message: 'Incorrect password' }, status: :unauthorized
        end
    end

    private 

    def login_params 
        params.require(:credentials).permit(:email, :password)
    end

    def handle_record_not_found(e)
        render json: { message: "User doesn't exist" }, status: :unauthorized
    end
end
