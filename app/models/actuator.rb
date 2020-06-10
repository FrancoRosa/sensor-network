class Actuator < ApplicationRecord
  belongs_to :device
  belongs_to :element
  validates :device_id, presence: true
  validates :element_id, presence: true
  validates_uniqueness_of :device_id, scope: [:element_id]
end
