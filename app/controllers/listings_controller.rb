class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :show, :update, :destroy]

  # GET /listings
  def index
    @listings = Listing.all
      @listings_with_images = []
      @listings.each do |listing|
        @listing_images = []
        listing.images.each do |image|
          puts "*" * 10
          puts rails_blob_path(image)
          puts "*" * 10
          @listing_images << rails_blob_path(image)
        end 
        @listings_with_images << {listing: listing, images: @listing_images}
        puts "*" * 10
        puts @listings_with_images
        puts "*" * 10
      end 
      render json: @listings_with_images
  end

  # GET /listings/1
  def show
    @listing_images = []
    @listing.images.each do |image|
      @listing_images << rails_blob_path(image)
    end 
    render json: {listing:@listing, images:@listing_images}
  end

  # POST /listings
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    @listing_images = []
    if params[:images]
      @listing.images.attach(io: File.open(params[:images]), filename: 'file.pdf')
      @listing.images.each do |image|
        @listing_images << rails_blob_path(image)
      end 
    end 
    if @listing.save

      render json: {listing:@listing, images:@listing_images}, status: :created, location: @listing
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /listings/1
  def update
    @listing_images = []
    if params[:images]
      puts "*"*100
      puts"j'ai une image"
      puts params[:images]
      puts "*"*100
      @listing.update(images: params[:images])
      @listing.images.each do |image|
        @listing_images << rails_blob_path(image)
      end 
      render json: {listing:@listing, images:@listing_images}
    elsif @listing.user_id == current_user.id && @listing.update(listing_params)
      @listing.images.each do |image|
        @listing_images << rails_blob_path(image)
      end 
      render json: {listing:@listing, images:@listing_images}
    elsif @listing.user_id != current_user.id
      render json: { message: "You are not author of this listing !"}, status: :unauthorized
    else
      render json: @listing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /listings/1
  def destroy
    if @listing.user_id == current_user.id
      @listing.destroy
    else 
      render json: { message: "Vous n'êtes pas l'auteur de ce post"}, status: :unauthorized
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(:user_id, :description, :price, :surface, :location, :title, :status, :images)
    end
end
