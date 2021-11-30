class Admin::ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  before_action :set_listing, only: [:show, :update, :destroy]

  def index
    @all_listings = Listing.all
    render json: {listings: @all_listings}
  end

  def show
    render json: {listing: @listing}
  end

  def create
    @listing = Listing.create(admin_listing_params)
    if @listing.save
      render json: {message: "Listing successfully created"}
    else
      render json: {message: "Listing unsuccessfully created"}
    end
  end

  def update
    
    if @listing.update(admin_listing_params)
      render json: {message: "Listing successfully updated"}
    else
      render json: {message: "Update error"}
    end
  end

  def destroy
    if @listing.destroy
      render json: {message: "Listing successfully deleted (you are admin, you do what you want)"}
    else
      render json: {message: "Listing NOT successfully deleted (you are admin, you do what you want but it still didn't work)"}
    end
  end 

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def admin_listing_params
    params.require(:listing).permit(:landlord_id, :place_id, :price, :title, :description, :status)
  end

end
