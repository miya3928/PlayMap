class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @commetable = find_commetable
    @comment = @commetable.comments.new(comment_params)
    @comment.user = current_user
  
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commetable, notice: 'コメントを追加しました。' }
        format.js   # 成功時にJSレスポンスを返す
      else
        format.html { render 'public/posts/show', alert: 'コメントの追加に失敗しました。' }
        format.js   # 失敗時にもJSレスポンスを返す
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