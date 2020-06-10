class SensorActuator < ApplicationRecord
  belongs_to :sensor
  belongs_to :actuator
  belongs_to :command
end
