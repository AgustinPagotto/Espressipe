class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  before_action :authorized_current_user, only: %i[update destroy]

  def me 
    render json: current_user, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      builder = BeanBuilder.new
      director = BeanDirector.new(builder)
      begin
        director.build_example_bean(@user.id)
      rescue ActiveRecord::RecordInvalid => e
        Rails.logger.error("Failed to build bean: #{e.message}")
        return render json: { user: @user, except: %i[created_at updated_at password_digest id], warning: "User created, but example bean could not be created: #{e.message}" }, status: :created
      end
      render json:{ user: @user }, except: %i[created_at updated_at password_digest id], status: :created
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
