class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show; end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, except: %i[created_at updated_at], status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update; end

  def destroy; end

  private

  def user_params
    params.require(:user).permit(:name, :lastname, :email)
  end
end
