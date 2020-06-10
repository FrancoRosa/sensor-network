class ActuatorHistoriesController < ApplicationController
  before_action :set_actuator_history, only: [:show, :edit, :update, :destroy]

  # GET /actuator_histories
  # GET /actuator_histories.json
  def index
    @actuator_histories = ActuatorHistory.all
  end

  # GET /actuator_histories/1
  # GET /actuator_histories/1.json
  def show
  end

  # GET /actuator_histories/new
  def new
    @actuator_history = ActuatorHistory.new
  end

  # GET /actuator_histories/1/edit
  def edit
  end

  # POST /actuator_histories
  # POST /actuator_histories.json
  def create
    @actuator_history = ActuatorHistory.new(actuator_history_params)

    respond_to do |format|
      if @actuator_history.save
        format.html { redirect_to @actuator_history, notice: 'Actuator history was successfully created.' }
        format.json { render :show, status: :created, location: @actuator_history }
      else
        format.html { render :new }
        format.json { render json: @actuator_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actuator_histories/1
  # PATCH/PUT /actuator_histories/1.json
  def update
    respond_to do |format|
      if @actuator_history.update(actuator_history_params)
        format.html { redirect_to @actuator_history, notice: 'Actuator history was successfully updated.' }
        format.json { render :show, status: :ok, location: @actuator_history }
      else
        format.html { render :edit }
        format.json { render json: @actuator_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actuator_histories/1
  # DELETE /actuator_histories/1.json
  def destroy
    @actuator_history.destroy
    respond_to do |format|
      format.html { redirect_to actuator_histories_url, notice: 'Actuator history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actuator_history
      @actuator_history = ActuatorHistory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def actuator_history_params
      params.require(:actuator_history).permit(:actuator_id, :expected_status, :current_status)
    end
end
