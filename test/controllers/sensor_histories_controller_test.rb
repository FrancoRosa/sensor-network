require 'test_helper'

class SensorHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sensor_history = sensor_histories(:one)
  end

  test "should get index" do
    get sensor_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_sensor_history_url
    assert_response :success
  end

  test "should create sensor_history" do
    assert_difference('SensorHistory.count') do
      post sensor_histories_url, params: { sensor_history: { sensor_id: @sensor_history.sensor_id, value: @sensor_history.value } }
    end

    assert_redirected_to sensor_history_url(SensorHistory.last)
  end

  test "should show sensor_history" do
    get sensor_history_url(@sensor_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_sensor_history_url(@sensor_history)
    assert_response :success
  end

  test "should update sensor_history" do
    patch sensor_history_url(@sensor_history), params: { sensor_history: { sensor_id: @sensor_history.sensor_id, value: @sensor_history.value } }
    assert_redirected_to sensor_history_url(@sensor_history)
  end

  test "should destroy sensor_history" do
    assert_difference('SensorHistory.count', -1) do
      delete sensor_history_url(@sensor_history)
    end

    assert_redirected_to sensor_histories_url
  end
end
