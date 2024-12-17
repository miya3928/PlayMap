class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @commetable = find_commetable
    @comment = @commetable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      # 成功した場合は、コメント一覧とフォームの部分テンプレートをレンダリング
      respond_to do |format|
        format.js   # create.js.erb を呼び出す
      end
    else
      # 失敗した場合
      redirect_to @commetable, alert: 'コメントの投稿に失敗しました。'
    end
  end

  private

  def find_commetable
    params[:commetable_type].constantize.find(params[:commetable_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end