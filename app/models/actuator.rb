class Actuator < ApplicationRecord
  belongs_to :device
  belongs_to :element
  has_many :actuator_histories, dependent: :destroy
  has_many :sensor_actuators, dependent: :destroy

  validates :device_id, presence: true
  validates :element_id, presence: true
  validates_uniqueness_of :device_id, scope: [:element_id]
  after_update :save_on_history
  def features
    "#{Actuator.find(id).device.name}, #{Actuator.find(id).element.name}"
  end

  def save_on_history
    SensorNetwork::Application::TOKEN += 1
    ActuatorHistory.create(actuator_id: id, expected_status: expected_status, current_status: current_status).save
  end
end
