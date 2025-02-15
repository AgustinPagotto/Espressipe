require 'test_helper'

class BrewTest < ActiveSupport::TestCase
  def setup
    @brew = Brew.new(cofamount: 15, watamount: 200, method: 'espresso', grindsetting: 15.5, temperature: 90,
                     extrationtime: 30, ratingbrew: 5, brewresult: 150, bean_id: 1)
  end
  test 'brew should be valid' do
    assert @brew.valid?
  end
  test 'cofamount should be present' do
    @brew.cofamount = '    '
    assert_not @brew.valid?
  end

  test 'watamount should be present' do
    @brew.watamount = '    '
    assert_not @brew.valid?
  end

  test 'method should be present' do
    @brew.method = '    '
    assert_not @brew.valid?
  end

  test 'brewresult should be present' do
    @brew.brewresult = '    '
    assert_not @brew.valid?
  end

  test 'method should not be too long' do
    @brew.method = 'a' * 31
    assert_not @brew.valid?
  end

  test 'grindsetting should be numerical' do
    @brew.grindsetting = 'abc'
    assert_not @brew.valid?
  end

  test 'temperature should be numerical' do
    @brew.temperature = 'abc'
    assert_not @brew.valid?
  end

  test 'extrationtime should be numerical' do
    @brew.extrationtime = 'abc'
    assert_not @brew.valid?
  end

  test 'ratingbrew should be numerical' do
    @brew.ratingbrew = 'abc'
    assert_not @brew.valid?
  end

  test 'brewresult should be numerical' do
    @brew.brewresult = 'abc'
    assert_not @brew.valid?
  end

  test 'bean_id should be present' do
    @brew.bean_id = nil
    assert_not @brew.valid?
  end

  test 'bean_id should be numerical' do
    @brew.bean_id = 'abc'
    assert_not @brew.valid?
  end

  test 'ratingbrew should be within valid range' do
    @brew.ratingbrew = 6
    assert_not @brew.valid?
    @brew.ratingbrew = -1
    assert_not @brew.valid?
  end
end
