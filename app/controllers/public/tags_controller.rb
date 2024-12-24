class Public::TagsController < ApplicationController
  def search
  @keyword = params[:keyword] # 検索キーワードを取得
  @tag_name = params[:tag_name]
  @search_type = params[:search_type]

  if @search_type == 'users'
    @users = User.where('name LIKE ?', "%#{@keyword}%")
  else
    if @tag_name.present?
      @tag = Tag.find_by(name: @tag_name)
      @posts = @tag ? @tag.posts : Post.none
    else
      @posts = Post.search_by_keyword(@keyword) 
    end
  end
end

  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.order(created_at: :desc).page(params[:page]).per(6)
  end
end