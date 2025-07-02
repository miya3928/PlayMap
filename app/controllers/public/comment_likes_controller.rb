class Public::CommentLikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.find(params[:comment_id])
    current_user.comment_likes.find_or_create_by(comment: @comment)

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    current_user.comment_likes.find_by(comment: @comment)&.destroy

    respond_to do |format|
      format.js
    end
  end
end