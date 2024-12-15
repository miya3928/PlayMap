class Public::PlacesController < ApplicationController
  def index
    @places = Place.all
  end
  
  def show
    @place = Place.find(params[:id])
    @events = @place.events
  end
  
  def new
    @place = Place.new
  end
  
  def create
    @place =Place.new(place_params)
    if @place.save
      redirect_to @place, notice: "場所を登録しました。"
    else
      render :new
    end
  end
  
 private

  def place_params
    params.require(:place).permit(:name, :address, :description, :latitude, :longitude)

end
