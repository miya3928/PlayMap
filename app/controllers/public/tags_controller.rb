class Public::TagsController < ApplicationController
 
  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.order(created_at: :desc).page(params[:page]).per(6)
  end
end