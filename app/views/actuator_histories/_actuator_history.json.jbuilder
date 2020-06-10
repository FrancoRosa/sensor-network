json.extract! actuator_history, :id, :actuator_id, :expected_status, :current_status, :created_at, :updated_at
json.url actuator_history_url(actuator_history, format: :json)
