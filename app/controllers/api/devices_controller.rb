class API::DevicesController < ApplicationController
  def index
    read_devices(params) if read_devices?(params)
    read_device_sensors(params) if read_device_sensors?(params)
    read_device_actuators(params) if read_device_actuators?(params)
    update_devices(params) if update_devices?(params)
  end

  def read_devices?(params)
    params[:devices][:data].nil? && params[:devices][:sensors].nil? && params[:devices][:actuators].nil?
  end

  def read_devices(params)
    if params[:devices][:sensors].nil? && params[:devices][:actuators].nil?
      if params[:devices][:id].empty?
        @device = Device.all
      else
        @device = Device.where(id: params[:devices][:id])
      end
    end
    render json: @device
  end

  def update_devices?(params)
    !params[:devices][:data].nil?
  end

  def update_devices(params)
    id = params[:devices][:id]
    if Device.exists?(id)
      params[:devices][:data].each_pair do |key, value|
        pair = Hash[key, value]
        Device.find(id).update(pair)
      end
      render json: { 'message': 'true' }
    else
      render json: { 'message': 'false' }
    end
  end

  def read_device_sensors?(params)
    !params[:devices][:sensors].nil?
  end

  def read_device_sensors(params)
    sensors = Device.where(id: params[:devices][:id])[0].sensors.pluck(:id)
    render json: sensors
  end

  def read_device_actuators?(params)
    params[:devices][:sensors].nil? && !params[:devices][:actuators].nil?
  end

  def read_device_actuators(params)
    actuators = Device.where(id: params[:devices][:id])[0].actuators.pluck(:id)
    render json: actuators
  end
end
