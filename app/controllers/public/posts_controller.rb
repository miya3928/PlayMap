class Public::PostsController < ApplicationController
  before_action :guest_check, only: [:create, :update, :destroy]
  before_action :authenticate_user!
  before_action :current_post_user, only:[:edit, :update]  

  def guest_check
    if current_user.guest?
      redirect_to root_path, notice: "このページを利用するには会員登録が必要です。"
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash.now[:alert] = '投稿に成功しました'
      redirect_to @post
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new 
    end  
  end

  def index
    @posts = Post.all
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:page]).per(6) # 1ページあたり6件    
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
    flash.now[:alert] =  '投稿が削除されました！'
    redirect_to mypage_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def current_post_user
    post = Post.find(params[:id])
    unless current_user == post.user
      redirect_to posts_path, alert: "他のユーザーの投稿を編集することはできません"
    end
  end   
end
