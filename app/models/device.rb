class Device < ApplicationRecord
  has_many :sensors, dependent: :destroy
  has_many :actuators, dependent: :destroy
end
