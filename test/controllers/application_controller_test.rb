require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  def setup
    @controller = ApplicationController.new
    @user = users(:michael)
    @token = @controller.encode_token(user_id: @user.id)
  end
  test "should encode with user_id token" do
    payload = { user_id: @user.id }
    decoded_token = JWT.decode(@token, ENV['JWT_SECRET'])
    assert_equal payload[:user_id], decoded_token[0]['user_id']
  end
  test "should decode token" do
    payload = { user_id: @user.id }
    decoded_token = decoded_token(@token)
    assert_equal payload[:user_id], decoded_token[0]['user_id']
  end
  test "token should be valid for defined amount of time" do
    decoded_token = JWT.decode(@token, ENV['JWT_SECRET'])
    expiration_time = decoded_token[0]['exp']
    assert_in_delta Time.at(expiration_time), 30.days.from_now, 1.hour
  end
end