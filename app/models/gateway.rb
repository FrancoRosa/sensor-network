class Gateway < ApplicationRecord
  has_many :gateway_histories, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :message, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
