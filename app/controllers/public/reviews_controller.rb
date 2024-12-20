class Public::ReviewsController < ApplicationController
 before_action :set_post
 before_action :authenticate_user!

  def new
    @review = @post.reviews.new
  end  

  def create
    @review = @post.reviews.new(review_params)
    @review.user = current_user
    
    if @review.save
      redirect_to post_path(@post), notice: "レビューを投稿しました。"
    else
      flash.now[:alert] = "レビューの投稿に失敗しました。"
      render :new
    end
  end

  def index
    @reviews = Review.includes(:post).order(created_at: :desc).page(params[:page]).per(6)
  end
  
  def show
    @review = Review.find(params[:id])
    rescue ActiveRecord::RecordNotFound
     redirect_to post_path(params[:post_id]), alert: "指定されたレビューが見つかりません。"
  end
  
  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to post_review_path(@review.post, @review), notice: "レビューを更新しました。"
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @review = @post.reviews.find(params[:id])
    if @review.user == current_user
      @review.destroy
      redirect_to @post, notice: "レビューを削除しました。"
    else 
      redirect_to @post, alert: "削除する権限がありません"
    end    
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end  

  def review_params
    params.require(:review).permit(:score,:body)
  end 
end
