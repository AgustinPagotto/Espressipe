require 'test_helper'

class BrewsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @brew = brews(:two)
    @bean = beans(:two)
  end

  test 'should get all brews of an specific bean' do
    log_in_as(@user)
    bean = @user.beans.first
    get "/beans/#{bean.id}/brews", headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    brews = response.parsed_body
    assert_equal 2, brews.size
  end

  test 'should get all brews of the user' do
    log_in_as(@user)
    get '/users/brews', headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    brews = response.parsed_body
    assert_equal 3, brews.size
  end

  test 'should throw error if user is not the owner of the bean/brews' do
    log_in_as(@user)
    bean = @user.beans.first
    log_in_as(@other_user)
    bean = @user.beans.find_by(id: bean.id)
    get "/beans/#{bean.id}/brews", headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    assert_response :not_found
  end

  test 'should get an specific brew' do
    log_in_as(@user)
    bean = @user.beans.first
    get "/beans/#{bean.id}/brews/#{@brew[:id]}", headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    brew = response.parsed_body
    assert_equal @brew[:id], brew['id']
  end

  test 'should create a brew' do
    log_in_as(@user)
    bean = @user.beans.first
    assert_difference 'Brew.count', 1 do
      post "/beans/#{bean.id}/brews",
           params: @brew.attributes.except('id'), headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    end
    assert_response :created
  end

  test 'should not create a brew with invalid parameters' do
    log_in_as(@user)
    bean = @user.beans.first
    assert_no_difference 'Brew.count' do
      post "/beans/#{bean.id}/brews", params: { cofamount: nil, watamount: 300, method: 'Pour Over' },
                                      headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    end
    assert_response :unprocessable_entity
  end

  test 'should update a brew' do
    log_in_as(@user)
    bean = @user.beans.first
    brew = bean.brews.first
    patch "/beans/#{bean.id}/brews/#{brew.id}", params: { cofamount: 25 },
                                                headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    assert_response :ok
    brew.reload
    assert_equal 25, brew.cofamount
  end

  test 'should not update a brew with invalid parameters' do
    log_in_as(@user)
    bean = @user.beans.first
    brew = bean.brews.first
    patch "/beans/#{bean.id}/brews/#{brew.id}", params: { cofamount: nil },
                                                headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    assert_response :unprocessable_entity
  end

  test 'should destroy a brew' do
    log_in_as(@user)
    bean = @user.beans.first
    brew = bean.brews.first
    assert_difference 'Brew.count', -1 do
      delete "/beans/#{bean.id}/brews/#{brew.id}",
             headers: { HTTP_AUTHORIZATION: "JWT #{response.parsed_body['token']}" }
    end
    assert_response :ok
  end
end
