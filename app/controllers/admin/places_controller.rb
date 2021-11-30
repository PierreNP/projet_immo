class Admin::PlacesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  before_action :set_place, only: [:show, :update, :destroy]

  def index
    @all_places = Place.all
    render json: {places: @all_places}
  end

  def show
    render json: {place: @place}
  end

  def create
    @place = Place.create(admin_place_params)
    if @place.save
      render json: {message: "Place successfully created"}
    else
      render json: {message: "Place unsuccessfully created"}
    end
  end

  def update
    
    if @place.update(admin_place_params)
      render json: {message: "Place successfully updated"}
    else
      render json: {message: "Update error"}
    end
  end

  def destroy
    if @place.destroy
      render json: {message: "Place successfully deleted (you are admin, you do what you want)"}
    else
      render json: {message: "Place NOT successfully deleted (you are admin, you do what you want but it still didn't work)"}
    end
  end 

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def admin_place_params
    params.require(:listing).permit(:landlord_id, :place_id, :price, :title, :description, :status)
  end

end