class API::SensorsController < ApplicationController
  def index
    if webhook?(params)
      webhook(params)
    elsif params[:sensor][:value].nil?
      if params[:sensor][:id].empty?
        @sensor = Sensor.all
      else
        @sensor = Sensor.where(id: params[:sensor][:id])
      end
      respond_to do |format|
        format.json { render json: @sensor.map {|sensor| [sensor.id, sensor.value] } }
      end
    else
      params[:sensor][:id].each_with_index do |id, index|
        Sensor.find(id).update(value: params[:sensor][:value][index])
      end
      respond_to do |format|
        format.json { render json: { 'message': 'true' } }
      end
    end
  end

  def webhook(params)
    render status: 200, json: { 'message': 'ok' }
  end

  def webhook?(params)
    params.keys.any?{ |x| x.inspect.include?('hub') } ? true : false
  end
end
