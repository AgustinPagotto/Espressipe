require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'should login' do
    log_in_as(@user)
    assert_response :accepted
  end
  test 'should not login with wrong password' do
    log_in_as(@user, password: 'wrong')
    assert_response :unauthorized
  end
end
