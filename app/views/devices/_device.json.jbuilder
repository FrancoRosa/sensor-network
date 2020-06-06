json.extract! device, :id, :name, :latitude, :longitude, :description, :tx_period, :tx_slot, :rx_time, :created_at, :updated_at
json.url device_url(device, format: :json)
