class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    expiration_days = ENV['JWT_EXPIRATION'].to_i || 30
    payload[:exp] = expiration_days.days.from_now.to_i
    JWT.encode(payload, ENV['JWT_SECRET'])
  end

  def decoded_token
      header = request.headers['Authorization']
      if header
          token = header.split(" ")[1]
          begin
              JWT.decode(token, ENV['JWT_SECRET'])
          rescue JWT::DecodeError
              nil
          end
      end
  end

  def current_user 
    if decoded_token
        user_id = decoded_token[0]['user_id']
        @user = User.find_by(id: user_id)
    end
  end

  def authorized_current_user
    unless current_user == User.find(params[:id])
      render json: { message: 'Please log in' }, status: :unauthorized
    end
  end

  def authorized
    unless !!current_user
    render json: { message: 'Please log in' }, status: :unauthorized
    end
  end
end
