class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:page]).per(6) # 1ページあたり6件
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post =Post.find(params[:id])
    @post.destroy
    flash.now[:alert] =  '投稿が削除されました！'
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
