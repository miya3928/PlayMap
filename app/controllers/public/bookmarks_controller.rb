class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bookmark, only: [:destroy]

  def create
    @bookmarkable = find_bookmarkable
    @bookmark = @bookmarkable.bookmark.new(bookmark_params)
    @bookmark.user = current_user
  
    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to @bookmarkable, notice: 'ブックマークを追加しました。' }
        format.js   # 成功時にJSレスポンスを返す
      else
        format.html { render 'public/posts/show', alert: 'ブックマークの追加に失敗しました。' }
        format.js   # 失敗時にもJSレスポンスを返す
      end
    end
  end

  def destroy
    if @bookmark.destroy
      respond_to do |format|
        format.html { redirect_to @bookmark.bookmarkable, notice: 'ブックマークを削除しました。' }
        format.js   # 成功時にJSレスポンスを返す
      end
    else
      respond_to do |format|
        format.html { redirect_to @bookmark.bookmarkable, alert: 'ブックマークの削除に失敗しました。' }
        format.js   # 失敗時にもJSレスポンスを返す
      end
    end
  end

  private

  def find_bookmarkable
    bookmarkable_type = params[:bookmark][:bookmarkable_type]
    bookmarkable_id = params[:bookmark][:bookmarkable_id]

    Rails.logger.debug "bookmarkable type: #{bookmarkable_type}, id: #{bookmarkable_id}"

    if bookmarkable_type.present? && bookmarkable_id.present?
      bookmarkable_type.constantize.find(bookmarkable_id)
    else
      raise ActiveRecord::RecordNotFound, "Invalid bookmarkable type or id"
    end  
  end

  def set_bookmark
    @bookmark = bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:bookmarkable_type, :bookmarkable_id)
  end
end