class SensorsController < ApplicationController
  before_action :set_sensor, only: [:show, :edit, :update, :destroy]

  # GET /sensors
  # GET /sensors.json
  def index
    @sensors = Sensor.all
  end

  # GET /sensors/1
  # GET /sensors/1.json
  def show
    @history = SensorHistory.where(sensor_id: params[:id]).order('created_at')
  end

  # GET /sensors/new
  def new
    @sensor = Sensor.new
    @device = Device.find(params[:device_id])
    @device_options = Device.all.map { |x| [x.name, x.id] }
    @variable_options = Variable.all.map { |x| [x.name, x.id] }
  end

  # GET /sensors/1/edit
  def edit
  end

  # POST /sensors
  # POST /sensors.json
  def create
    @sensor = Sensor.new(sensor_params)

    respond_to do |format|
      if @sensor.save
        format.html { redirect_to @sensor, notice: 'Sensor was successfully created.' }
        format.json { render :show, status: :created, location: @sensor }
      else
        format.html { render :new }
        format.json { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sensors/1
  # PATCH/PUT /sensors/1.json
  def update
    respond_to do |format|
      if @sensor.update(sensor_params)
        format.html { redirect_to @sensor, notice: 'Sensor was successfully updated.' }
        format.json { render :show, status: :ok, location: @sensor }
      else
        format.html { render :edit }
        format.json { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sensors/1
  # DELETE /sensors/1.json
  def destroy
    @device = @sensor.device
    @sensor.destroy
    redirect_to device_path(@device), notice: 'Sensor was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensor
      @sensor = Sensor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sensor_params
      params.require(:sensor).permit(:device_id, :variable_id, :value)
    end
end
