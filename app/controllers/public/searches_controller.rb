class Public::SearchesController < ApplicationController
  def search
    @search_type = params[:search_type]
    @keyword = params[:search_query]
    @results = []

    if @search_type == 'users'
      @results = User.where('name LIKE ?', "%#{@keyword}%")
    elsif @search_type == 'posts'
      @results = Post.where('title LIKE ? OR body LIKE ?', "%#{@keyword}%", "%#{@keyword}%")
    end

    render :search
  end
end
