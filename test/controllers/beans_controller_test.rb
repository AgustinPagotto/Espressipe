require 'test_helper'

class BeansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bean = beans(:two)
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test 'should get all beans of the user' do
    log_in_as(@user)
    get beans_url, headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    assert_response :success
  end

  test 'should create bean' do
    log_in_as(@user)
    assert_difference('Bean.count') do
      post beans_url, headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" },
                      params: @bean.attributes.except('id')
    end
    assert_response :created
  end

  test 'should not create bean with invalid parameters' do
    log_in_as(@user)
    assert_no_difference('Bean.count') do
      post beans_url, headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" },
                      params: { name: nil, origin: 'Brazil', process: 'natural', roastlevel: 'light', rating: 5, decaf: false }
    end
    assert_response :unprocessable_entity
  end

  test 'should show bean' do
    log_in_as(@user)
    get bean_url(@bean), headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    assert_response :success
  end

  test 'should update a bean' do
    log_in_as(@user)
    bean = @user.beans.first
    patch "/beans/#{bean.id}", params: { process: 'honey' },
                               headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    assert_response :ok
    bean.reload
    assert_equal 'honey', bean.process
  end

  test 'should not update a bean with invalid parameters' do
    log_in_as(@user)
    bean = @user.beans.first
    patch "/beans/#{bean.id}", params: { name: nil },
                               headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    assert_response :unprocessable_entity
  end

  test 'should destroy bean' do
    log_in_as(@user)
    assert_difference('Bean.count', -1) do
      delete "/beans/#{@bean.id}", headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    end
    assert_response :success
  end

  test 'should throw error if user is not the owner of the bean' do
    log_in_as(@user)
    bean = @user.beans.first
    log_in_as(@other_user)
    bean = @user.beans.find_by(id: bean.id)
    get "/beans/#{bean.id}/brews", headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    assert_response :not_found
  end
end
