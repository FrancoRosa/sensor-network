class DevicesController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_device, only: [:show, :edit, :update, :destroy]


  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.all
  end

  def map
    @devices = Device.all
  end
  # GET /devices/1
  # GET /devices/1.json
  def show
    @devices = Device.all
  end

  # GET /devices/new
  def new
    @device = Device.new
    @devices = Device.all
  end

  # GET /devices/1/edit
  def edit
    @devices = Device.all
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    redirect_to devices_url, notice: 'Device was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def device_params
      params.require(:device).permit(:name, :latitude, :longitude, :description, :tx_period, :tx_slot, :rx_time)
    end
end
