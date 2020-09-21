class Sensor < ApplicationRecord
  belongs_to :device
  belongs_to :variable
  has_many :sensor_histories, dependent: :destroy
  has_many :sensor_actuators, dependent: :destroy
  has_many :sensor_subscribers, dependent: :destroy
  has_many :subscribers, through: :sensor_subscribers
  
  validates :device_id, presence: true
  validates :variable_id, presence: true
  validates :value, presence: true
  validates_uniqueness_of :device_id, scope: [:variable_id]
  after_update :save_on_history, :update_actuators, :send_messages

  def features
    "#{Sensor.find(id).device.name}, #{Sensor.find(id).variable.name}"
  end

  private

  def save_on_history
    SensorHistory.create(sensor_id: id, value: value).save
  end

  def update_actuators
    sensoractuators = SensorActuator.where(sensor: id)
    sensoractuators.each do |sensoractuator|
      if sensoractuator.enable
        sensor = sensoractuator.sensor
        actuator = sensoractuator.actuator
        command = sensoractuator.command
        actuator.update(expected_status: command.status) if eval(command.condition)
        # Imrpove this part
      end
    end
  end

  def send_messages
    @sensor = Sensor.find(id)
    @variable = @sensor.variable
    response = { text: "#{@variable.name}: #{@sensor.value}#{@variable.unit}" }
    Sensor.find(id).subscribers.each do |subscriber|
      callSendAPI(subscriber[:fb_id], response)
    end
  end

  def callSendAPI(sender_psid, response)
    uri = "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['fb_key']}"
    body = { recipient: {id: sender_psid}, message: response } 
    x = Net::HTTP.post(URI.parse(uri), body.to_json, "Content-Type" => "application/json")
  end
end
