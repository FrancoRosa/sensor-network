class Device < ApplicationRecord
  has_many :sensors, dependent: :destroy
  has_many :actuators, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :tx_period, presence: true
  validates :tx_slot, presence: true
  validates :rx_time, presence: true
end
