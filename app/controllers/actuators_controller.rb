class ActuatorsController < ApplicationController
  before_action :set_actuator, only: [:show, :edit, :update, :destroy]

  # GET /actuators
  # GET /actuators.json
  def index
    @actuators = Actuator.all
  end

  # GET /actuators/1
  # GET /actuators/1.json
  def show
    @history = ActuatorHistory.where(actuator_id: params[:id]).order('created_at')
  end

  # GET /actuators/new
  def new
    @actuator = Actuator.new
    @device = Device.find(params[:device_id])
  end

  # GET /actuators/1/edit
  def edit
  end

  # POST /actuators
  # POST /actuators.json
  def create
    @actuator = Actuator.new(actuator_params)
    @device = Device.find(params[:actuator][:device_id])

    respond_to do |format|
      if @actuator.save
        format.html { redirect_to @actuator, notice: 'Actuator was successfully created.' }
        format.json { render :show, status: :created, location: @actuator }
      else
        format.html { render :new }
        format.json { render json: @actuator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actuators/1
  # PATCH/PUT /actuators/1.json
  def update
    respond_to do |format|
      if @actuator.update(actuator_params)
        format.html { redirect_to @actuator, notice: 'Actuator was successfully updated.' }
        format.json { render :show, status: :ok, location: @actuator }
      else
        format.html { render :edit }
        format.json { render json: @actuator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actuators/1
  # DELETE /actuators/1.json
  def destroy
    @device = @actuator.device
    @actuator.destroy
    redirect_to device_path(@device), notice: 'Actuator was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actuator
      @actuator = Actuator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def actuator_params
      params.require(:actuator).permit(:device_id, :element_id, :expected_status, :current_status)
    end
end
