class Public::TagsController < ApplicationController
  def search
    if params[:tag_name].present?
      @tag = Tag.find_by(name: params[:tag_name])
      if @tag
        redirect_to tag_path(@tag)
      else
        redirect_to posts_path, alert: 'タグが見つかりませんでした'
      end
    else
      redirect_to posts_path, alert: 'タグ名を入力してください'
    end
  end

  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.order(created_at: :desc).page(params[:page]).per(6)
  end
end