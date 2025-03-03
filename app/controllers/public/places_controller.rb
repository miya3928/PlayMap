class Public::PlacesController < ApplicationController
  def index
    @places = Place.all
    @places = Place.page(params[:page]).per(10)
  end
  
  def show
    @place = Place.find(params[:id])
    @events = @place.events
  end
  
  def new
    @place = Place.new
    @events = Event.all
  end
  
  def create
    @place = Place.new(place_params)
    if @place.save
      redirect_to @place, notice: '場所が作成されました！'
    else
      render :new
    end
  end


  def edit
    @place = Place.find(params[:id])
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
      flash.now[:alert] = '場所が更新されました'
      redirect_to place_path
    else
      render :edit
    end
  end

  def search_address
    postal_code = params[:postal_code]
    
    if postal_code.present?
      # 住所検索用の API（Google Maps API など）を使用
      address = Geocoder.search(postal_code).first

      if address
        render json: {
          prefecture: address.state,
          city: address.city,
          street: address.address
        }
      else
        render json: { error: '住所が見つかりませんでした' }, status: 404
      end
    else
      render json: { error: '郵便番号が指定されていません' }, status: 400
    end
  end
  
 private

  def place_params
    params.require(:place).permit(:name, :address, :description, :latitude, :longitude, event_ids: [])
  end
end
