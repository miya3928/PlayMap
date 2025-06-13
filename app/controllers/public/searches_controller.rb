class Public::SearchesController < ApplicationController
def search
  @search_type = params[:search_type]
  @keyword     = params[:search_query]
  @results     = []

  case @search_type
  when 'users'
    @results = User.where('name LIKE ?', "%#{@keyword}%").where(is_active: true)
  when 'posts'
    @results = Post.where('title LIKE ? OR body LIKE ?', "%#{@keyword}%", "%#{@keyword}%")
  when 'place'
    @results = Place.all
    @results = @results.where(prefecture_code: params[:prefecture_code]) if params[:prefecture_code].present?
    @results = @results.where("city LIKE ?", "%#{params[:city]}%") if params[:city].present?
  end

  render :search
end
end