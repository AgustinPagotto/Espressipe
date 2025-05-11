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

    return render json: { message: 'Bean not found' }, status: :not_found unless bean

    brew = bean.brews.build(brew_params)
    brew.bean_id = bean.id
    if brew.save
      render json: brew, status: :created
    else
      render json: { message: brew.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    brew = @bean.brews.find(params[:id])
    if brew.update(brew_params)
      render json: brew, status: :ok
    else
      render json: { message: brew.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    brew = @bean.brews.find(params[:id])
    if brew.destroy
      render json: brew, status: :ok
    else
      render json: { message: brew.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def user_brews
    brews = Brew.joins(:bean)
                .where(beans: { user_id: current_user.id })
                .select('brews.*, beans.name AS bean_name')
    render json: brews, status: :ok
  end

  private

  def set_bean
    @bean = current_user.beans.find_by(id: params[:bean_id])
    render json: { message: 'Bean not found' }, status: :not_found unless @bean
  end

  def brew_params
    params.require(:brew_data).permit(:cofamount, :watamount, :method, :grindsetting, :temperature, :extractiontime, :ratingbrew,
                  :brewresult)
  end
end
