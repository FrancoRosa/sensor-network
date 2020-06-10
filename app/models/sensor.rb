class Sensor < ApplicationRecord
  belongs_to :device
  belongs_to :variable
  has_many :sensor_histories
  
  validates :device_id, presence: true
  validates :variable_id, presence: true
  validates :value, presence: true
  validates_uniqueness_of :device_id, scope: [:variable_id]
  after_update :save_on_history

  private 

  def save_on_history
    SensorHistory.create(sensor_id: id, value: value).save
  end
end
