require 'test_helper'

class BeanTest < ActiveSupport::TestCase
  setup do
    @bean = Bean.new(name: 'Example Bean', roastlevel: 'light', origin: 'Brazil', process: 'natural', decaf: false,
                     rating: 5, user_id: 1)
    @user = User.create!(name: 'Example User', email: 'asdf@gmail.com', password: 'password',
                         password_confirmation: 'password', id: 1)
  end

  test 'should be valid' do
    assert @bean.valid?
  end

  test 'name should be present' do
    @bean.name = ' '
    assert_not @bean.valid?
  end

  test 'origin should be present' do
    @bean.origin = ' '
    assert_not @bean.valid?
  end

  test 'process should be present' do
    @bean.process = ' '
    assert_not @bean.valid?
  end

  test 'roastlevel should be present' do
    @bean.roastlevel = ' '
    assert_not @bean.valid?
  end

  test 'rating should be an integer' do
    @bean.rating = 5.5
    assert_not @bean.valid?
  end

  test 'decaf should be a boolean' do
    @bean.decaf = nil
    assert_not @bean.valid?
  end

  test 'user_id should be present' do
    @bean.user_id = nil
    assert_not @bean.valid?
  end

  test 'name should not be too long' do
    @bean.name = 'a' * 51
    assert_not @bean.valid?
  end

  test 'origin should not be too long' do
    @bean.origin = 'a' * 31
    assert_not @bean.valid?
  end

  test 'process should not be too long' do
    @bean.process = 'a' * 31
    assert_not @bean.valid?
  end

  test 'roastlevel should not be too long' do
    @bean.roastlevel = 'a' * 31
    assert_not @bean.valid?
  end

  test 'rating should be between 0 and 5' do
    @bean.rating = 6
    assert_not @bean.valid?
  end
end
