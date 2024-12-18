class Public::CommentsController < ApplicationController
  before_action :authenticate_user!


def create
  @commetable = find_commetable
  @comment = @commetable.comments.new(comment_params)
  @comment.user = current_user

  if @comment.save
    respond_to do |format|
      format.js { render 'create' }
    end
  else
    respond_to do |format|
      format.js { render 'create' }
    end
  end
end

  private

  def find_commetable
    commetable_type = params[:comment][:commetable_type]
    commetable_id = params[:comment][:commetable_id]

    Rails.logger.debug "Commetable type: #{commetable_type}, id: #{commetable_id}"

    if commetable_type.present? && commetable_id.present?
      commetable_type.constantize.find(commetable_id)
    else
      raise ActiveRecord::RecordNotFound, "Invalid commetable type or id"
    end  
  end

  def comment_params
    params.require(:comment).permit(:body, :commetable_type, :commetable_id)
  end
end