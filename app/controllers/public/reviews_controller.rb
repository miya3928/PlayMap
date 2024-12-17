class Public::ReviewsController < ApplicationController
before_action :set_post

  def new
    @review = Review.new
  end  

  def create
    @review = @post.reviews.new(review_params)
    @review.user = current_user
    
    if @review.save
      redirect_to @post, notice: "レビューを投稿しました"
    else
      redirect_to @post, alert: "レビューの投稿に失敗しました" 
    end   
  end

  def index
    @reviews = Review.includes(:post).order(created_at: :desc).page(params[:page]).per(6)
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
    @post = Post.find(params[:post_id])
  end  

  def review_params
    params.require(:review).permit(:score,:body)
  end 
end
