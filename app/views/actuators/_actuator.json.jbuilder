json.extract! actuator, :id, :device_id, :element_id, :expected_status, :current_status, :created_at, :updated_at
json.url actuator_url(actuator, format: :json)
