class API::ActuatorsController < ApplicationController
  def index
    if read_token?(params)
      read_token(params)
    elsif read_actuators?(params)
      read_actuators(params)
    else
      update_actuators
    end
  end
end

def read_actuators?(params)
  params[:actuator][:expected_status].nil?
end

def read_actuators(params)
  if params[:actuator][:id].empty?
    @actuator = Actuator.all
  else
    @actuator = Actuator.where(id: params[:actuator][:id])
  end

  render json: @actuator.map { |actuator| [actuator.id, actuator.expected_status] }
end

def update_actuators(params)
  params[:actuator][:id].each_with_index do |id, index|
    Actuator.find(id).update(expected_status: params[:actuator][:expected_status][index])
  end
  render json: {message: 'true'}
end

def read_token?(params)
  params[:actuator].empty?
end

def read_token(params)
  render json: { token: SensorNetwork::Application::TOKEN }
end
