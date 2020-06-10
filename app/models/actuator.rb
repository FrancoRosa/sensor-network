class Actuator < ApplicationRecord
  belongs_to :device
  belongs_to :element
  has_many :actuator_histories
  validates :device_id, presence: true
  validates :element_id, presence: true
  validates_uniqueness_of :device_id, scope: [:element_id]
  after_update :save_on_history
  
  private 

  def save_on_history
    ActuatorHistory.create(actuator_id: id, expected_status: expected_status, current_status: current_status).save
  end
end
