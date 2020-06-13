class API::ActuatorsController < ApplicationController
  def index
    if params[:actuator].empty?
      respond_to do |format|
        format.json { render json: { token: SensorNetwork::Application::TOKEN } }
      end
    else
      if params[:actuator][:expected_status].nil?
        if params[:actuator][:id].empty?
          @actuator = Actuator.all
        else
          @actuator = Actuator.where(id: params[:actuator][:id])
        end
        respond_to do |format|
          format.json { render json: @actuator.map {|actuator| [actuator.id, actuator.current_status] } }
        end
      else
        params[:actuator][:id].each_with_index do |id, index|
          Actuator.find(id).update(expected_status: params[:actuator][:expected_status][index])
        end
        respond_to do |format|
          format.json { render json: {message: 'true'} }
        end
      end
    end
  end
end