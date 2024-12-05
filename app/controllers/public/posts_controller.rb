class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]  

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: '投稿に成功しました！'
    else
      render :new,  notice: '投稿に失敗しました。'
    end  
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: '投稿が更新されました！'
    else
      render :edit, alert: '更新に失敗しました!'
    end
  end

  def destroy
    @post =Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '投稿が削除されました！'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
