class Public::EventsController < ApplicationController
  def index
    @events = Event.all
    @events = Event.page(params[:page]).per(10)
  end

  def show
    @event = Event.find(params[:id])
    @places = @event.places
  end

  def new
    @event = Event.new
    @places = Place.all
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: 'イベントを登録しました'
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end  

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash.now[:alert] = '場所が更新されました'
      redirect_to event_path
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :body, :start_date, :end_date, place_id)
  end
end

