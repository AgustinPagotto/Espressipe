require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test 'should get current user' do
    log_in_as(@user)
    get me_url, headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    user = @response.parsed_body
    assert_equal "Michael", user['name']
  end
  test 'should not get current user without token' do
    log_in_as(@user)
    get me_url
    assert_response :unauthorized
  end
  test 'should update user' do
    log_in_as(@user)
    patch user_url(@user), headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }, params: { user: { name: 'John' } }
    user = @response.parsed_body
    assert_equal "John", user['name']
  end
  test 'should not update other user' do
    log_in_as(@user)
    patch user_url(@other_user), headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }, params: { user: { name: 'John' } }
    assert_response :unauthorized
  end

  test 'should delete user' do
    log_in_as(@user)
    delete user_url(@user), headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    assert_not User.find_by(id: @user.id)
  end

  test 'should not delete other user' do
    log_in_as(@user)
    delete user_url(@other_user), headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    assert User.find_by(id: @other_user.id)
  end
end
