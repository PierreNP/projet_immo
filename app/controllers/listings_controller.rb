class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  # GET /listings
  def index
    if params[:user_id]
      @listings = Listing.where(landlord: params[:user_id])
      @listings_with_informations = []
      if @listings
      @listings.each do |listing|
        @listing_images = []
        listing.images.each do |image|
          @listing_images << rails_blob_path(image)
        end 
        @listings_with_informations << {listing: listing, place:listing.place, amenity:listing.place.amenities, images: @listing_images}
      end 
      render json: @listings_with_informations
      else  
      render json: @listings
      end 
    else 
    @listings = Listing.all
      @listings_with_informations = []
      @listings.each do |listing|
        @listing_images = []
        listing.images.each do |image|
          @listing_images << rails_blob_path(image)
        end 
        @listings_with_informations << {listing: listing, place:listing.place, amenity:listing.place.amenities, landlord: listing.landlord, images: @listing_images}
      end 
      render json: @listings_with_informations
    end 
  end

  # GET /listings/1
  def show
    @listing_images = []
    @listing.images.each do |image|
      @listing_images << rails_blob_path(image)
    end 
    render json: {listing:@listing, place: @listing.place, amenity:@listing.place.amenities, landlord:@listing.landlord, images:@listing_images}
  end

  # POST /listings
  def create
    @listing = Listing.new(listing_params)
    @place= Place.create(place_params)
    @amenity = Amenity.create(amenity_params)
    TableJointPlaceAmenity.create(place:@place, amenity:@amenity)
    @listing.landlord = current_user
    @listing.place = @place

    @listing_images = []
    if params[:images]
      @listing.images.attach(io: File.open(params[:images]), filename: 'file.pdf')
      @listing.images.each do |image|
        @listing_images << rails_blob_path(image)
      end 
    end 
    if @listing.save
      # UserMailer.listing_confirmation(current_user, @listing).deliver_now
      render json: {listing:@listing, place: @place, amenity:@amenity, landlord:@listing.landlord, images:@listing_images}, status: :created, location: @listing
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /listings/1
  def update
    @listing.place.update(place_params)
    @listing.place.amenities.update(amenity_params) 
    @listing_images = []
    if params[:images]
      @listing.update(images: params[:images])
      @listing.images.each do |image|
        @listing_images << rails_blob_path(image)
      end 
      render json: {listing:@listing, images:@listing_images}
    elsif @listing.landlord == current_user && @listing.update(listing_params)
      @listing.images.each do |image|
        @listing_images << rails_blob_path(image)
      end 
      # UserMailer.listing_update(current_user, @listing).deliver_now
      render json: {listing:@listing, place:@listing.place, amenity:@listing.place.amenities , landlord:@listing.landlord, images:@listing_images}
    elsif @listing.landlord != current_user
      render json: { message: "You are not author of this listing !"}, status: :unauthorized
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /listings/1
  def destroy
    if @listing.landlord == current_user
      @listing.destroy
      # UserMailer.listing_delete(current_user, @listing).deliver_now
      render json: { message: "The listing has been successfully deleted ! "}
    else 
      render json: { message: "You are not landlord of this listing, you can't delete it !"}, status: :unauthorized
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def listing_params

      params.require(:listing).permit(:landlord_id, :place, :amenity, :description, :price, :surface, :location, :title, :status, :images)

    end
    def place_params
      params.require(:place).permit(:place_type, :surface, :story, :location)
    end 
    def amenity_params
      params.require(:amenity).permit(:has_swimming_pool, :has_balcony, :has_concierge, :has_garden, :has_elevator, :is_last_floor, :has_terrace)
    end 
end