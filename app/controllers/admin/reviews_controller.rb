class Admin::ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    @reviews = Review.includes(:post).order(created_at: :desc).page(params[:page]).per(6)
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to admin_reviews_path, notice: "レビューを削除しました。"
  end
end
