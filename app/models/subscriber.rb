class Subscriber < ApplicationRecord
  has_many :sensor_subscribers, dependent: :destroy
  has_many :sensors, through: :sensor_subscribers
  
  validates :fb_id, uniqueness: true
end
