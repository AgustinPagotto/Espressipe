class BeansController < ApplicationController
  def index
    render json: current_user.beans, status: :ok
  end

  def show
    render json: current_user.beans.find(params[:id]), status: :ok
  end

  def create
    builder = BeanBuilder.new
    bean = builder.set_required_bean_attributes(
      current_user.id,
      bean_params[:name],
      bean_params[:origin],
      bean_params[:process],
      bean_params[:roastlevel]
    )
                  .log_changes
    bean.set_rating(bean_params[:rating])
    bean.set_decaf(bean_params[:decaf])
    bean = bean.build
    render json: bean, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
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
    params.require(:bean_data).permit(:name, :origin, :process, :roastlevel, :rating, :decaf)
  end
end
