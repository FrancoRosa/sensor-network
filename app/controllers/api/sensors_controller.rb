class API::SensorsController < ApplicationController
  def index
    if params[:id].nil?
      @sensor = Sensor.all
    else
      @sensor = Sensor.where(id: params[:id])
    end
    respond_to do |format|
      format.json { render json: @sensor }
    end
  end
end