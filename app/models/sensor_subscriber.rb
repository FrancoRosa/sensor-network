class SensorSubscriber < ApplicationRecord
  belongs_to :sensor
  belongs_to :subscriber
  
  validates :sensor, presence: true
  validates :subscriber, presence: true
end
