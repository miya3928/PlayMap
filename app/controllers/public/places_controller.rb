require 'net/http'
require 'uri'
require 'json'

class Public::PlacesController < ApplicationController
  def index
    @places = Place.all
    @places = Place.page(params[:page]).per(9)

  case params[:sort]
  when "newest"
    @places = @places.order(created_at: :desc)
  when "oldest"
    @places = @places.order(created_at: :asc)
  end
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
    @events = Event.all
    if @place.save
      redirect_to @place, notice: '場所が作成されました！'
    else
      Rails.logger.debug @place.errors.full_messages 
      render :new, alert: '場所の作成に失敗しました。'
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
        uri = URI("https://zipcloud.ibsnet.co.jp/api/search?zipcode=#{postal_code}")
        response = Net::HTTP.get(uri)
        result = JSON.parse(response)
  
        if result["results"]
          address = result["results"][0]
          render json: {
            prefecture: address["address1"],  # 例：東京都
            city: address["address2"],        # 例：新宿区
            street: address["address3"]       # 例：西新宿
          }
        else
          render json: { error: '住所が見つかりませんでした' }, status: 404
        end
      else
        render json: { error: '郵便番号が指定されていません' }, status: 400
      end
    end
  end

  
 private

  def place_params
    params.require(:place).permit(:name, :address, :description, :latitude, :longitude, :prefecture, :zipcode, :city, :street, :image, :prefecture_name, event_ids: [])
  end

