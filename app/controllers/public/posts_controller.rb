class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]  

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash.now[:alert] = '投稿に成功しました'
      redirect_to posts_path
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new 
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
      flash.now[:alert] = '投稿が更新されました'
      redirect_to @post
    else
      flash.now[:alert] = '更新に失敗しました'
      render :edit
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
