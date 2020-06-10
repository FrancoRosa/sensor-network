class Sensor < ApplicationRecord
  belongs_to :device
  validates :device_id, presence: true
  validates :variable_id, presence: true
  validates :value, presence: true

  def sensor_device
    @device = Device.find(device_id)
  end

  def sensor_variable
    @variable = Variable.find(variable_id)
  end
  
end
