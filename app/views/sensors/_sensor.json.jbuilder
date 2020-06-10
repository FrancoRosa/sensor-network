json.extract! sensor, :id, :device, :variable, :value, :created_at, :updated_at
json.url sensor_url(sensor, format: :json)
