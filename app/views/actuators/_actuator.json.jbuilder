json.extract! actuator, :id, :element, :device, :expected_status, :current_status, :created_at, :updated_at
json.url actuator_url(actuator, format: :json)
