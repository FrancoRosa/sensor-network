class SensorActuatorsController < ApplicationController
  before_action :set_sensor_actuator, only: [:show, :edit, :update, :destroy]

  # GET /sensor_actuators
  # GET /sensor_actuators.json
  def index
    @sensor_actuators = SensorActuator.all
    @devices = Device.all
  end

  # GET /sensor_actuators/1
  # GET /sensor_actuators/1.json
  def show
    @devices = Device.all
  end

  # GET /sensor_actuators/new
  def new
    @devices = Device.all
    @sensor_actuator = SensorActuator.new
  end

  # GET /sensor_actuators/1/edit
  def edit
  end

  # POST /sensor_actuators
  # POST /sensor_actuators.json
  def create
    @sensor_actuator = SensorActuator.new(sensor_actuator_params)

    respond_to do |format|
      if @sensor_actuator.save
        format.html { redirect_to @sensor_actuator, notice: 'Sensor actuator was successfully created.' }
        format.json { render :show, status: :created, location: @sensor_actuator }
      else
        format.html { render :new }
        format.json { render json: @sensor_actuator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sensor_actuators/1
  # PATCH/PUT /sensor_actuators/1.json
  def update
    respond_to do |format|
      if @sensor_actuator.update(sensor_actuator_params)
        format.html { redirect_to @sensor_actuator, notice: 'Sensor actuator was successfully updated.' }
        format.json { render :show, status: :ok, location: @sensor_actuator }
      else
        format.html { render :edit }
        format.json { render json: @sensor_actuator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sensor_actuators/1
  # DELETE /sensor_actuators/1.json
  def destroy
    @sensor_actuator.destroy
    respond_to do |format|
      format.html { redirect_to sensor_actuators_url, notice: 'Sensor actuator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensor_actuator
      @sensor_actuator = SensorActuator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sensor_actuator_params
      params.require(:sensor_actuator).permit(:sensor_id, :actuator_id, :command_id, :enable, :threshold)
    end
end
