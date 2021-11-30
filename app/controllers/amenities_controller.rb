class AmenitiesController < ApplicationController
  before_action :set_amenity, only: [:show, :update, :destroy]

  # GET /places
  def index
    @amenities = Amenity.all

    render json: @amenities
  end

  # GET /places/1
  def show
    render json: @amenity
  end

  # POST /places
  def create
    @amenity = Amenity.new(place_params)

    if @amenity.save
      render json: @amenity, status: :created, location: @amenity
    else
      render json: @amenity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /places/1
  def update
    if @amenity.update(place_params)
      render json: @amenity
    else
      render json: @amenity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /places/1
  def destroy
    @amenity.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amenity
      @amenity = Amenity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def amenity_params
      params.require(:amenity).permit(:has_swimming_pool, :has_balcony, :has_concierge, :has_garden, :has_elevator, :is_last_floor, :has_terrace)
    end
end