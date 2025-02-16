class BrewsController < ApplicationController
  before_action :set_bean, only: %i[index show create update destroy]

  def index
    render json: @bean.brews, status: :ok
  end

  def show
    render json: @bean.brews.find(params[:id]), status: :ok
  end

  def create
    bean = @bean

    return render json: { error: 'Bean not found' }, status: :not_found unless bean

    brew = bean.brews.build(brew_params)
    brew.bean_id = bean.id
    if brew.save
      render json: brew, status: :created
    else
      render json: { errors: brew.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    brew = @bean.brews.find(params[:id])
    if brew.update(brew_params)
      render json: brew, status: :ok
    else
      render json: { errors: brew.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    brew = @bean.brews.find(params[:id])
    if brew.destroy
      render json: brew, status: :ok
    else
      render json: { errors: brew.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def user_brews
    brews = Brew.joins(:bean).where(beans: { user_id: current_user.id })
    render json: brews, status: :ok
  end

  private

  def set_bean
    debugger
    @bean = current_user.beans.find_by(id: params[:bean_id])
    render json: { error: 'Bean not found' }, status: :not_found unless @bean
  end

  def brew_params
    params.permit(:cofamount, :watamount, :method, :grindsetting, :temperature, :extrationtime, :ratingbrew,
                  :brewresult)
  end
end
