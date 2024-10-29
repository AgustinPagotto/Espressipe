class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  before_action :authorized_current_user, only: %i[update destroy]

  def me 
    render json: current_user, status: :ok
  end

  def create
    @user = User.new(user_params)
    @token = encode_token(user_id: @user.id)
    if @user.save
      render json:{ user: @user, token: @token }, except: %i[created_at updated_at password_digest id], status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user, except: %i[created_at updated_at password_digest id], status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render json: @user, except: %i[created_at updated_at], status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :lastname, :email, :password, :password_confirmation)
  end
end
