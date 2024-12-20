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
    @places = Place.all
    @events = Event.all
  end

  def create
    selected_postables = []

    # 選択された Place を取得
    if params[:post][:place_ids].present?
      selected_postables += Place.where(id: params[:post][:place_ids])
    end

    # 選択された Event を取得
    if params[:post][:event_ids].present?
      selected_postables += Event.where(id: params[:post][:event_ids])
    end

    # 選択された postable に対してポストを作成
    if selected_postables.present?
      selected_postables.each do |postable|
        Post.create(
          title: params[:post][:title],
          body: params[:post][:body],
          user: current_user,
          postable: postable
        )
      end
      redirect_to posts_path, notice: "投稿に成功しました"
    else
      flash.now[:alert] = "場所またはイベントを選択してください"
      @places = Place.all
      @events = Event.all
      render :new
    end
  end  

  def index
    @posts = Post.all
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:page]).per(6) # 1ページあたり6件    
  end

  def show
    @post = Post.find(params[:id])
    @reviews = Review.all
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

  def search
    @keyword = params[:keyword] # 検索キーワードを取得
    @posts = Post.search_by_keyword(@keyword)
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
