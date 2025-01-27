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
    @tags = Tag.all
  end

  def create
    selected_postables = []
  
    if params[:post][:place_ids].present?
      selected_postables += Place.where(id: params[:post][:place_ids])
    end
  
    if params[:post][:event_ids].present?
      selected_postables += Event.where(id: params[:post][:event_ids])
    end
  
    if selected_postables.present?
      selected_postables.each do |postable|
        post = Post.new(
          title: params[:post][:title],
          body: params[:post][:body],
          user: current_user,
          postable: postable
        )
  
        if params[:post][:tag_list].present?
          tag_names = params[:post][:tag_list].is_a?(Array) ? params[:post][:tag_list] : params[:post][:tag_list].split(',').map(&:strip).uniq
          tag_names.each do |name|
            tag = Tag.find_or_create_by(name: name)
            post.tags << tag unless post.tags.include?(tag)
          end
        end
  
        unless post.save
          flash.now[:alert] = "投稿に失敗しました: #{post.errors.full_messages.join(', ')}"
          @places = Place.all
          @events = Event.all
          @tags = Tag.all
          render :new and return
        end
      end
  
      redirect_to posts_path, notice: "投稿に成功しました"
    else
      flash.now[:alert] = "場所またはイベントを選択してください"
      @places = Place.all
      @events = Event.all
      @tags = Tag.all
      render :new
    end
  end

  
  def index
    @posts = Post.all
  
    if params[:tag_name].present?
      @posts = @posts.joins(:tags).where(tags: { name: params[:tag_name] }).distinct
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts
    end
  
    @posts = @posts.includes(:user).order(created_at: :desc).page(params[:page]).per(6)
  end

  def show
    @post = Post.find(params[:id])
    @postable = @post.postable
    @reviews = Review.all
    @tags = Tag.all
    
    unless @postable.present?
      flash[:alert] = "関連情報が見つかりません。"
      redirect_to posts_path
    end
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
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :postable_type, tag_list: [], place_ids: [], event_ids: [])
  end

  def current_post_user
    post = Post.find(params[:id])
    unless current_user == post.user
      redirect_to posts_path, alert: "他のユーザーの投稿を編集することはできません"
    end
  end
  
end
