class BeansController < ApplicationController
  before_action :authorized_current_user, only: %i[update destroy]

  def index
    render json: current_user.beans, status: :ok
  end

  def show
    render json: current_user.beans.find(params[:id]), status: :ok
  end

  def create
    bean = current_user.beans.build(bean_params)
    if bean.save
      render json: bean, status: :created
    else
      render json: { errors: bean.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    bean = current_user.beans.find(params[:id])
    if bean.update(bean_params)
      render json: bean, status: :ok
    else
      render json: { errors: bean.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    bean = current_user.beans.find(params[:id])
    if bean.destroy
      render json: bean, status: :ok
    else
      render json: { errors: bean.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def bean_params
    params.permit(:name, :origin, :process, :roastlevel, :rating, :decaf)
  end
end
