class VehiclesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :json_only!, :authenticate_user!, :clear_params

  def index
    render :json => @user.vehicles, :status => 200
  end

  def create
    @vehicle = @user.vehicles.new(vehicle_params)
    validate_save
  end

  def update
    @vehicle = @user.vehicles.find_by(params[:id])
    @vehicle.attributes = vehicle_params if @vehicle
    validate_save
  end

  def destroy
    vehicle = @user.vehicles.find_by(params[:id])
    vehicle.destroy
  end

  private

  def validate_save
    if @vehicle.save
      render :json => @vehicle, :status => 200
    else
      render :json => { errors: @vehicle.errors.full_messages }, :status => 406
    end
  end

  def vehicle_params
    params.require(:vehicle).permit!
  end

  def clear_params
    render :json => {
      errors: "Please pass a vehicles paramters",
      example: {
        vehicles: {
          nickname: "Batmobile",
          year: "2015",
          model: "Bat",
          make: "Waynes Auto"
        }
      }
    }, :status => 406
  end

  def authenticate_user!
    @user = User.find_by(api_key: params[:api_key])
    render :text => "Invalid api key", :status => 401 unless @user
  end

  def json_only!
    render text: "Invalid format" if request.format != :json
  end
end