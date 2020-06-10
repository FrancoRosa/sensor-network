class SensorHistoriesController < ApplicationController
  before_action :set_sensor_history, only: [:show, :edit, :update, :destroy]

  # GET /sensor_histories
  # GET /sensor_histories.json
  def index
    @sensor_histories = SensorHistory.all
  end

  # GET /sensor_histories/1
  # GET /sensor_histories/1.json
  def show
  end

  # GET /sensor_histories/new
  def new
    @sensor_history = SensorHistory.new
  end

  # GET /sensor_histories/1/edit
  def edit
  end

  # POST /sensor_histories
  # POST /sensor_histories.json
  def create
    @sensor_history = SensorHistory.new(sensor_history_params)

    respond_to do |format|
      if @sensor_history.save
        format.html { redirect_to @sensor_history, notice: 'Sensor history was successfully created.' }
        format.json { render :show, status: :created, location: @sensor_history }
      else
        format.html { render :new }
        format.json { render json: @sensor_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sensor_histories/1
  # PATCH/PUT /sensor_histories/1.json
  def update
    respond_to do |format|
      if @sensor_history.update(sensor_history_params)
        format.html { redirect_to @sensor_history, notice: 'Sensor history was successfully updated.' }
        format.json { render :show, status: :ok, location: @sensor_history }
      else
        format.html { render :edit }
        format.json { render json: @sensor_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sensor_histories/1
  # DELETE /sensor_histories/1.json
  def destroy
    @sensor_history.destroy
    respond_to do |format|
      format.html { redirect_to sensor_histories_url, notice: 'Sensor history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensor_history
      @sensor_history = SensorHistory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sensor_history_params
      params.require(:sensor_history).permit(:sensor_id, :value)
    end
end
