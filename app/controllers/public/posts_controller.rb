class Public::PostsController < ApplicationController
  before_action :guest_check, only: [:create, :update, :destroy, :new]
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

        # 画像がアップロードされている場合、保存
        post.image.attach(params[:post][:image]) if params[:post][:image].present?

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
    @posts = Post.preload(:reviews, :tags, :postable)
  
    # 絞り込み
    if params[:tag_id].present?
      @posts = @posts.joins(:tags).where(tags: { id: params[:tag_id] }).distinct
    end
  
    if params[:place_id].present?
      @posts = @posts.where(postable_id: params[:place_id], postable_type: "Place")
    end
  
    if params[:event_id].present?
      @posts = @posts.where(postable_id: params[:event_id], postable_type: "Event")
    end
  
    # ソート機能
    case params[:sort]
    when "newest"
      @posts = @posts.order(created_at: :desc)
    when "oldest"
      @posts = @posts.order(created_at: :asc)
    when "highest"
      @posts = @posts.left_joins(:reviews).group("posts.id").order(Arel.sql("COALESCE(AVG(reviews.score), 0) DESC"))
    when "lowest"
      @posts = @posts.left_joins(:reviews).group("posts.id").order(Arel.sql("COALESCE(AVG(reviews.score), 0) ASC"))
    end
  
    # ページネーション
    @posts = @posts.page(params[:page]).per(6)
    @tags = Tag.all
    @places = Place.all
    @events = Event.all
  
    # AJAXリクエストの場合の処理
    respond_to do |format|
      format.html # 通常のHTMLレスポンス
      format.js   # AJAXリクエストの場合のレスポンス
    end
  end


  def show
    @post = Post.find(params[:id])
    @postable = @post.postable
    @reviews = @post.reviews # 変更: 関連レビューのみ取得
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
      flash[:notice] = '投稿が更新されました'
      redirect_to @post
    else
      flash.now[:alert] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = '投稿が削除されました！'
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :postable_type, tag_list: [], place_ids: [], event_ids: [])
  end

  def current_post_user
    post = Post.find(params[:id])
    unless current_user == post.user
      redirect_to posts_path, flash: { alert: "他のユーザーの投稿を編集することはできません" }
    end
  end
end