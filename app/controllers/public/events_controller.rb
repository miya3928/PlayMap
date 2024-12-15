class Public::EventsController < ApplicationController
  def index
    @events = Event.all
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

  private

  def event_params
    params.require(:event).permit(:title, :body, :start_date, :end_date, place_ids: [])
  end
end

