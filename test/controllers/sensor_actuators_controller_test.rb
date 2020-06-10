require 'test_helper'

class SensorActuatorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sensor_actuator = sensor_actuators(:one)
  end

  test "should get index" do
    get sensor_actuators_url
    assert_response :success
  end

  test "should get new" do
    get new_sensor_actuator_url
    assert_response :success
  end

  test "should create sensor_actuator" do
    assert_difference('SensorActuator.count') do
      post sensor_actuators_url, params: { sensor_actuator: { actuator_id: @sensor_actuator.actuator_id, command_id: @sensor_actuator.command_id, enable: @sensor_actuator.enable, sensor_id: @sensor_actuator.sensor_id, threshold: @sensor_actuator.threshold } }
    end

    assert_redirected_to sensor_actuator_url(SensorActuator.last)
  end

  test "should show sensor_actuator" do
    get sensor_actuator_url(@sensor_actuator)
    assert_response :success
  end

  test "should get edit" do
    get edit_sensor_actuator_url(@sensor_actuator)
    assert_response :success
  end

  test "should update sensor_actuator" do
    patch sensor_actuator_url(@sensor_actuator), params: { sensor_actuator: { actuator_id: @sensor_actuator.actuator_id, command_id: @sensor_actuator.command_id, enable: @sensor_actuator.enable, sensor_id: @sensor_actuator.sensor_id, threshold: @sensor_actuator.threshold } }
    assert_redirected_to sensor_actuator_url(@sensor_actuator)
  end

  test "should destroy sensor_actuator" do
    assert_difference('SensorActuator.count', -1) do
      delete sensor_actuator_url(@sensor_actuator)
    end

    assert_redirected_to sensor_actuators_url
  end
end
