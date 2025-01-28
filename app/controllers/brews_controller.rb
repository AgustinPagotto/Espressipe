class BrewsController < ApplicationController
  before_action :authorized_current_user, only: %i[update destroy]

  def index
    render json: current_user.brews, status: :ok
  end

  def show
    render json: current_user.brews.find(params[:id]), status: :ok
  end

  def create
    brew = current_user.brews.build(brew_params)
    if brew.save
      render json: brew, status: :created
    else
      render json: { errors: brew.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    brew = current_user.brews.find(params[:id])
    if brew.update(brew_params)
      render json: brew, status: :ok
    else
      render json: { errors: brew.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    brew = current_user.brews.find(params[:id])
    if brew.destroy
      render json: brew, status: :ok
    else
      render json: { errors: brew.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def brew_params
    params.permit(:cofamount, :watamount, :method, :grindsetting, :temperature, :date, :extrationtime, :ratingbrew, :brewresult)
  end
end
