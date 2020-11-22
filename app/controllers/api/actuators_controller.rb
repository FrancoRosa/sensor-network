class API::ActuatorsController < ApplicationController
  def index
    if get_token?
      get_token
    elsif save_actuator_status?
      save_actuator_status
    elsif update_actuator_status?
      update_actuator_status
    else
      params[:actuator][:id].each_with_index do |id, index|
        Actuator.find(id).update(expected_status: params[:actuator][:expected_status][index])
      end
      render json: {message: 'true'}
    end
  end

  def get_token?
    params[:actuator].include?(:token)
  end

  def get_token
    render json: { token: SensorNetwork::Application::TOKEN }
  end

  def update_actuator_status?
    params[:actuator][:expected_status].nil?
  end

  def update_actuator_status
    if params[:actuator][:id].empty? 
      @actuator = Actuator.all
    else
      @actuator = Actuator.where(id: params[:actuator][:id])
    end
    render json: @actuator.map {|actuator| [actuator.id, actuator.expected_status] }
  end

  def save_actuator_status?
    params[:actuator].include?(:current_status)
  end

  def save_actuator_status
    p 'save actuator current status'
    params[:actuator][:id].each_with_index do |id, index|
      Actuator.find(id).update(current_status: params[:actuator][:current_status][index])
    end
    render json: {message: 'true'}
  end

end

