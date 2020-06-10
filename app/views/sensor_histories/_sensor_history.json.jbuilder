json.extract! sensor_history, :id, :sensor_id, :value, :created_at, :updated_at
json.url sensor_history_url(sensor_history, format: :json)
