class API::ActuatorsController < ApplicationController
  def index
    if params[:id].nil?
      @actuator = Actuator.all
    else
      @actuator = Actuator.where(id: params[:id])
    end
    respond_to do |format|
      format.json { render json: @actuator }
    end
  end
end