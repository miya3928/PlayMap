class Public::ReviewLikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.find(params[:review_id])
    current_user.review_likes.find_or_create_by(review: @review)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    like = current_user.review_likes.find_by(review: @review)
    like.destroy if like.present?
    respond_to do |format|
      format.js
  end
end

end
