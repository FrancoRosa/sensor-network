require 'test_helper'

class ActuatorHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @actuator_history = actuator_histories(:one)
  end

  test "should get index" do
    get actuator_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_actuator_history_url
    assert_response :success
  end

  test "should create actuator_history" do
    assert_difference('ActuatorHistory.count') do
      post actuator_histories_url, params: { actuator_history: { actuator_id: @actuator_history.actuator_id, current_status: @actuator_history.current_status, expected_status: @actuator_history.expected_status } }
    end

    assert_redirected_to actuator_history_url(ActuatorHistory.last)
  end

  test "should show actuator_history" do
    get actuator_history_url(@actuator_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_actuator_history_url(@actuator_history)
    assert_response :success
  end

  test "should update actuator_history" do
    patch actuator_history_url(@actuator_history), params: { actuator_history: { actuator_id: @actuator_history.actuator_id, current_status: @actuator_history.current_status, expected_status: @actuator_history.expected_status } }
    assert_redirected_to actuator_history_url(@actuator_history)
  end

  test "should destroy actuator_history" do
    assert_difference('ActuatorHistory.count', -1) do
      delete actuator_history_url(@actuator_history)
    end

    assert_redirected_to actuator_histories_url
  end
end
