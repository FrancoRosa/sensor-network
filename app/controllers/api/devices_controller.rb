class API::DevicesController < ApplicationController
  def index
    if read_devices?(params)
      read_devices(params)
    elsif update_devices?(params)
      update_devices(params)
    end
  end

  def read_devices?(params)
    params[:devices][:data].nil?
  end

  def read_devices(params)
    if params[:devices][:id].empty?
      @device = Device.all
    else
      @device = Device.where(id: params[:devices][:id])
    end
    render json: @device.map { |dev| [dev.id, dev.tx_period, dev.tx_slot, dev.rx_time] }
  end

  def update_devices?(params)
    !params[:devices][:data].nil?
  end

  def update_devices(params)
    id = params[:devices][:id]
    if Device.exists?(id)
      params[:devices][:data].keys.each do |key|
        value = params[:devices][:data][key]
        pair = Hash[key, value]
        Device.find(id).update(pair)
      end
      render json: { 'message': 'true' }
    else
      render json: { 'message': 'false' }
    end
  end
end