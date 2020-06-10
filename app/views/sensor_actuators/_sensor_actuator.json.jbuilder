json.extract! sensor_actuator, :id, :sensor_id, :actuator_id, :command_id, :enable, :threshold, :created_at, :updated_at
json.url sensor_actuator_url(sensor_actuator, format: :json)
