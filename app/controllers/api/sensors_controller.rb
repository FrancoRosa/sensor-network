class API::SensorsController < ApplicationController
  def index
    if params[:sensor][:value].nil?
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
        format.json { render json: {'message': 'true'} }
      end
    end
  end
end